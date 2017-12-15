
#subsetting only Vehicle EI.Sectors...
src_class <- src_class[,c(1,4)]
uniq_sec <- as.character(unique(src_class$EI.Sector))
index3 <- grep("Vehicle",uniq_sec)
veh_sec <- uniq_sec[index3]
veh_sec_class <- subset(src_class,EI.Sector %in% veh_sec)

#Summarizing Emissions data for Baltimore city & Los Angeles...
veh_data <- merge(data_balt,veh_sec_class,by="SCC")
veh_grouped_data <- group_by(veh_data,EI.Sector,year) %>% summarise(sum(Emissions))
names(veh_grouped_data)[3] <- "Emissions"

data_la <- subset(data,data$fips=="06037")
veh_data_la <- merge(data_la,veh_sec_class,by="SCC")
veh_grouped_data_la <- group_by(veh_data_la,EI.Sector,year) %>% summarise(sum(Emissions))
names(veh_grouped_data_la)[3] <- "Emissions"

veh_grouped_data <- mutate(veh_grouped_data,city="Baltimore")
veh_grouped_data_la <- mutate(veh_grouped_data_la,city="Los Angeles")
two_city <- rbind(veh_grouped_data,veh_grouped_data_la)


#Plotting...
setwd("C:/Users/SamJacobJulian/Desktop/Rstd/expdata_proj")
png(filename = "./Images/plot6.png",width = 780,height = 480)     
ggplot(two_city,aes(year,Emissions,color=EI.Sector))+geom_point(size=2)+geom_line()+facet_wrap(~city)+
  ggtitle("Vehicle Emissions in Baltimore & Los Angeles")
dev.off()


