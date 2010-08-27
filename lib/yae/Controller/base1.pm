package yae::Controller::base;

use strict;
use warnings;
use parent qw( Catalyst::Controller::REST );

use yae::Controller::ber;
use yae::Controller::bpr;
use yae::Controller::util;


sub index :Local :ActionClass('REST') {
  my ( $self, $c ) = @_;
  unless($c->forward('check_headers')){
    $self->status_bad_request(
      $c,
      message => 'BAD HEADERS',
    );
    return;
  }
}

sub index_GET {
  my ( $self, $c ) = @_;
}


sub collection :Local :ActionClass('REST') {
  my ( $self, $c ) = @_;
  unless($c->forward('check_headers')){
    $self->status_bad_request(
      $c,
      message => 'BAD HEADERS',
    );
    return;
  }
}

sub collection_GET {
  my ( $self, $c ) = @_;

  # Resource type
  my $rtype = $c->stash->{rtype} || 'BER';

  my $entity = undef;

  #Business Element Resource
  if($rtype eq 'BER'){
    my $ber = yae::Controller::ber->new($c);
    $entity = $ber->collection();
  }
  #Business Process Resource
  elsif($rtype eq 'BPR'){
    my $bpr = yae::Controller::bpr->new($c);
    $entity = $bpr->collection();
  }
  else{
    my $msg = $c->localize('Resource Type not Defined');
    $self->status_bad_request(
      $c,
      message => $msg,
    );
    $c->stash->{msg} = $msg;
  }

  if($entity){
    $self->status_ok(
      $c,
      entity => $entity,
    );
  }
  else{
    my $msg = $c->localize('Empty collection!');
    $c->stash->{msg} = $msg;
    $self->status_not_found(
      $c,
      message => $msg
    );
  }

}


sub element :Local :ActionClass('REST') {
  my ( $self, $c ) = @_;
  unless($c->forward('check_headers')){
    $self->status_bad_request(
      $c,
      message => 'BAD HEADERS',
    );
    return;
  }
}


sub element_GET {
  my ( $self, $c, $id, $detail ) = @_;


  # Resource type
  my $rtype = $c->stash->{rtype} || 'BER';

  my $entity = undef;

  #Business Element Resource with DBIC
  if($rtype eq 'BER'){
    my $ber = yae::Controller::ber->new($c);
    $entity = $ber->element($id,$detail);
  }
  #Business Process Resource with Workflow
  elsif($rtype eq 'BPR'){
    my $bpr = yae::Controller::bpr->new($c);
    if($bpr->{exception}){
      $entity = $bpr;
    }
    else{
      $entity = $bpr->element($id);
    }
  }
  else{
    my $msg = $c->localize('Resource Type not Defined');
    $self->status_bad_request(
      $c,
      message => $msg,
    );
    $c->stash->{msg} = $msg;
  }

  if($entity){
    unless($entity->{exception}){
      $self->status_ok(
        $c,
        entity => $entity,
      );
    }
    else{
      #FIXME: standardize 500 codes for different types of errors
      warn "***** TEMPORARY BAD REQUEST, SHOULD BE 50x *****";
      $self->status_bad_request(
        $c,
        message => $entity->{msg},
      );
    }
  }
  else{
    my $msg = $c->localize('Cannot find element!');
    $c->stash->{msg} = $msg;
    $self->status_not_found(
      $c,
      message => $msg
    );
  }

}

sub element_PUT {
  my ( $self, $c, $id ) = @_;

  # Resource type
  my $rtype = $c->stash->{rtype} || 'BER';

  my $entity = undef;

  #Business Element Resource with DBIC
  if($rtype eq 'BER'){
    my $ber = yae::Controller::ber->new($c);
    $entity = $ber->update($id);
  }
  #Business Process Resource with Workflow
  elsif($rtype eq 'BPR'){
    my $bpr = yae::Controller::bpr->new($c);
    $entity = $bpr->update($id);
  }
  else{
    my $msg = $c->localize('Resource Type not Defined');
    $self->status_bad_request(
      $c,
      message => $msg,
    );
    $c->stash->{msg} = $msg;
  }

  if($entity){
    unless($entity->{exception}){
      $self->status_ok(
        $c,
        entity => $entity,
      );
    }
    else{
      #FIXME: should this not be in the 500 range?
      warn "***** DOING A BAD REQUEST *****";
      $self->status_bad_request(
        $c,
        message => $entity->{msg},
      );
    }
  }
  else{
    my $msg = $c->localize('Cannot find element!');
    $c->stash->{msg} = $msg;
    $self->status_not_found(
      $c,
      message => $msg
    );
  }


}

sub element_DELETE {
  my ( $self, $c, $id ) = @_;


  my $model = $c->stash->{model};
  my $class = $c->stash->{class};
  my $element = $c->model($model.'::'.$class)->find({id => $id});

  unless($element){
    my $msg = $c->localize('Cannot find element!');
    $self->status_not_found(
      $c,
      message => $msg
    );
    $c->stash->{msg} = $msg;
    return;
  }

  eval{
    $element->delete;
  };

  unless($@){
    my $msg = $c->localize('Element deleted from system');
    $self->status_ok(
      $c,
      entity => {msg => $msg}
    );
    $c->stash->{msg} = $msg;
  }
  else{
    my $errstr = $c->config->{dbix_errors}?"$@":"DB ERROR";
    my $msg = $c->localize('Could not delete element:').$errstr;
    $self->status_bad_request(
      $c,
      message => $msg,
    );
    $c->stash->{msg} = $msg;
  }

}

sub element_POST {
  my ( $self, $c, $id ) = @_;

  # PUT and DELETE emulation over POST
  if ($c->req->param('PUT')) {
    &element_PUT($self, $c, $id);
  }
  elsif ($c->req->param('DELETE')) {
    &element_DELETE($self, $c, $id);
  }
  # actual POST
  else {

    my $model = $c->stash->{model};
    my $class = $c->stash->{class};

    my $ber = yae::Controller::ber->new($c);
    my $cpars = $ber->get_cpars();
    delete $cpars->{id};

    my $element = undef;
    eval{
      $element = $c->model($model.'::'.$class)->create($cpars);
    };

    if ($element) {
      $c->stash->{element} = $element;
      $self->status_created(
        $c,
        #FIXME: this element/ url seems odd...
        location => $c->uri_for('element/'.$element->id),
        entity => {element => $ber->mk_element_entity($element)},
      );
    }
    else {
      my $errstr = $c->config->{dbix_errors}?"$@":"DB ERROR";
      my $msg = $c->localize('Could not create element:').$errstr;
      $c->stash->{msg} = $msg;
      $self->status_bad_request(
        $c,
        message => $msg,
      );
    }
  }

}


sub check_headers : Private {
  my ( $self, $c ) = @_;

  my $accept = $c->req->header('accept');
  return undef unless $accept;

  if($accept =~ m/html/){
    $c->req->header('accept' => 'text/html');

  }
  elsif($accept =~ m/xml/){
    $c->req->header('accept' => 'text/xml');
    #TODO: fix TT XML Option 
    #(need to dynamically change the controller's config)
    $c->stash->{template} = $c->action.'.xml';
  }

  return 1;

}




=head1 AUTHOR

Alejandro Imass,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
