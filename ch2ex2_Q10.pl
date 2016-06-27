# Chapter 2 - Exercise 2
# Translation Program

# The user can enter either a template or non-template strand of DNA in standard format (5 to 3)
# that represents a coding sequence consisting of nucleotides in multiples. The starting codon
# may be either ATG or not - user is prompted to continue or not. Translation will stop once a
# stop codon has been reached.
# The program will output the DNA sequence, RNA sequence to an outfile.
# The program will output the amino acid equivalent to another output file.
# A hastable will store the genetic code. 
#
# June 2016 by H. Chung


# Build hashtable for genetic code
my %codes;
# Populate hashtable with values
$codes{'UUU'} = 'F';
$codes{'UUC'} = 'F';
$codes{'UUA'} = 'F';
$codes{'UUG'} = 'L';
$codes{'UCU'} = 'S';
$codes{'UCC'} = 'S';
$codes{'UCA'} = 'S';
$codes{'UCG'} = 'S';
$codes{'UAU'} = 'Y';
$codes{'UAC'} = 'Y';
$codes{'UGU'} = 'C';
$codes{'UGC'} = 'C';
$codes{'UGG'} = 'W';
$codes{'CUU'} = 'L';
$codes{'CUC'} = 'L';
$codes{'CUA'} = 'L';
$codes{'CUG'} = 'L';
$codes{'CCU'} = 'P';
$codes{'CCC'} = 'P';
$codes{'CCA'} = 'P';
$codes{'CCG'} = 'P';
$codes{'CAU'} = 'H';
$codes{'CAC'} = 'H';
$codes{'CAA'} = 'Q';
$codes{'CAG'} = 'Q';
$codes{'CGU'} = 'R';
$codes{'CGC'} = 'R';
$codes{'CGA'} = 'R';
$codes{'CGG'} = 'R';
$codes{'AUU'} = 'I';
$codes{'AUC'} = 'I';
$codes{'AUA'} = 'I';
$codes{'AUG'} = 'M';
$codes{'ACU'} = 'T';
$codes{'ACC'} = 'T';
$codes{'ACA'} = 'T';
$codes{'ACG'} = 'T';
$codes{'AAU'} = 'N';
$codes{'AAC'} = 'N';
$codes{'AAA'} = 'K';
$codes{'AAG'} = 'K';
$codes{'AGU'} = 'S';
$codes{'AGC'} = 'S';
$codes{'AGA'} = 'R';
$codes{'AGG'} = 'R';
$codes{'GUU'} = 'V';
$codes{'GUC'} = 'V';
$codes{'GUA'} = 'V';
$codes{'GUG'} = 'V';
$codes{'GCU'} = 'A';
$codes{'GCC'} = 'A';
$codes{'GCA'} = 'A';
$codes{'GCG'} = 'A';
$codes{'GAU'} = 'D';
$codes{'GAC'} = 'D';
$codes{'GAA'} = 'E';
$codes{'GAG'} = 'E';
$codes{'GGU'} = 'G';
$codes{'GGC'} = 'G';
$codes{'GGA'} = 'G';
$codes{'GGG'} = 'G';


$codes{'UAA'} = 'stopcodon';  	#stop codon
$codes{'UAG'} = 'stopcodon';  	#stop codon
$codes{'UGA'} = 'stopcodon';	#stop codon


		
print "Do you want to enter the template strand from 5' to 3' end (enter T) or non-template strand from 5' to 3'end (enter N)? :  \n";
$strand_choice = <STDIN>;
chomp $strand_choice;


# Reads sequence from file
open(infile, 'hbb_version3.txt');
open(outfile, '>outdata.txt');
open(outfile2, '>outdataaminoacid.txt');
$data = <infile>;  #ignores first line of fasta format
chomp $data;
while ($data = <infile>) {
	chomp $data;
	$dnaseq = $dnaseq.$data;
	
}

#Converts sequence into all UPPERCASE if necessary
$dnaseq =~ tr/atgc/ATGC/;


if ( substr($dnaseq, 0, 3) eq "ATG") {

	strand_type();	
	get_amino_acid();

}else{
	
	$first = substr($dnaseq, 0, 3);
	print "The first codon is $first";
	print "The sequence does not appear to be the coding sequence for a protein.. Continue? (Y/N)  \n";
	$start_seq = <STDIN>;
	chomp $start_seq;
	if ($start_seq eq "Y")
	{ 		

		strand_type();
		
		get_amino_acid();
	}
}


sub strand_type {



if ($strand_choice eq 'T') 
{	
	#convert a template DNA strand to its RNA equivalent
	#convert the strand to the standard format, beginning with 5', 
	
	
	#reverse template DNA sequence from 5' 3' to 3' 5' 
	$rnaseq = reverse($dnaseq);    
	
	#with template strand in 3' to 5', substitute bases to get non-template sequence in 5' to 3' format 
	#with non-template sequence in 5' to 3' format, convert to mRNA sequence by replacing T with U and mRNA is now in 5' to 3' format
	$rnaseq =~ tr/ACGT/UGCA/; 
	print outfile "DNA: 5' $dnaseq 3'\n";
	print outfile "RNA: 5' $rnaseq 3'\n";

}
elsif ( $strand_choice eq 'N')
{
	# convert a non-template strand of DNA to its RNA equivalent
	# non-template strand is in 5' to 3' format and mRNA is in 5' to 3' format
    
	
	$rnaseq = $dnaseq;
	
	$rnaseq =~ s/T/U/g;
	print outfile "DNA: 5' $dnaseq  3'\n";
	print outfile "RNA: 5' $rnaseq  3'\n";


}
else { print "Try again\n"; }


} #end of strand_type subroutine


sub get_amino_acid {

	#prompt user for fasta description
	get_fasta_header();


	# get number of codons
	$codonctr = length($rnaseq) / 3;

	# repeat translation process as many times as there are codons
	print "Protein: ";
	for($i = 0; $i < $codonctr; $i++){
   		# call to hashtable
   		$aminoacid = $codes{substr($rnaseq, $i*3, 3)};
   
   		if ( $aminoacid ne "stopcodon") {
   			print $aminoacid;
   			print outfile2 "$aminoacid";
   		}
		else{
			$i = $codonctr;		#exit out of rest of sequence when stop codon is reached

		}	
	}

} # end of get_amino_acid subroutine



sub get_fasta_header{

	print "Enter the description";
	$fasta_descript = <STDIN>;
	chomp $fasta_descript;
	print  outfile2 "$fasta_descript \n";
}



close infile;
close outfile;
close outfile2;

print "\n";


# statement may be needed to hold output screen
print "Press any key to exit program";
$x = <STDIN>;	











