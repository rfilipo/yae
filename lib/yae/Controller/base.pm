package yae::Controller::base;

use strict;
use warnings;
use Carp;

use yae::Controller::util;

sub new {
  my $selflass = shift;
  my $self = {@_};
  bless ($self, $selflass);
  return $self;
}

sub element {
   croack('Sou abstrato!!!! Me implemente');
}

sub colection {
   croack('Sou abstrato!!!! Me implemente');
}


=head1 AUTHOR

Monsenhor

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
