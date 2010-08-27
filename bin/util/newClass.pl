#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  newClass.pl
#
#        USAGE:  ./newClass.pl  
#
#  DESCRIPTION:  Creates a new Moose class
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Ricardo Filipo (rf), ticardo.filipo@gmail.com
#      COMPANY:  Mito-Lógica design e soluções de comunicação ltda
#      VERSION:  1.0
#      CREATED:  23-08-2010 15:01:04
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

my $template = "
package $package;

  use Moose;
  use namespace::autoclean;

  # extends, roles, attributes, etc.

  # methods

  __PACKAGE__->meta->make_immutable;

  1;
";
