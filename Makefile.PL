use ExtUtils::MakeMaker;
WriteMakefile(
	NAME => 'Win32',
	DISTNAME => 'libwin32',
	VERSION => '0.06',
	'dist' => {COMPRESS => 'gzip -9f', SUFFIX => 'gz'}
);
