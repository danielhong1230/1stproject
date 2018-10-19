# Load dataset file to R.
d = read.delim("exp23k_heatmap_dataset1.txt")
n <- names(d)


# Find the address of 'Entrez_ID' and 'fc' in vector 'n'.
address_id <- grep("Entrez_ID", n)
address_fc <- grep("fc", n)


# Make the geneList for Gene Set Enrichment Analysis, which is a numeric vector consisted of the fold change values of whole probes on a chip and named with Entrez gene ID.
geneList = d[,'address_fc']
names(geneList) = as.character(d[, 'address_id'])
geneList = sort(geneList, decreasing = TRUE)


