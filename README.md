put_seq_2_blast.pl
========

simple tools for extracting sequences according to BLAST tabulr output

##################################################################################
Getting started:
Please read the following abbreviations before reading the Readme file.
**ABBR**
pep_file:	the file containing peptide sequences
cds_file:	the file containing cds sequences
blast_output:	the file containing the output of blast results (tabular-like format)

##################################################################################
0.	a)	Before starting, please make sure that all of the following files are ready and intact.
		1)	"put_seq_2_blast.pl"
		2)	"synchronize_names.pl"
		3)	DIR:	"perl_modules"
			i)	"parse_blast_output.pm"
			ii)	"read_fasta.pm"
	b)	Also, it would be better to make sure that the blast_output is in the tabular format.
		You may find the following lincks useful if you are not familiar with BLAST tabular format.
			"http://www.ncbi.nlm.nih.gov/staff/tao/URLAPI/blastall/blastall_node93.html"
			"http://www.bios.niu.edu/johns/bioinform/blast_info.htm"

1.	You can type " perl put_seq_2_blast.pl" and "perl synchronize_names.pl" to see the usages.

2.	If the sequence names are the same included in the pep_file, cds_file and blast_output, then type the following command.
		perl put_seq_2_blast.pl -cds_file <cds_file>  -pep_file <pep_file> -blast_output <blast_output>

3.	If the sequence names included in the pep_file, cds_file and blast_output do not match, then do as follows.
	1)	perl  synchronize_names.pl -cds_file <cds_file>  -pep_file <pep_file>
	2)	perl put_seq_2_blast.pl -cds_file <new_cds_file>  -pep_file <new_pep_file> -blast_output <blast_output>

4.	Please note that the default value of E value used for BLASt output result is "1e-10". That is to say, all hits with E value bigger than the default value will be ignored if the argument "e_value" is not given or "e_value" is given as "1e-10".

5.	If you have any problem with this tool, please do not hesitate to write e-mails to "tomassonwss@gmail.com". Your comments and suggestions are highly appreciated.

