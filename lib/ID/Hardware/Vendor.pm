#
#===============================================================================
#
#         FILE:  Vendor.pm
#
#  DESCRIPTION:  ID::Hardware::Vendor - this class represents a hardware vendor
#                and the information about the vendor that is needed for 
#                collecting the patch information
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Philip Foster (pfoster), pfoster@industrialdefender.com
#      COMPANY:  Industrial Defender
#      VERSION:  1.0
#      CREATED:  05/23/2012 08:56:32 AM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

package ID::Hardware::Vendor;


################################################################################
# Method: new (constructor)
################################################################################
sub new {
    my ( $invocant ) = shift;
    my ( $class ) = ref ( $invocant ) || $invocant;

    my ( $self ) = {
        @_,
        };

    bless ( $self, $class );

    if ( ! defined $self->getName() ) {
        # The vendor name must be defined, or we cannot create the object
        return;
    }

    return $self;
}

################################################################################
# Method: getName (getter method)
################################################################################
sub getName {
    my $self = shift;
    return $self->{Name};
}

################################################################################
# Method: setURL (setter)
################################################################################
sub setURL {
    my $self = shift;
    my ( $URL ) = @_;
    $self->{URL} = $URL;
}

################################################################################
# Method: getURL (getter)
################################################################################
sub getURL {
    my $self = shift;
    return $self->{URL};
}

sub getSupportURL {
	my $self = shift;
	return $self->{supportURL};
}

sub setSupportURL {
	my $self = shift;
	my ( $supportURL ) = @_;
	$self->{supportURL} = $supportURL;
}

sub setParserClass{
	my $self = shift;
	my ( $parserClass ) = @_;
	$self->{parserClass} = $parserClass;
}

sub getParserClass{
	my $self = shift;
	return $self->{parserClass};
}
1;
