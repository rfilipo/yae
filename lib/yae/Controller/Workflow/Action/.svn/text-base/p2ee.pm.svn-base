package p2ee::Controller::Workflow::Action::p2ee;

use warnings;
use strict;
use p2ee::Controller::Workflow::common;

use base qw( Workflow::Action );
use Workflow::Exception qw( workflow_error );

# extra action class properties
my @EXTRA_PROPS = qw( index icon type data );
__PACKAGE__->mk_accessors(@EXTRA_PROPS);

sub new {
  my ($class, $wf, $params) = @_;
  my $self = $class->SUPER::new($wf, $params);
  # set only our extra properties from action class def
  foreach my $prop (@EXTRA_PROPS) {
    next if ( $self->$prop );
    $self->$prop( $params->{$prop} );
  }
  # override specific extra action properties according to state
  my $wf_state = $wf->_get_workflow_state;
  my $action = $wf_state->{_actions}->{$self->name};
  $self->index($action->{index});

  $self->{common} = p2ee::Controller::Workflow::common->new();

  return $self;
}

# gets p2ee wf extra data
sub get_wf_p2ee {
  my ($self, $c, $wf_id) = @_;
  return $self->{common}->get_wf_p2ee($c, $wf_id);
}

sub save_wf_p2ee {
  my ($self, $wf_p2ee, $state_data) = @_;
  return $self->{common}->save_wf_p2ee($wf_p2ee, $state_data);
}

sub get_state_data {
  my ($self, $wf_p2ee) = @_;
  return $self->{common}->get_state_data($wf_p2ee);
}

sub get_dbic_record {
  my ($self, $c, $model, $key, $params) = @_;
  return $self->{common}->get_dbic_record($c, $model, $key, $params);
}

sub get_dbic_records {
  my ($self, $c, $model, $key, $cond) = @_;
  return $self->{common}->get_dbic_records($c, $model, $cond);
}

sub save_dbic_record {
  my ($self, $dbic_rec) = @_;
  return $self->{common}->save_dbic_record($dbic_rec);
}


1;
