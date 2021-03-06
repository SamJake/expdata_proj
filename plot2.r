#Subsetting Baltimore data and then splitting data year wise...
data_balt <- subset(data,data$fips=="24510")
data_balt_split <- split(data_balt,data_balt$year)
sum_balt_emissions <- lapply(data_balt_split,function(x){sum(x$Emissions)})
setwd("J:/R/expdata_proj")

#Plotting...
png(filename = "./Images/plot2.png")
par(mfrow=c(1,1),mar=c(5,5,5,5))
plot(as.integer(names(sum_balt_emissions)),sum_balt_emissions,main="Baltimore City PM25 Emissions by year",xlab = "Year",ylab = "Emission in tons",pch=19,col="red")
dev.off()