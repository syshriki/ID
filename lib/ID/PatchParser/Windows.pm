package ID::PatchParser::Windows;
use strict;
use warnings;

sub new {
    my ( $invocant ) = shift;
    my ( $class ) = ref ( $invocant ) || $invocant;
    my ( $self ) = {@_};

    bless ( $self, $class );


    return $self;
}

1;
