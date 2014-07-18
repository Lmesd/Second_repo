# Script to plot heatmpat

#load relevant packages

library("pheatmap")

# read in data

mat1<-read.table("/Users/laurentmesnard/Dropbox/MUTHU_RB/Manuscript-May-2014/R-Building_Figure/Data/Supervised_Analysis-May07th/UnionSET_Normalize_CTL.csv", header=TRUE, sep=",",quote="\"", dec=".", stringsAsFactors=TRUE)
MX<-data.matrix(mat1[1:515,2:28])
MX2<-log2(MX)
rownames(MX2)<-mat1[1:515,1]
# configure the annotation color bars
# read in file with sampleId - annotation class(group)  mapping
LegendLM<-read.csv("/Users/laurentmesnard/Dropbox/MUTHU_RB/Manuscript-May-2014/R-Building_Figure/Data/Legend-Cluster-subset_V3_WO_CTL.csv")
# Row names must match data sample names
rownames(LegendLM) <- LegendLM$Var2
# delete sampleID column and store in a new data frame
as.data.frame(LegendLM[,-2]) -> annot
rownames(annot) <- rownames(LegendLM)
# re-label Annotation to "Group"
colnames(annot) <- "Group"

# plot the heatmap
pheatmap(MX2,  cluster_cols=TRUE, 
         cluster_rows=TRUE,
         colorRampPalette(c("green","black","red"))(100),
         scale="none", clustering_distances_rows="euclidian",
         clustering_distance_cols="euclidian", clustering_method="mcquitty",
         #kmeans_k = NA, fontsize=10,
         #show_colnames=FALSE,
         legend_breaks = -1:4,
         annotation=annot,
         cellwidth = 10, cellheight = 2, fontsize=2,
         Legend=TRUE
)