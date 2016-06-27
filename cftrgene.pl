# Chapter 2, exercise 2.6.1

# This program looks for the deletion of three consecutive nucleotides in the CFTR (cystic fibrosis transmembrane regulator) allele. 
# The mutation ia abbreviated as delta-F508 (Phenalalanine (F) at position 508). Two input files are required: the wild-type sequenec, 
# coding region only and the mutant sequence in FASTA format.
# This program can also be used to compare the corresponding protein sequences with one amino acid (1 nucleotide) missing. 
#
# June 2016 by H. Chung


use Data::Dumper qw(Dumper);

# Main 

open_files();
$n_str = get_deletion_sequence();
# array to hold the different permuations of the mutant sequence
@mutation_series = ();   
get_mutant_permutations($str2, $n_str);
find_matches();
%best_alignment;
print "Wild-type sequence -> Mutant_type sequence -> Number of matches \n";
print Dumper \%best_alignment;



# This opens the files to be compared.

sub open_files {

  if ( !open (infile1, 'cftrgene_dna_cds.txt') ) {
    print "error opeing input file 1 \n";
    exit;
  }
  $data = <infile1>;  #ignore FASTA comment
  while ( $data = <infile1> ) {
    chomp $data;
    $str1 = $str1 . $data;
  }

  if (!open (infile2, 'cftrgene_dna_mutant.txt')) {
    print "error opening input file 2\n";
    exit;
  }
  $data = <infile2>;  # ignores FASTA comment
  while ($data = <infile2>) {
    chomp $data;
    $str2 = $str2 . $data;
  }
}



# This returns a string of n consecutive deletions such as --- .

sub get_deletion_sequence{

  print "Enter the number of consecutive deletions: ";
  $deletion_amt = <STDIN>;
  chomp $deletion_amt;

  $deletion_str = "";

  for ($m = 0; $m < $deletion_amt; $m++ ){
    $deletion_str = $deletion_str . "-";
  }

  return $deletion_str;
} # get_deletion_sequence subroutine




# This generates all the possible permutations with deletions of n consecutive nucleotides.
# This receives the mutant sequence and the n consecutive deletion sequence and constructs the possibilities.

sub get_mutant_permutations{

  
  my $seq = $_[0];    # mutant sequence
  my $n_deletions = $_[1]; # string of n consecutive deletions
    
  for ( $k = 0; $k < length($seq) + 1; $k++) {

    $beginning = substr($seq, 0, $k);
    $end = substr($seq, $k, length($seq) - $k);
    $whole_string = $beginning . $n_deletions . $end;
    @mutation_series[$k] = $whole_string;  # put each permutation in an array element for later retrieval
  }

}  # get_mutant_permutations subroutine



# This finds the best alignment (ie, where the two strings have the most matches)

sub find_matches {

  my $length_mutant = length($str2);

  for ( $n = 0 ; $n < length($str2) + 1; $n++ ) {

    compare_strings($str1, @mutation_series[$n]);    # compares the normal string to the mutant string

  }

} # find_meatches



# This compares two sequences of nucleotides .
# The first parameter is the wild-type sequence, the second is one possibility of the mutant sequence with n consecutive-deletions built in

sub compare_strings{

  my $str1 = $_[0];   # wild type sequence
  my $str2 = $_[1];   # mutant sequence

  $bestmach = 0;        # the best alignment overall
  
  # with the current mutation string, how many comparisons are made againsts the wild type
  $max_iteration = length($str1) - length($str2) + 1;  


  # moves the mutation along the same string
  for ($i = 0; $i < $max_iteration ; $i++ ) {
    $currentmatch = 0;


    # matches letter for letter between the two strings
    for($j=0; $j<length($str2); $j++){

      if (substr($str1, $j + $i, 1) eq substr($str2, $j, 1)){
        # event occurred - change flag
        $currentmatch =  $currentmatch + 1;
      }  #ends if loop
    }
  
  

  # If the current alignement has the same or more matches as the best alignmeent, add it to the hash table

    if ($currentmatch >= $bestmatch) {
      $bestmatch = $currentmatch;
      $wild_segment = substr($str1, $i, length($str2));
      $best_alignment{"$wild_segment"}{"$str2"}= $bestmatch;  
    }
    
  } 

} # compare_strings subroutine
