use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'		=> 'Win32::Mutex',
    'VERSION_FROM'	=> 'Mutex.pm',
    ($] < 5.005 ? () :
      (
	'AUTHOR'	=> 'Christopher J. Madsen <ac608@yfn.ysu.edu>',
	'ABSTRACT_FROM'	=> 'Mutex.pm',
      )),
);
