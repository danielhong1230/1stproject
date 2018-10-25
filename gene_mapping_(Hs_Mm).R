# Import package "biomaRt".
library(biomaRt)
library(Org.Mm.eg.db)
library(Org.Hs.eg.db)
library(clusterProfiler)


# 
mart_hs = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mart_mm = useMart("ensembl", dataset = "mmusculus_gene_ensembl")


# Make a list for Ensembl Gene ID of Mus Musculus.
gene.list <- names(geneList01)
ids <- bitr(gene.list, fromType = "ENTREZID", toType = c("SYMBOL", "ENSEMBL"), OrgDb = "org.Mm.eg.db")
head(ids)
ids_mm <- as.character(ids$ENSEMBL)


#
ids_enbl <- getLDS(attributes = c("ensembl_gene_id"),
            filters = "ensembl_gene_id", values = ids_mm, mart = mart_mm,
            attributesL = c("ensembl_gene_id"), martL = mart_hs)


#
ids_hs <- bitr(as.character(ids_enbl$Gene.stable.ID.1), fromType = "ENSEMBL", toType = c("SYMBOL", "ENTREZID"), OrgDb = "org.Hs.eg.db")


# Save dataframes as csv files.
write.csv(ids_mm, "ids_mm.csv")
write.csv(ids_enbl, "ids_convert.csv")
write.csv(ids_hs, "ids_hs.csv")


# Open csv files in Excel, and make final product file using 'vlookup' function.
# The reference of this code is "https://www.r-bloggers.com/converting-mouse-to-human-gene-names-with-biomart-package/".
