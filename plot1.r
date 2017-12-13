#Reading data...
#setwd("C:/Users/Sam/Downloads/data")
#data <- readRDS("summarySCC_PM25.rds")
#src_class <- readRDS("Source_Classification_Code.rds")

data_split <- split(data,data$year)
sum_emissions <- lapply(data_split,function(x){sum(x$Emissions)})
setwd("J:/R/course2")
png(filename = "./Images/plot1.png")
par(mfrow=c(1,1),mar=c(5,5,5,5))
plot(as.integer(names(sum_emissions)),sum_emissions,main="US PM25 Emissions by year",xlab = "Year",ylab = "Emission in tons",pch=19,col=c(1,2,3,4))
dev.off()