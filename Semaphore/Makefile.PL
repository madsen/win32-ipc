use ExtUtils::MakeMaker;
WriteMakefile(
    'INC'	=> '-GX -I..\IPC',
    'NAME'	=> 'Win32::Semaphore',
    'VERSION_FROM' => 'Semaphore.pm',
    'XS'	=> { 'Semaphore.xs' => 'Semaphore.cpp' },
    'dist'	=> { COMPRESS => 'gzip -9f', SUFFIX => 'gz' },
    'dynamic_lib' => { 'OTHERLDFLAGS' => q[] },
);

sub MY::xs_c {
    '
.xs.cpp:
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $*.xs >xstmp.c && $(MV) xstmp.c $*.cpp
';
}

sub MY::c_o {
    '
.cpp$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) -I$(PERL_INC) $(DEFINE) -Tp$*.cpp
';
}
