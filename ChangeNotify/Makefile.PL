use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'		=> 'Win32::ChangeNotify',
    'VERSION_FROM'	=> 'ChangeNotify.pm',
    ($] < 5.005 ? () :
      (
	'AUTHOR'	=> 'Christopher J. Madsen <ac608@yfn.ysu.edu>',
	'ABSTRACT_FROM'	=> 'ChangeNotify.pm',
      )),
);
