use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'		=> 'Win32::Mutex',
    'VERSION_FROM'	=> 'Mutex.pm',
    ($] < 5.005 ? () :
      (
	'AUTHOR'	=> 'Christopher J. Madsen <cjm@pobox.com>',
	'ABSTRACT_FROM'	=> 'Mutex.pm',
      )),
);
