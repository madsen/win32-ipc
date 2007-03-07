use ExtUtils::MakeMaker;

my @libs;
push @libs, '-L/lib/w32api -lole32' if $^O eq "cygwin";

WriteMakefile(
    NAME		=> 'libwin32',
    LIBS                => \@libs,
    VERSION		=> '0.27',
    'dist'		=> {COMPRESS => 'gzip -9f', SUFFIX => 'gz'},
    ($] < 5.005 ? () :
      (
	ABSTRACT	=> 'A collection of extensions that aims to provide '
			 . 'comprehensive access to the Windows API. ',
	AUTHOR		=> 'Jan Dubois <jand@activestate.com>',
      )),
);
