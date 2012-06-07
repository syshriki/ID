package ID::PatchParser::Siemens;
use strict;
use warnings;
use ID::Patch;
use Spreadsheet::ParseExcel;
use base 'ID::PatchParser';

sub getPatchList{
        my $self = shift;
        return @{$self->{patch_list}};
}

sub buildPatchList{
	my $self = shift;
	my @patch_list = ();
	my @patch_data = $self->parseXLSFile($self->getFilename());
	foreach my $patch(@patch_data){
		push(@patch_list,$self->createPatch(eval('$patch')));
	}
	@{$self->{patch_list}} = @patch_list;
}
	
sub parseXLSFile{
        my $self = shift;
        my $xls_file = shift;
	my $current = undef;
        my @args = ();
        my $current_arg = "";
        my $bulletin = Spreadsheet::ParseExcel::Workbook->Parse($xls_file);
        foreach my $book(@{$bulletin->{Worksheet}}){
                for(my $iR = $book->{MinRow}+1; defined $book->{MaxRow} && $iR <= $book->{MaxRow}; $iR++){#Min row + 1 so not to include headers
                        for(my $iC = $book->{MinCol}; defined $book->{MaxCol} && $iC <= $book->{MaxCol}; $iC++){
                                $current = $book->{Cells}[$iR][$iC];
				if($current){
                                	$current_arg .= "\'".$current->Value."\',";
				}
                        }
                        chop $current_arg;
                        push(@args,$current_arg);
                        $current_arg = "";
                        
                }
        }
        return @args;
}

sub createPatch{
        my $self = shift;
	my $ID = shift;
	my $bulletin_kb = shift;
	my $description = shift;
	my $affected_pro = shift;
	my $date = shift;
	my $type = "security";
		
	my @references = ("$ID","$bulletin_kb");
	
	my $patch = new ID::Patch(ID => $ID);
	$patch->setDate($date);
	$patch->setType($type);
	$patch->setAffected($affected_pro);
	$patch->setDescription($description);
	$patch->setReferences(@references);
		
	return $patch;
}
1;
