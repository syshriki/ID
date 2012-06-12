package ID::PatchParser::RHEL;
use strict;
use warnings;

use ID::Patch;
use ID::Utilities;
use base "ID::PatchParser";

sub createPatchObject {
    my $self = shift;
    my $URL = $self->getFilename();
    my @headers = qw(Severity Advisory Synopsis Date);
    my $parse = new ID::Utilities();
    my @parsedData = $parse->parseHTMLTable($URL, \@headers);
    my @patchObject = ();
    my $patch;
    foreach my $dataRow ( @parsedData ) {
        $patch = new ID::Patch();
            $patch->setSeverity(shift @$dataRow);
            $patch->setID(shift @$dataRow);
            $patch->setDescription(shift @$dataRow);
            $patch->setDate(shift @$dataRow);
            $patch->setType("Security");
        push ( @patchObject, $patch );
    }
    return @patchObject;
}

1;
