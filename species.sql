# a) How many types of tigers can be found in the taxonomy table of the dataset? What is the "ncbi_id" of the Sumatran Tiger? 
# (hint: use the biological name of the tiger)

select count(*) AS typesOfTigers from taxonomy where species like "%panthera tigris%";
+---------------+
| typesOfTigers |
+---------------+
|             8 |
+---------------+

select ncbi_id,species from taxonomy where species like "%sumatran tiger%";
+---------+-------------------------------------------+
| ncbi_id | species                                   |
+---------+-------------------------------------------+
|    9695 | Panthera tigris sumatrae (Sumatran tiger) |
+---------+-------------------------------------------+







# b) Find all the columns that can be used to connect the tables in the given database.

select 
    TABLE_NAME, 
    COLUMN_NAME 
from 
    information_schema.columns 
where 
    TABLE_SCHEMA = 'Rfam'
    AND (TABLE_NAME = 'family' OR 
         TABLE_NAME = 'rfamseq' OR 
         TABLE_NAME = 'full_region' OR 
         TABLE_NAME = 'clan' OR 
         TABLE_NAME = 'clan_membership' OR 
         TABLE_NAME = 'taxonomy');   # just taking care for important tables.

+-----------------+----------------------+
| TABLE_NAME      | COLUMN_NAME          |
+-----------------+----------------------+
| clan            | clan_acc             |
| clan            | id                   |
| clan            | previous_id          |
| clan            | description          |
| clan            | author               |
| clan            | comment              |
| clan            | created              |
| clan            | updated              |
| clan_membership | clan_acc             |
| clan_membership | rfam_acc             |
| family          | rfam_acc             |
| family          | rfam_id              |
| family          | auto_wiki            |
| family          | description          |
| family          | author               |
| family          | seed_source          |
| family          | gathering_cutoff     |
| family          | trusted_cutoff       |
| family          | noise_cutoff         |
| family          | comment              |
| family          | previous_id          |
| family          | cmbuild              |
| family          | cmcalibrate          |
| family          | cmsearch             |
| family          | num_seed             |
| family          | num_full             |
| family          | num_genome_seq       |
| family          | num_refseq           |
| family          | type                 |
| family          | structure_source     |
| family          | number_of_species    |
| family          | number_3d_structures |
| family          | num_pseudonokts      |
| family          | tax_seed             |
| family          | ecmli_lambda         |
| family          | ecmli_mu             |
| family          | ecmli_cal_db         |
| family          | ecmli_cal_hits       |
| family          | maxl                 |
| family          | clen                 |
| family          | match_pair_node      |
| family          | hmm_tau              |
| family          | hmm_lambda           |
| family          | created              |
| family          | updated              |
| full_region     | rfam_acc             |
| full_region     | rfamseq_acc          |
| full_region     | seq_start            |
| full_region     | seq_end              |
| full_region     | bit_score            |
| full_region     | evalue_score         |
| full_region     | cm_start             |
| full_region     | cm_end               |
| full_region     | truncated            |
| full_region     | type                 |
| full_region     | is_significant       |
| rfamseq         | rfamseq_acc          |
| rfamseq         | accession            |
| rfamseq         | version              |
| rfamseq         | ncbi_id              |
| rfamseq         | mol_type             |
| rfamseq         | length               |
| rfamseq         | description          |
| rfamseq         | previous_acc         |
| rfamseq         | source               |
| taxonomy        | ncbi_id              |
| taxonomy        | species              |
| taxonomy        | tax_string           |
| taxonomy        | tree_display_name    |
| taxonomy        | align_display_name   |
+-----------------+----------------------+




# c) Which type of rice has the longest DNA sequence? (hint: use the rfamseq and the taxonomy tables)

select t.species AS rice_type, r.length AS dna_sequence_length
    -> from rfamseq r inner join taxonomy t ON r.ncbi_id = t.ncbi_id
    -> where t.species LIKE '%oryza%' AND r.mol_type = 'genomic DNA'
    -> order by r.length desc limit 1;

+---------------------------+---------------------+
| rice_type                 | dna_sequence_length |
+---------------------------+---------------------+
| Oryza sativa Indica Group |            47244934 |
+---------------------------+---------------------+




-- d) We want to paginate a list of the family names and their longest DNA sequence lengths (in descending order of length) where only families that have DNA 
-- sequence lengths greater than 1,000,000 are included. Give a query that will return the 9th page when there are 15 results per page. 
-- (hint: we need the family accession ID, family name and the maximum length in the results)



select r.accession AS accession_id,t.species AS Family_names, r.length AS dna_sequence_length
    -> from rfamseq r inner join taxonomy t ON r.ncbi_id = t.ncbi_id
    -> where r.length>1000000 AND r.mol_type = 'genomic DNA'
    -> order by r.length desc LIMIT 120, 15;


 +--------------+-----------------------------------------------------+---------------------+
| accession_id | Family_names                                        | dna_sequence_length |
+--------------+-----------------------------------------------------+---------------------+
| CM000813     | Sus scrofa (pig)                                    |           162569375 |
| CM001386     | Felis catus (domestic cat)                          |           161193150 |
| CM000996     | Mus musculus (house mouse)                          |           160039680 |
| CM000785     | Zea mays                                            |           159769782 |
| CM004469     | Xenopus laevis (African clawed frog)                |           159726490 |
| CM004474     | Xenopus laevis (African clawed frog)                |           159361991 |
| CM000669     | Homo sapiens (human)                                |           159345973 |
| CM000860     | Callithrix jacchus (white-tufted-ear marmoset)      |           159171411 |
| FR853100     | Gorilla gorilla gorilla (western lowland gorilla)   |           159110946 |
| CM003279     | Salmo salar (Atlantic salmon)                       |           159038749 |
| BL000002     | Homo sapiens (human)                                |           158409401 |
| CM000861     | Callithrix jacchus (white-tufted-ear marmoset)      |           158406734 |
| GK000001     | Bos taurus (cattle)                                 |           158337067 |
| BL000001     | Homo sapiens (human)                                |           157953789 |
| CM001649     | Nomascus leucogenys (Northern white-cheeked gibbon) |           157873769 |
+--------------+-----------------------------------------------------+---------------------+



