library(ggplot2)
library(readr)
library(ggpubr)
library(reshape2)
library(scales)
contam <- read_table2("contam.csv")
contam$Count<-as.numeric(contam$Count)

contam.sub<-subset(contam, contam$Count>5000)
contam.sub<-subset(contam.sub, Gene!="NA")
contam.sub<-subset(contam.sub, Count!="NA")

pdf("histo.pdf", width = 20, height = 10)
ggplot(contam.sub, aes(reorder(Gene, Count), Count, fill=Fungi)) +
  geom_bar(stat = "identity") +
  #scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x)))+
  theme(axis.text.x = element_text(angle = 90, hjust=1, vjust=.5), legend.position = "none")
dev.off()

pdf("histo_agg.pdf", width = 20, height = 10)
histo.data<-aggregate(contam.sub$Count, by = list(contam.sub$Gene), FUN = sum)
sort(histo.data$x, decreasing = TRUE)
ggplot(histo.data, aes(reorder(histo.data$Group.1, x), x)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 90, hjust=1, vjust=.5), legend.position = "none")
dev.off()

write.table(histo.data$Group.1, "top_genes.csv", sep = ",", row.names = FALSE, quote = FALSE, col.names = FALSE)


contam_bac <- read_table2("contam_bac.csv", col_names = FALSE)
colnames(contam_bac)<-c("Fungi", "taxid", "count")
contam_bac$taxid<-as.character(contam_bac$taxid)
#contam_bac<-subset(contam_bac, contam_bac$count>200)
#contam_bac<-subset(contam_bac, contam_bac$count<20000)

write.table(unique(contam_bac$taxid), "taxid_bac.csv", row.names = FALSE, col.names = FALSE, quote = FALSE)

taxified_ids <- read_delim("taxified_ids.tsv", "|", escape_double = FALSE, trim_ws = TRUE)


pdf("contam.pdf", width = 10, height = 10)
ggplot(contam_bac, aes(Fungi, taxid, fill=count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust=1, vjust=.1)) 
dev.off()

pdf("contam_boxplot.pdf")
ggplot(contam_bac, aes(taxid, count)) + 
  geom_boxplot() +
  coord_flip()
dev.off()



