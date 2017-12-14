library(dplyr)
library(reshape2)
library(ggplot2)

data_balt <- subset(data,data$fips=="24510")
data_balt_split <- split(data_balt,data_balt$year)
sum_balt_type_emissions <-lapply(data_balt_split,function(x){split(x,x$type)})

j<- 1
for(i in seq(1999,2008,by=3))
{
  assign(paste("year",as.character(i),sep = "_"),sum_balt_type_emissions[[j]],envir = .GlobalEnv)
  j<- j+1
}  

for(m in seq(1999,2008,by=3))
{
  assign(paste("type",as.character(m),sep = "_"),lapply(get(paste("year",as.character(m),sep = "_")),function(y){sum(y$Emissions)}))
}  

type_df <- as.data.frame(rbind(as.numeric(type_1999),as.numeric(type_2002),as.numeric(type_2005),as.numeric(type_2008)))
names(type_df) <- c("NON-ROAD","NONPOINT","ON-ROAD","POINT")
type_df <- mutate(type_df,year=c(1999,2002,2005,2008))
type_df2 <- melt(type_df,id="year")

setwd("C:/Users/SamJacobJulian/Desktop/Rstd/expdata_proj")
png(filename = "./Images/plot3.png")
ggplot(type_df2,aes(year,value))+geom_line(aes(col=variable))+geom_point(size=2,aes(col=variable))+
ggtitle("Baltimore City PM25 by type")+
xlab("Year")+ylab("Emission in tons")  
dev.off()
