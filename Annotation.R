# script to convert gene id to gene symbols

library(biomaRt)
library(annotables)
library(org.Hs.eg.db)
library(EnsDb.Hsapiens.v86)
library(tidyverse)

# input list of Ensembl ID's

ensembl_id <- read.delim('gene_ids.txt', header = F)

# method 1: biomaRt

listEnsembl()
ensembl <- useEnsembl(biomart = "genes")
datasets <- listDatasets(ensembl)

ensembl.con <- useMart("ensembl", dataset = 'hsapiens_gene_ensembl')

attr <- listAttributes(ensembl.con)
filters <- listFilters(ensembl.con)

bio <- getBM(attributes = c('ensemble_gene_id','external_gene_name'),
             filters = "ensemble_gene_id",
             values = ensembl.ids$V1,
             mart = ensembl.con)
             
# method 2: annotables

grch38 %>%
    filter(ensgene %in% ensembl.ids$V1)

# method 3: annotation DBs

keytypes (org.Hs.eg.db)
column(org.Hs.eg.db)

mapIds(org.Hs.eg.db,
       keys = ensembl.ids$V1,
       keytype = 'ENSEMBL',
       column = 'SYMBOL')


keytypes(EnsDb.Hsapiens.v86)
columns(EnsDb.Hsapiens.v86)

gene <- mapIds(EnsDb.Hsapiens.v86,
               keys = ensembl.ids$V1,
               keytype = 'GENEID',
               column = 'SYMBOL')
          
