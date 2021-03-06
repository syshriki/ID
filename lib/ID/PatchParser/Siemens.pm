package ID::PatchParser::Siemens;
use strict;
use warnings;
use ID::Utilities;
use ID::Patch;
use base "ID::PatchParser";

sub createPatchObject {
    my $self = shift;
    my $URL = $self->getFilename();
    my $outfile = "Bulletins/SiemensSecurityPatches.xls";
    my $parse = new ID::Utilities();
    my $fn = $parse->getWebFile( $outfile, $URL );
    my @parsedData = $parse->parsePatchFile($fn);
    my @patchObject = ();
    my $patch;
    foreach my $dataRow ( @parsedData ) {
        $patch = new ID::Patch();
            $patch->setID(shift @$dataRow);
	    my @references = shift @$dataRow;
            $patch->setReferences(@references);
            $patch->setDescription(shift @$dataRow);
            $patch->setAffected(shift @$dataRow);
            $patch->setDate(shift @$dataRow);
            $patch->setType("Security");
        push ( @patchObject, $patch );
    }
    return @patchObject;
}

1;
