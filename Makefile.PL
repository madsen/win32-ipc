use ExtUtils::MakeMaker;
WriteMakefile(
	NAME => 'Win32',
	DISTNAME => 'libwin32',
	VERSION_FROM => 'Win32.pm',
	'dist' => {COMPRESS => 'gzip -9f', SUFFIX => 'gz'}
);
