#R - for help ?command
#To run: put the cursor over the command and press "Run" 
#
# Find a flood with a given returnperiod.
# Based on the lmomco library by W.H.Asquith
# The lmomco package fits the flood frequency distribution using l-moments
# You may need to install this, use the install.packages("lmomco") from the R prompt
#
#Load the library
library(lmomco)
#
# Tables - if missing install.packages("gt")
library(gt)
#
# For processing data for the table
library(dplyr)
library(tidyr)

#Read the data from a txt file, one column with year and one column with yearly max flood
#See the example in hokfossen.txt.
#The data is stored in the data.frame data, header=TRUE means that there is a header in the file
#Try to type head(data) in R to see the top of the file
#
data<-read.table("Hoggas.txt", header=TRUE)

# Lets plot a histogram of the data. 
#(address a column in a data.frame by using $ between the data frame name and the column name)
#
barplot(data$Qmaks,names=data$Aar,ylab="Qmaks (m3/s)")

# Find L-moments from input flood values 
#
lmom<-lmoms(data$Qmaks)

# Fordelingar
ford <- c("gev","gno","pe3","ln3","gum")

#Convert a T-year return period to a non-exceedance probability
#tyear is the return period
#
tyear = 200
non <- T2prob(tyear)
print(1-non)

#Find the T-year flood for a given distribution, 
#The t-year non-exceedance probability is now stored in non.
#Some distributions:
#Generalized extreme value - "gev"
#Generalized Normal - "gno"
#Pearson3 - "pe3"
#Log-Normal3 - "ln3"
#Gumbel - "gum"
#
#As it is it uses "gev" - change the code to see other distributions
#Change tyear to see other return periods.
#The result is written on the screen
#

distribution ="gum"
tflood <- qlmomco(non,lmom2par(lmom, type=distribution))

print(paste(tyear,"year flood: ",round(tflood,0),"m3/s. Distribution: ",fordeling))

####################################################################################
### MAKE A TABLE WITH 
## Q2.3 is the mean flood
##
ford <- c("gev","gno","pe3","ln3","gum")
gint <- c(2.3,5,10,15,20,50,100,200,500,1000)

# Make a table showing the various distributions
noval <- length(gint)
nodist <- length(ford)
res <- data.frame(FF=character(noval*nodist),RetP=numeric(noval*nodist),value_f=numeric(noval*nodist))

lnum=1
cnum=1
lmom<-lmoms(data$Qmaks)

# Compute table
for (j in 1:length(ford)){
  for (i in 1:length(gint)) {
    non = T2prob(gint[i])
    fo <- qlmomco(non,lmom2par(lmom, type=ford[j]))
    
    res[lnum,] <- c(ford[j],gint[i],round(fo,0))
    print(paste("(",i,",",j,"):", ford[j],"/",gint[i]," : ",fo))
    lnum <- lnum+1
  }
  cnum <- cnum+1
}

res$RetP <- as.numeric(res$RetP)
res$value_f <- as.numeric(res$value_f)

## Make wide format, using gt to create table.
#
#tmp_w <- pivot_wider(res,names_from = "RetP", values_from = "value_f")
res_w <- reshape(res, timevar="RetP",idvar="FF",direction="wide")
names(res_w) <- gsub("value_f.","Q",names(res_w))

t <- gt(res_w)
t <- data_color(t,1,"red")
t <- tab_options(t,column_labels.font.weight = "bold")
print(t)

#This small piece of code plots the histogram of data and fits a normal distribution
#to the data (dnorm function) and plot it as a curve (curve command)
#
#x=seq(from = 1,to = 400,length.out=25)
#hint=seq(0,400,25)
#hist(data$Qmaks,prob=TRUE, breaks=22, xlim=c(50,360))
#curve(dnorm(x, mean=mean(data$Qmaks), sd=sd(data$Qmaks)), add=TRUE, col = "red")

