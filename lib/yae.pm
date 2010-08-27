package yae;

use warnings;
use strict;

=head1 NAME

yae - yet another erp

=head1 VERSION

Version 0.01_01

=cut

our $VERSION = '0.01_01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use yae;

    my $erp = yae->new();

=head1 ATTRIBUTES

All attributes for yae will be on the global context object.

     $c->{class} = 'Customer';
     my $element = $erp->rsc($c)->element(id);

=cut

our $c = {};

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Monsenhor, C<< <ricardo.filipo at kobkob.com.br> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-yae at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=yae>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc yae


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=yae>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/yae>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/yae>

=item * Search CPAN

L<http://search.cpan.org/dist/yae/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Monsenhor.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of yae
