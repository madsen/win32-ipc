use ExtUtils::MakeMaker;

my @libs;
push @libs, '-L/lib/w32api -lole32' if $^O eq "cygwin";

WriteMakefile(
    NAME		=> 'libwin32',
    PMLIBDIRS           => ['Bundle'],
    LIBS                => \@libs,
    NO_META             => 1,
    VERSION_FROM	=> 'Bundle/libwin32.pm',
    'dist'		=> {COMPRESS => 'gzip -9f', SUFFIX => 'gz'},
    ($] < 5.005 ? () :
      (
	ABSTRACT	=> 'Comprehensive access to the Windows API.',
	AUTHOR		=> 'Jan Dubois <jand@activestate.com>',
      )),
);
