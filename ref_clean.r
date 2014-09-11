# # # # # # # # # # # 
# Analysis of WoS bibliographies for arsenic research
#
# Created: 11 Sept. 2014
# Chris Jochem
# 
#

# Note: all bibliography files have been converted to ANSI format tab-delim .txt files
# and opened/resaved as tab-delimited files using MS Excel to reformat some records.
# Read in raw files from Web of Science. Downloads limited to 500 records apiece.
s1 <- read.delim("20140911_s1.txt", 
                       header=T,
                       sep="\t",
                       row.names=NULL)

s2 <- read.delim("20140911_s2.txt", 
                 header=T,
                 sep="\t",
                 row.names=NULL)

s3 <- read.delim("20140911_s3.txt", 
                 header=T,
                 sep="\t",
                 row.names=NULL)

s4 <- read.delim("20140911_s4.txt", 
                 header=T,
                 sep="\t",
                 row.names=NULL)

s5 <- read.delim("20140911_s5.txt", 
                 header=T,
                 sep="\t",
                 row.names=NULL)

refs.raw <- rbind(s1,s2,s3,s4,s5)



