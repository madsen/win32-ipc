use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'		=> 'Win32::Event',
    'VERSION_FROM'	=> 'Event.pm',
    ($] < 5.005 ? () :
      (
	'AUTHOR'	=> 'Christopher J. Madsen <ac608@yfn.ysu.edu>',
	'ABSTRACT_FROM'	=> 'Event.pm',
      )),
);
