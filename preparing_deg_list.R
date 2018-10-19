# Load dataset file to R.
d = read.delim("exp23k_heatmap_dataset1.txt")
n <- names(d)


# Find the address of 'Entrez_ID' and 'fc' in vector 'n'.
address_id <- grep("Entrez_ID", n)
address_fc <- grep("fc", n)

# Make the geneList, a numeric vector contains the fold change values of whole transcripts on chip with named by 'Entrez gene ID' to analyse.
geneList = d[,'address_fc']
names(geneList) = as.character(d[, 'address_id'])
geneList = sort(geneList, decreasing = TRUE)

