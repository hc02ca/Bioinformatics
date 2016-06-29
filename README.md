# Bioinformatics
This folder contains a list of bioinformatics related projects.

Project 1:

Cystic Fibrosis is a genetically linked disease. Mutations in the CFTR (cystic fibrosis transmembrane regulator) gene lead to respiratory problems. The most common mutation - a deletion of CTT - affects the closing and opening of this transmembrane protein that allows water to pass into the lungs to thin mucus.

This program prompts the user to enter a deletion of 3 consecutive nucleotides. The normal sequence is then compared to the mutant sequence found in FASTA files. The output lists the top matches. The sequence with the most matches is compared to find the deletion of CTT. There will be two possible solutions. 

The program can be modified to compare the protein equivalents, using input from FASTA format files. A deletion of 1 is required since three amino acids code for 1 nucleotide.  An “F” or phenylalanine is missing. This confirms the missing nucleotides are CTT.

cftrgene.pl,
cftrgene_dna_cds.txt, cftrgene_dna_mutant.txt,
cftrgene_protein.txt, cftrgene_protein_mutant.txt

Project 2:

This project translates an mRNA sequence into its protein equivalent. 

ch2ex2_Q10.pl,
hbb_version3.txt
