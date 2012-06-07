package ID::PatchParser;
use strict;
use warnings;

sub new {
    my ( $invocant ) = shift;
    my ( $class ) = ref ( $invocant ) || $invocant;
    my ( $self ) = {
        @_,
        };
    bless ( $self, $class );

    if(! defined $self->getFilename()){
	return;
    }

    return $self;
}

sub getFilename{
	my $self = shift;
	my $filename = $self->{FILENAME};
	return $filename;
}

sub getUnparsed{
	my $self = shift;
	my $unparsed = $self->{UNPARSED};
	return $unparsed;
}

sub setUnparsed{
	my $self = shift;
	my $unparsed = shift;
	$self->{UNPARSED} = $unparsed;
}

sub Parse{

	return undef
}

1;
