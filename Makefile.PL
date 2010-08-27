use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'yae',
    AUTHOR              => q{Monsenhor <ricardo.filipo@kobkob.com.br>},
    VERSION_FROM        => 'lib/yae.pm',
    ABSTRACT_FROM       => 'lib/yae.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'yae-*' },
);
