
package ID::PatchParser::Windows;
use strict;
use warnings;
use File::Basename;
use base 'ID::PatchParser';
require "load_configs.pl";

#Builds the list of Patchs objects 
#Arguments: Filename
#Returns: List of Patches
sub createPatchObjects{
        my $self = shift;
	my $fn = shift;

	my @patchObjects = ();	
	my $patch = undef;

	#These lines find the OS of this class (EX: 'ID::PatchParser::Windows' would result in 'Windows')
	my $class_name = __PACKAGE__;
	my @class_name_split = split(/:+/,$class_name);
	$class_name = $class_name_split[-1];

	#This does all the work	
	my @parsedData = load($class_name);
	print $parsedData[-1][-1];
	my ($date,$ID,$bulletin_kb,$severity,$impact,$title,$affected_pro,$component_kb,$affected_com,$impact2,$severity2,$suspended,$supercedes,$reboot,$cve,$type,$description) = undef;
	my @references = ();
	foreach my $dataRow ( @parsedData ) {
		$patch = new ID::Patch(ID => "none");
		$date = shift @$dataRow;
		$ID = shift @$dataRow;
		$bulletin_kb = shift @$dataRow;
		$severity = shift @$dataRow;
		$impact = shift @$dataRow;
		$title = shift @$dataRow;
		$affected_pro = shift @$dataRow;
		$component_kb = shift @$dataRow;
		$affected_com = shift @$dataRow;
		$impact2 = shift @$dataRow;
		$severity2 = shift @$dataRow;
		$suspended = shift @$dataRow;
		$supercedes = shift @$dataRow;
		$reboot = shift @$dataRow;
		$cve = shift @$dataRow;
		$type = "security";	
	
		$description = "$severity "." $title for $affected_pro";
		@references = ("$ID","$bulletin_kb","$component_kb","$cve");
		$patch->setID($ID);	
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
	return @patchObjects;
}
1;
