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

    if ( ! defined $self->getUnparsed()) {
                 return;
    }

    return $self;
}

sub getUnparsed{
	my $self = shift;
	my $unparsed = $self->{UNPARSED};
	return $unparsed;
}

sub Parse{

	return undef
}

1;
