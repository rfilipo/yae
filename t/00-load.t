#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'yae' ) || print "Bail out!
";
}

diag( "Testing yae $yae::VERSION, Perl $], $^X" );
