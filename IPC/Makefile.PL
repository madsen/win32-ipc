use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'		=> 'Win32::IPC',
    'VERSION_FROM'	=> 'IPC.pm', # finds $VERSION
    ($] < 5.005 ? () :
      (
	'AUTHOR'	=> 'Christopher J. Madsen <ac608@yfn.ysu.edu>',
	'ABSTRACT_FROM'	=> 'IPC.pm',
      )),
);
