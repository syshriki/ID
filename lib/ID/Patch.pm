package ID::Patch;

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

    if(! defined $self->getID()){
	return;
    }

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

sub setImpact {
    my $self = shift;
    my ( $impact ) = @_;
    $self->{IMPACT} = $impact;
}

sub getImpact {
    my $self = shift;
    return $self->{IMPACT};
}

sub setTitle {
    my $self = shift;
    my ( $title ) = @_; 
    $self->{TITLE} = $title;
}

sub getTitle {
    my $self = shift;
    return $self->{TITLE};
}

sub setAffected {
    my $self = shift;
    my ( $affected ) = @_;
    $self->{AFFECTED} = $affected;
}

sub getAffected {
    my $self = shift;
    return $self->{AFFECTED};
}

sub setReferences {
    my $self = shift;
    my ( $references ) = @_; 
    $self->{REFERENCES} = $references;
}

sub getReferences {
    my $self = shift;
    return $self->{REFERENCES};
}
1;
