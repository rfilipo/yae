package p2ee::Controller::Workflow::common;

use warnings;
use strict;
use JSON;
use Workflow::Exception qw( workflow_error );


sub new {
  my $package = shift;
  die "$package requires an even number of parameters" if @_ & 1;
  my $self = bless ({}, $package);
  my %args = @_;
  foreach my $a (keys %args){
    $self->{$a} = $args{$a};
  }
  return $self;
}

# gets p2ee wf extra data
sub get_wf_p2ee {
  my ($self, $c, $wf_id) = @_;
  my $wf_p2ee = undef;
  eval {
    $wf_p2ee = $c->model('inventory::WfP2ee')
      ->find({workflow_id => $wf_id})
    };
  if($@){
    workflow_error "Error getting extra data for wf id '$wf_id': $@";
  }
  return $wf_p2ee;
}

# save wf extra data
sub save_wf_p2ee {
  my ($self, $wf_p2ee, $state_data) = @_;
  eval {
    $wf_p2ee->state_data(to_json($state_data))
  };
  if($@){
    workflow_error "Error setting extra data for wf with: $@";
  }
  eval {
    $wf_p2ee->update()
  };
  if($@){
    workflow_error "Error updating extra data for wf with: $@";
  }
  return 1;
}

sub get_state_data {
  my ($self, $wf_p2ee) = @_;
  my $state_data = undef;
  if($state_data = $wf_p2ee->state_data){
    return from_json($state_data);
  }
  else{
    return { };
  }
}

sub get_dbic_record {
  my ($self, $c, $model, $key, $params) = @_;
  my $dbic_rec = undef;
  if($key == 0){
    eval{
      $dbic_rec = $c->model($model)
        ->create($params)
      };
  }
  else{
    eval{
      $dbic_rec = $c->model($model)
        ->find({id => $key})
      };
  }
  if($@){
    workflow_error "Find $model failed with $@";
  }
  return $dbic_rec;
}

sub get_dbic_records {
  my ($self, $c, $model, $cond) = @_;
  my $dbic_recs = undef;
  eval{
    $dbic_recs = $c->model($model)
      ->search($cond)
    };
  if($@){
    workflow_error "Find $model failed with $@";
  }
  return $dbic_recs;
}

sub save_dbic_record {
  my ($self, $dbic_rec) = @_;
  eval{
    $dbic_rec->update()
  };
  if($@){
    workflow_error "DBIC record update failed with $@";
  }
  return 1;

}



1;
