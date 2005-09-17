use ExtUtils::MakeMaker;

my @libs;
push @libs, '-L/lib/w32api -lole32' if $^O eq "cygwin";

WriteMakefile(
    NAME		=> 'Win32',
    DISTNAME		=> 'libwin32',
    LIBS                => \@libs,
    VERSION_FROM	=> 'Win32.pm',
    'dist'		=> {COMPRESS => 'gzip -9f', SUFFIX => 'gz'},
    ($] < 5.005 ? () :
      (
	ABSTRACT	=> 'A collection of extensions that aims to provide '
			 . 'comprehensive access to the Windows API. ',
	AUTHOR		=> 'Gurusamy Sarathy <gsar@activestate.com>',
      )),
);
