# Import libraries to analysis.
library(ggplot2)
library(factoextra)

# Import file of expression dataset.
my_data <- read.delim("proj201801_data2.txt", header = TRUE, sep = '\t') 
mat=as.data.frame(my_data[,24:31])

# Perform the analysis using `prcomp` function.
res.pca <- prcomp(t(mat), scale = TRUE)
fviz_eig(res.pca)
fviz_pca_ind(res.pca,
             col.ind = "cos2", # Color by the quality of representation
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)
