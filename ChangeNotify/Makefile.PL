use ExtUtils::MakeMaker;
use Config;
$BORLAND = 1 if $Config{'cc'} =~ /^bcc32/i;
WriteMakefile(
    'INC'	=> ($BORLAND ? '-I..\IPC' : '-GX -I..\IPC'),
    'NAME'	=> 'Win32::ChangeNotify',
    'VERSION_FROM' => 'ChangeNotify.pm',
    'XS'	=> { 'ChangeNotify.xs' => 'ChangeNotify.cpp' },
    'dist'	=> { COMPRESS => 'gzip -9f', SUFFIX => 'gz' },
);

sub MY::xs_c {
    '
.xs.cpp:
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $*.xs >xstmp.c && $(MV) xstmp.c $*.cpp
';
}

