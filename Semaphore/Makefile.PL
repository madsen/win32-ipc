use ExtUtils::MakeMaker;
use Config;
$BORLAND = 1 if $Config{'cc'} =~ /^bcc32/i;
WriteMakefile(
    'INC'	=> ($BORLAND ? '-I..\IPC' : '-GX -I..\IPC'),
    'NAME'	=> 'Win32::Semaphore',
    'VERSION_FROM' => 'Semaphore.pm',
    'XS'	=> { 'Semaphore.xs' => 'Semaphore.cpp' },
    'dist'	=> { COMPRESS => 'gzip -9f', SUFFIX => 'gz' },
);

sub MY::xs_c {
    '
.xs.cpp:
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $*.xs >xstmp.c && $(MV) xstmp.c $*.cpp
';
}
