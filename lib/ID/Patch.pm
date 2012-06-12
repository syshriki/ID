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
    return $self;
}

sub setDate{
	my $self = shift;
	my $date = $self->checkUndef(shift); 
	$self->{DATE} = $date;
	
}
sub getDate{
	my $self = shift;
	return ($self->{DATE});	
}
sub setID {
    my $self = shift;
    my $ID = $self->checkUndef(shift);
    $self->{ID} = $ID;
}

sub getID {
    my $self = shift;
    return ($self->{ID});
}

sub setType{
	my $self = shift;
	my $type = $self->checkUndef(shift);
	$self->{TYPE} = $type;
}

sub getType{
	my $self = shift;
	return ($self->{TYPE});
}

sub setDescription {
    my $self = shift;
    my $description = $self->checkUndef(shift);
    $self->{DESCRIPTION} = $description;
}

sub getDescription {
    my $self = shift;
    return ($self->{DESCRIPTION});
}

sub setSeverity {
    my $self = shift;
    my $severity = $self->checkUndef(shift); 
    $self->{SEVERITY} = $severity;
}

sub getSeverity {
    my $self = shift;
    return ($self->{SEVERITY});
}

sub setImpact {
    my $self = shift;
    my $impact = $self->checkUndef(shift);
    $self->{IMPACT} = $impact;
}

sub getImpact {
    my $self = shift;
    return ($self->{IMPACT});
}

sub setTitle {
    my $self = shift;
    my $title = $self->checkUndef(shift); 
    $self->{TITLE} = $title;
}

sub getTitle {
    my $self = shift;
    return ($self->{TITLE});
}

sub setAffected {
    my $self = shift;
    my $affected = $self->checkUndef(shift);
    $self->{AFFECTED} = $affected;
}

sub getAffected {
    my $self = shift;
    return ($self->{AFFECTED});
}

sub setReferences {
    my $self = shift;
    my ( @references ) = @_; 
    @{$self->{REFERENCES}} = @references;
}

sub getReferences {
    my $self = shift;
    return ($self->{REFERENCES});
}

#Checks for undefs and changes the undefs to N/A's to avoid errors when assigning patch items to the value undef
#Arguments: Takes a scalar
#Returns: "Return "N/A" if undef or argument if it's ok
sub checkUndef{
	my $self = shift;
	my $arg = shift;
	if(! defined $arg){
		return "N/A";
	}
	return $arg;
}
1;
