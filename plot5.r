
#subsetting only Vehicle EI.Sectors...
src_class <- src_class[,c(1,4)]
uniq_sec <- as.character(unique(src_class$EI.Sector))
index3 <- grep("Vehicle",uniq_sec)
veh_sec <- uniq_sec[index3]
veh_sec_class <- subset(src_class,EI.Sector %in% veh_sec)

#Summarizing Emissions data for Baltimore city...
veh_data <- merge(data_balt,veh_sec_class,by="SCC")
veh_grouped_data <- group_by(veh_data,EI.Sector,year) %>% summarise(sum(Emissions))
names(veh_grouped_data)[3] <- "Emissions"

#Plotting...
setwd("C:/Users/SamJacobJulian/Desktop/Rstd/expdata_proj")
png(filename = "./Images/plot5.png",width = 780,height = 480)     
ggplot(veh_grouped_data,aes(year,Emissions,color=EI.Sector))+geom_point(size=2)+geom_line()+
  ggtitle("Vehicle Emissions in Baltimore over the years")
dev.off()