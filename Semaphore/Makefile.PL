use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'		=> 'Win32::Semaphore',
    'VERSION_FROM'	=> 'Semaphore.pm',
    ($] < 5.005 ? () :
      (
	'AUTHOR'	=> 'Christopher J. Madsen <ac608@yfn.ysu.edu>',
	'ABSTRACT_FROM'	=> 'Semaphore.pm',
      )),
);
