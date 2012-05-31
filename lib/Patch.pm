package Patch;

use strict;
use warnings;

#Contructor
sub new {
    my ( $invocant ) = shift;
    my ( $class ) = ref ( $invocant ) || $invocant;
    my ( $self ) = {
        @_,
        };
    bless ( $self, $class );

    return $self;
}

sub setDate{
	my $self = shift;
	my ( $date ) = @_; 
	$self->{DATE} = $date;
	
}
sub getDate{
	my $self = shift;
	return $self->{DATE};	
}
1;
