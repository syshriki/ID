package ID::PatchParser;
use strict;
use warnings;

###############################################################################
# new (constructor)
###############################################################################

sub new {
    my ( $invocant ) = shift;
    my ( $class ) = ref ( $invocant ) || $invocant;

    my ( $self ) = {
        @_,
    };

    bless ( $self, $class );

    if ( ! defined $self->getFilename() ) {
        return;
    }

    return $self;
}

###############################################################################
# Method: getFilename()
# -Retrieve name (File or URL) of unparsed data
###############################################################################

sub getFilename {
    my $self = shift;
    my $filename = $self->{FILENAME};
    return $filename;
}

###############################################################################
# Method: createPatchObject()
# -Create patch object (overridden by vendor specific PatchParse classes)
###############################################################################

sub createPatchObject {
    my $self = shift;
    return undef;
}

1;
