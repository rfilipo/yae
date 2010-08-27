package p2ee::Controller::Workflow::Action::InputField::p2ee;

use warnings;
use strict;

use base qw( Workflow::Action::InputField );
use Workflow::Exception qw( workflow_error );

# extra action class properties
my @EXTRA_PROPS = qw( index display value );
__PACKAGE__->mk_accessors(@EXTRA_PROPS);


sub new {
  my ( $class, $params ) = @_;
  my $self = $class->SUPER::new($params);

  # set our extra properties
  foreach my $prop (@EXTRA_PROPS) {
    next if ( $self->$prop );
    $self->$prop( $params->{$prop} );
  }

  # override 'basic' field type
  $self->type($params->{type});

  return $self;
}

1;
