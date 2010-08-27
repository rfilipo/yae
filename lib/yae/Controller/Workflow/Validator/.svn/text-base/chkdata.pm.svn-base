package p2ee::Controller::Workflow::Validator::chkdata;


use warnings;
use strict;
use base qw( Workflow::Validator );
use Workflow::Exception qw( validation_error );


sub validate {
  my ( $self, $wf, $reference ) = @_;

  validation_error "Reference field contains invalid characters!"
    if($reference =~ m/[*&%$'"]/g);

}

1;

