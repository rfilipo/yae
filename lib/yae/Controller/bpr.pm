package p2ee::Controller::bpr;

use warnings;
use strict;
use Workflow::Factory qw( FACTORY );
use Date::Calc qw(Today_and_Now);
use p2ee::Controller::Workflow::Action::InputField::p2ee;


#From the Workflow::Factory pod:
#Note that you need to manage any
#Workflow::Persister::DBI::ExtraData transactions yourself.


sub new {
  my $package = shift;
  my $c = shift;

  my $self = { };


  my $type = $c->stash->{wftype};

  $self->{c} = $c;
  $self->{type} = $type;

  #TODO: find Catalyst's controller path
  my $base = $c->config->{wf_path};

  # load generic wf conf
  eval{FACTORY->add_config_from_file(
    condition => "$base/Workflow/common/condition.xml",
    action    => "$base/Workflow/common/action.xml",
    validator => "$base/Workflow/common/validator.xml",
  )};

  # load specific wf conf
  eval{FACTORY->add_config_from_file(
    workflow  => "$base/Workflow/$type/main.xml",
    condition => "$base/Workflow/$type/condition.xml",
    action    => "$base/Workflow/$type/action.xml",
    validator => "$base/Workflow/$type/validator.xml",
    persister => "$base/Workflow/persister.xml",
  )};

  return &exception($self,$@) if($@);

  bless($self,$package);
  return $self;

}

# gets root actions for user (main actions menu)
sub get_root_actions {
  my $self = shift;

  my $c = $self->{c};
  my $type = $self->{type};
  my $userid = $c->stash->{userid};

  # Note: WfUser is a View
  my @wfs = $c->model('inventory::WfUser')->search(
    {
      type => $type,
      creator => $userid,
    }
  );

  my $wf = undef;

  # fetch existing root wf or create it
  if(@wfs){
    # fecth existing wf (only 1 root wf can exist)
    unless(scalar @wfs > 1){
      $wf = FACTORY->fetch_workflow($type,$wfs[0]->id);
    }
    else {
      return $self->exception("ERROR: More than one root wf for user $userid");
    }
  }
  else{
    $wf = $self->create_wf();
  }


  #TODO: handle exceptions here for example: unless($wf)...

  # make catalyst available through wf context
  my $context = $wf->context;
  $context->param(catalyst => $c);

  my $actions = $self->mk_element_entity($wf)->{actions};

  #TODO: Formal debug/log mech
  #use Data::Dumper;
  #warn "ABOUT TO RETURN ACTIONS:".Dumper($actions);

  return $actions;

}

sub get_open_wfs {
  my $self = shift;

  my $c = $self->{c};
  my $type = $self->{type};
  my $userid = $c->stash->{userid};

  my @wfs = $c->model('inventory::WfUser')->search(
    {
      -and => [
        type => { '!=', 'root'},
        state => { '!=', 'CLOSED' },
        -or => [
          creator => $userid,
          citho => $userid
        ],
      ],
    }
  );

  return \@wfs;

}



sub element {
  my $self = shift;
  my $id = shift;

  my $c = $self->{c};
  my $wf = undef;

  if($id){
    eval{$wf = FACTORY->fetch_workflow($self->{type},$id)};
    return $self->exception($@) if($@);
  }
  else{
    eval{$wf = $self->create_wf()};
    return $self->exception($@) if($@);
  }

  if($wf){
    # make catalyst available through wf context
    my $context = $wf->context;
    $context->param(catalyst => $c);

    my $element = $self->mk_element_entity($wf);

    return $element if $element->{exception};

    $c->stash->{element} = $element;

    my $entity = {
      element => $c->stash->{element},
    };

    #TODO: Formal debug/log mech
    #use Data::Dumper;
    #warn "ABOUT TO RETURN BPR:".Dumper($entity);

    return $entity;

  }
  else{
    $c->stash->{element} = undef;
    return undef;
  }

}

# workflows are updated through actions
sub update {
  my $self = shift;
  my $id = shift;
  my $c = $self->{c};

  return $self->exception('ID is  Required to Update a BPR')
    unless $id;

  my $wf = FACTORY->fetch_workflow($self->{type},$id);

  return $self->exception("Could not fetch BPR with ID '$id'")
    unless $wf;

  # make catalyst available through wf context
  my $context = $wf->context;
  $context->param(catalyst => $c);

  # validate action and get fields
  my $state = $wf->state;
  my $action =  $c->req->param('action');

  my $fields = $self->valid_action($wf, $action);
  unless($fields){
    my $err = "Action '$action' not valid for state '$state'";
    return $self->exception($err)
  }

  # action has or needs fields to execute
  if(ref($fields) eq 'ARRAY'){
    my $cpars = $self->get_cpars($fields);
    unless(ref($cpars)){
      my $err = "Field '$cpars' is required to execute '$action'";
      return $self->exception($err);
    }
    map {$context->param($_ => $cpars->{$_})} keys %$cpars;
  }

  eval{$wf->execute_action($action)};

  return $self->exception("Could not perform '$action', server says:  $@")
    if $@;

  $c->stash->{element} = $self->mk_element_entity($wf);
  $c->stash->{updated_element} = 1;

  my $entity = {
    element => $c->stash->{element},

  };

  return $entity;

}

sub exception {
  my $self = shift;
  my $msg = shift;
  my $c = $self->{c};
  $c->stash->{msg} = $c->localize($msg);

  #TODO: formalize syslog
  warn "BPR EXCEPTION: $msg";

  my $entity = {
    exception => 1,
    msg => $c->stash->{msg},
  };

  return $entity;
}

# verifies valid action for this state and returns fields
sub valid_action {
  my $self = shift;
  my $wf = shift;
  my $action = shift;
  my @actions = $wf->get_current_actions;
  foreach(@actions){
    if($_ eq $action){
      my @fields = $wf->get_action_fields($action);
      if(@fields){
        return \@fields;
      }
      else{
        return $action;
      }
    }
  }
  return undef;
}


# fetches request parameters that match action fields
# returns scalar on error, array on success
sub get_cpars {
  my $self = shift;
  my $fields = shift;
  my $c = $self->{c};

  my $cpars = { };
  foreach my $field (@$fields){
    my $fname = $field->name;
    my $ftype = $field->type;
    $cpars->{$fname} = $c->req->param($fname);
    # required field
    unless(defined $cpars->{$fname}){
      # boolean assumed false
      if($ftype eq 'boolean'){
        $cpars->{$fname} = 'f';
      }
      elsif($field->is_required eq 'yes'){
        return $fname;
      }
    }
  }
  return $cpars;
}


# UTILITY FUNCTIONS


sub create_wf {
  my $self = shift;

  my $c = $self->{c};

  my $userid = $c->stash->{userid};


  my $wf = FACTORY->create_workflow($self->{type});
  #extras need to be managed by us
  my ($year,$month,$day,$hour,$min,$sec) = Today_and_Now();
  my $ts = "$year-$month-$day $hour:$min:$sec";
  my $wf_p2ee = $c->model('inventory::WfP2ee')->create(
    {
      workflow_id => $wf->id,
      creator => $userid,
      citho => $userid,
      citho_since => $ts,
      memo => $c->stash->{memo},
    }
  );

  return $wf;

}

# returns a bpr element (a Workflow State)
sub mk_element_entity {
  my $self = shift;
  my $wf = shift;
  my $c = $self->{c};
  my $e = { };

  my $context = $wf->context;

  $e->{id} = $wf->id;

  my $state = $wf->_get_workflow_state;

  return $self->exception($@) if($@);

  $e->{state} = $state->state;
  $e->{description} = $state->description;
  $e->{description} =~ s/^\s+//;
  $e->{description} =~ s/\s+$//;


  my @actions = ( );
  my @anames = eval {$wf->get_current_actions()};

  return $self->exception($@) if($@);

  foreach my $aname (@anames) {

    # get the action fields
    my @afields = eval {$wf->get_action_fields($aname)};
    return $self->exception($@) if($@);

    # get p2ee required properties
    my @fields = ( );
    foreach my $field (@afields){
      my %f = ( );
      map { $f{$_} = $field->$_ }
        qw( index name label type requirement display );
      push @fields, \%f;
    }

    my $action = undef;
    eval{$action = $wf->_get_action($aname)};
    return $self->exception($@) if($@);
    return $self->exception("Could not fetch action at mk_element_entity") 
      unless $action;

    # p2ee extra wf properties
    my $index = defined $action->index ? $action->index : undef;

    unless(defined $index){
      warn 'p2ee action:'.$action->name.' requires an index';
      $index = 0; #brute safeguard
    }

    #FIXME: create defaults for these
    my $icon = defined $action->icon ? $action->icon : undef;
    my $type = defined $action->type ? $action->type : undef;
    my $data = defined $action->data ? $action->data : undef;

    my $fvalues = $context->param('field_values') || undef;

    my $action_e = {
      index   =>  $index,
      name    =>  $aname,
      icon    =>  $icon,
      type    =>  $type,
      data    =>  $data,
      fields  =>  \@fields || undef,
      fvalues =>  $fvalues,
    };

    # first order
    $actions[$index] = $action_e ;
  }

  # purge holes in array (faster than splice)
  my @ordered_actions = ( );
  for(my $i=0; $i<@actions; $i++){
    my $a = $actions[$i];
    push @ordered_actions, $a if defined($a);
  }

  $e->{actions} = \@ordered_actions;

  #TODO: Formal debug/log mech
  #use Data::Dumper;
  #warn "ABOUT TO RETURN ELEMENT:".Dumper($e);

  return $e;

}


sub mk_element_meta {
  my $self = shift;
  my $element = shift;
  my $c = $self->{c};
}

1;
