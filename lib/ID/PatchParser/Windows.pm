package ID::PatchParser::Windows;
use strict;
use warnings;
use Text::CSV_XS;
use base 'ID::PatchParser';

#Accessor method for the patch list
sub getPatchList{
        my $self = shift;
        return @{$self->{patch_list}};
}

#Builds the list of Patchs objects from the CSV file
#Arguments: None
#Returns: List of Patches
sub buildPatchList{
        my $self = shift;
        my @patch_list = ();
        my @args = ();
        my @file_content = $self->getFileContent($self->getFilename());
		my $i = undef;
		my $params = "";
        foreach my $line(@file_content){
        	$params = "";
        	@args = $self->parseCSVLine($line);
		$i = 0;
		for(@args){
			$params = $params."\$args[$i],"; #This lets us pass X amount of arguments in createPatch()
			$i++;
		}
		chop $params;
                push(@patch_list,$self->createPatch(eval("$params"))); 
        }
        @{$self->{patch_list}} = @patch_list;
}

#Reads the contents of a file into an array line by line
#Arguments: None
#Returns: File content in array
sub getFileContent{
        my $self = shift;
        my $configFile = shift;
        my @file_content = ();
        open my $FH, "<", "$configFile" or die $!;
        while(my $fetchline = <$FH>){
                push(@file_content,"$fetchline");
        }
        close $FH;
        return @file_content;
}

#Parses lines of text in csv format and puts them into a useable format
#Arguments: Line of text as scalar to be parsed
#Returns: Parsed data in array 
sub parseCSVLine{
        my $self = shift;
        my $input_string = shift;
        my @arg_list = ();
        my $csv = Text::CSV_XS->new ({ keep_meta_info => 1, binary => 1 });

        if ($csv->parse($input_string)){
                my @columns = $csv->fields();
                foreach my $arg(@columns){
                        push(@arg_list,"$arg");
                }
        } else {
            my $err = $csv->error_input;
            print "Failed to parse line: $err";
        }
        return @arg_list;
}
#Takes in vendor information and uses it to create a Vendor object
#Arguments: Vendor name, Vendor URL, Support URL, Parser Class all scalars
#Returns: Vendor object
sub createPatch{
        my $self = shift;
	my $date = shift;
	my $ID = shift;
	my $bulletin_kb = shift;
	my $severity = shift;
	my $impact = shift;
	my $title = shift;
	my $affected_pro = shift;
	my $component_kb = shift;
	my $affected_com = shift;
	my $impact2 = shift;
	my $severity2 = shift;
	my $suspended = shift;
	my $supercedes = shift;
	my $reboot = shift;
	my $cve = shift;
	my $type = "security";	
	
	my $description = "$severity "." $title for $affected_pro";
	my @references = ("$ID","$bulletin_kb","$component_kb","$cve");
		
	my $patch = new ID::Patch(ID => $ID);
	$patch->setDate($date);
	$patch->setSeverity($severity);
	$patch->setTitle($title);
	$patch->setType($type);
	$patch->setImpact($impact);
	$patch->setAffected($affected_pro);
	$patch->setDescription($description);
	$patch->setReferences(@references);	
	return $patch;
}
1;
