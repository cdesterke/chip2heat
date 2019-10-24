# chip2heat

## wrapper of deeptools to easly produce promoter heatmap on CHIP sequencing data starting from bigwig and bed files
## usage : sh heat2chip.sh exemple.bigwig exemple.bed
## dependencies : python > 3.7 & deeptools > 3.1.3
### description : the wrapper save the heatmap in three format pdf, svg and png in a folder which parse the bed file name.
### regions explored in the heatmap are +/- 5kb around the center

### references : Ramírez F, Dündar F, Diehl S, Grüning BA, Manke T. deepTools: a flexible
### platform for exploring deep-sequencing data. Nucleic Acids Res. 2014 Jul;42(Web
### Server issue):W187-91. doi: 10.1093/nar/gku365. Epub 2014 May 5. PubMed PMID:
### 24799436; PubMed Central PMCID: PMC4086134.
