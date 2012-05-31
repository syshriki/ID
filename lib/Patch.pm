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
sub setID {
    my $self = shift;
    my ( $ID ) = @_;
    $self->{ID} = $ID;
}

sub getID {
    my $self = shift;
    return $self->{ID};
}

sub setType{
	my $self = shift;
	my ( $type ) = @_;
	$self->{TYPE} = $type;
}

sub getType{
	my $self = shift;
	return $self->{TYPE};
}

sub setDescription {
    my $self = shift;
    my ( $description ) = @_;
    $self->{DESCRIPTION} = $description;
}

sub getDescription {
    my $self = shift;
    return $self->{DESCRIPTION};
}

sub setSeverity {
    my $self = shift;
    my ( $severity ) = @_; 
    $self->{SEVERITY} = $severity;
}

sub getSeverity {
    my $self = shift;
    return $self->{SEVERITY};
}


1;
