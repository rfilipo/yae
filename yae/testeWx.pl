#!/usr/bin/perl
#===============================================================================
#
#         FILE:  teste.pl
#
#        USAGE:  ./teste.pl
#
#  DESCRIPTION:  teste basico da aplicacao no menu about
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Ricardo Filipo (rf), ticardo.filipo@gmail.com
#      COMPANY:  Mito-Lógica design e soluções de comunicação ltda
#      VERSION:  1.0
#      CREATED:  20-08-2010 15:52:44
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use Wx;

print ("SOU UM TESTE\n\n");

my $testevar = 46;

sub showhu{
  print "HUUUUU\n";
  my $app = MyApp->new;
  $app->MainLoop; 
  return 47;
}

package MyFrame;
    
use base 'Wx::Frame';

sub new {
    my $ref = shift;
    my $self = $ref->SUPER::new( undef,           # parent window
                                 -1,              # ID -1 means any
                                 'wxPerl rules',  # title
                                 [20, 30],        # default position
                                 [150, 100],      # size
                                 );

 # controls should not be placed directly inside
    # a frame, use a Wx::Panel instead
    my $panel = Wx::Panel->new( $self,            # parent window
                                -1,               # ID
                                );
    # create a button
    my $button = Wx::Button->new( $panel,         # parent window
                                  -1,             # ID
                                  'Click me!',    # label
                                  [30, 20],       # position
                                  [-1, -1],       # default size
                                  );
}

package MyApp;
    
use base 'Wx::App';
    
sub OnInit {
    my $frame = MyFrame->new;

  $frame->Show( 1 );
  return 1;
}
    
package main;
    
my $app = MyApp->new;
$app->MainLoop;

1;
