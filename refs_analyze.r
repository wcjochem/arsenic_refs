#
# Analyze the clusters created by VOSviewer
#

library(ggplot2)
library(plyr)
library(aspace) # standard deviational ellipse

map <- read.csv("bdesh_map_nov.csv")
  head(map)

# inspect the clusters
table(map$cluster)
  head(subset(map, cluster==1), 20) # public health papers
  head(subset(map, cluster==2), 20) # geology
  head(subset(map, cluster==3), 20) # food
  head(subset(map, cluster==4), 20) # hum-env
  head(subset(map, cluster==5)) # other?

# clean up cluster 5 outlyers
# changes based on description and visual checking in VOSviewer
map$cluster[map$id==441] <- 1
map$cluster[map$id==855] <- 1
map$cluster[map$id==907] <- 3

# spatial/topical outliers
map <- subset(map, !id %in% c(937, 938)) # drop the Podder et al. refs in cluster 5
map <- subset(map, !id %in% c(707, 291, 48, 945)) # drop Jigami (2005), Mondal et al. (2010), Islam et al. (2013)

# create the year of article from the label
map$year <- gsub(".*\\((.*)\\).*", "\\1", map$label)
# cleaning
map$year[map$year == "mohan"] <- 2007
map$year <- as.numeric(map$year)

  table(map$year)

# write out
write.csv(map, "bdesh_ref_nov_clean.csv")

# visual inspections
qplot(x, y, data=map, colour=factor(cluster))
qplot(year, data=map, fill=factor(cluster), geom="histogram")

map$count <- 1
map_year <- aggregate(map$count, by=list(map$year, map$cluster), FUN="sum")
names(map_year) <- c("year","cluster","count")

# stacked area
ggplot(map_year, aes(x=year, y=count, fill=factor(cluster))) + geom_area()

# stacked proportional area
map_year_prop <- ddply(map_year, "year", transform, percent = count / sum(count) * 100)

ggplot(map_year_prop, aes(x=year, y=percent, group=factor(cluster), fill=factor(cluster))) + 
  geom_area(colour="black", alpha=.4, size=.2)

# mean ellipses
plot(map$x, map$y, xlab="", ylab="", asp=1, axes=FALSE, main="Sample Data", type="n")
# Calculate and plot the first standard deviational ellipse on the existing plot
calc_sde(id=1,points=map[,c("x","y")])
plot_sde(plotnew=FALSE, plotcentre=FALSE, centre.col="red", centre.pch="1", sde.col="red",sde.lwd=1,titletxt="", plotpoints=TRUE,points.col="black")
