use ExtUtils::MakeMaker;

WriteMakefile(
	NAME => 'Win32',
	DISTNAME => 'libwin32',
	VERSION_FROM => 'Win32.pm',
	'dist' => {COMPRESS => 'gzip -9f', SUFFIX => 'gz'}
);


package MY;
use Config;
sub post_initialize {
    my $self = shift;
    my @keep;
    my $mingw32 = ($^O eq 'MSWin32') && ($Config{'cc'} =~ /^gcc/i);
    warn "Not all subdirs build with Mingw32\n" if $mingw32;
    foreach my $dir (@{$self->{'DIR'}}) {
	if ($mingw32 && -f "$dir/mingw32.exc") {
	    warn "Skipping $dir on Mingw32\n";
	}
	else {
	    push(@keep,$dir);
	}
    }
    $self->{DIR} = \@keep;
    return $self->SUPER::post_initialize;
}
