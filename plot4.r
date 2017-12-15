
#subsetting only Fuel Combustion - Coal EI.Sectors...
src_class <- src_class[,c(1,4)]
uniq_sec <- as.character(unique(src_class$EI.Sector))
index1 <- grep("Fuel Comb",uniq_sec)
comb_sec <- uniq_sec[index1]
index2 <- grep("Coal",comb_sec)
coal_sec <- comb_sec[index2]
coal_comb_sec <- subset(src_class,EI.Sector %in% coal_sec)

#It has 80 unique entries for SCC
coal_data <- merge(data,coal_comb_sec,by="SCC")

#Plotting...
setwd("C:/Users/SamJacobJulian/Desktop/Rstd/expdata_proj")
png(filename = "./Images/plot4.png",width=780, height=480)     
ggplot(coal_data,aes(year,Emissions,color=EI.Sector))+geom_point()+facet_grid(~EI.Sector)+
  ggtitle("Fuel Combustion - Coal in US over the years")
dev.off()