package ID::PatchParser::Windows;
use strict;
use warnings;
use base 'ID::PatchParser';
use ID::Utilities;
#Builds the list of Patchs objects 
#Arguments: None
#Returns: List of Patches
sub createPatchObject{
        my $self = shift;
	my $fn = shift;

	my @patchObjects = ();	
	my $patch = undef;

	my $parse = new ID::Utilities;
	my @parsedData = $parse->parsePatchFile($fn);


	my ($date,$ID,$bulletin_kb,$severity,$impact,$title,$affected_pro,$component_kb,$affectedcom,$imppact2,$severity2,$suspended,$supercedes,$reboot,$cve,$type,$description) = undef;
	my @references = ();
	foreach my $dataRow ( @parsedData ) {
		$patch = new ID::Patch;
		$date = shift;
		$ID = shift;
		$bulletin_kb = shift;
		$severity = shift;
		$impact = shift;
		$title = shift;
		$affected_pro = shift;
		$component_kb = shift;
		$affected_com = shift;
		$impact2 = shift;
		$severity2 = shift;
		$suspended = shift;
		$supercedes = shift;
		$reboot = shift;
		$cve = shift;
		$type = "security";	
	
		$description = "$severity "." $title for $affected_pro";
		@references = ("$ID","$bulletin_kb","$component_kb","$cve");
	
		$patch->setDate($date);
		$patch->setSeverity($severity);
		$patch->setTitle($title);
		$patch->setType($type);
		$patch->setImpact($impact);
		$patch->setAffected($affected_pro);
		$patch->setDescription($description);
		$patch->setReferences(@references);	
		push(@patchObjects, $patch);
	}
}
1;
