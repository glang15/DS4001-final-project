
# library(readr)
# setwd("C:\\Users\\Student\\Documents\\4th year\\Data Science\\Final Project\\name.basics.tsv")
# data=read_tsv(file = 'data.tsv')
# data

setwd("C:/Program Files (x86)/Dropbox Folder Sync/Documents/UVA/DS 4559/Final Project")
#setwd("C:\\Users\\Student\\Documents\\4th year\\Data Science\\Final Project\\tmdb-5000-movie-dataset")
data_credits <- read.csv('tmdb_5000_credits.csv')
data_movies<-read.csv('tmdb_5000_movies.csv')

# Library packages
library(tidyverse)
library(Amelia)
library(rlist)

# Combine movies and credits into one data frame
data_credits <- data_credits %>% select(-title)
data_complete <- cbind(data_credits, data_movies)
summary(data_complete)

# View summary statistics
View(data_complete)
head(data_complete)
names(data_complete)

# Determine any missing data
pMiss <- function(x){sum(is.na(x))/length(x)*100}
apply(data_complete,2,pMiss)
max(apply(data_complete,1,pMiss))
missmap(data_complete)
# Only runtime has missing values (4%)

# Get rid of keywords and tagline because not doing any language processing
data_complete <- select(data_complete, -c("tagline", "keywords", "overview", "homepage","id"))

# Check for duplicated rows
data_completec <- unique(data_complete)
# No duplicated rows

# Feature engienering
# Create day, month, and year variables
data_complete$Year <- substr(data_complete$release_date, 1, 4)
data_complete$Month <- substr(data_complete$release_date, 6, 7)
data_complete$Day <- substr(data_complete$release_date, 9, 10)
data_complete <- data_complete %>% select(-release_date)

# Check for unusual values
unique(data_complete$Year)
unique(data_complete$Month)
unique(data_complete$Day)
# Some missing values

# Get the number of langauges released
# data_complete$spoken_languages <- as.character(data_complete$spoken_languages)
# data_complete$spoken_languages <- strsplit(data_complete$spoken_languages, ",")
# for(i in 1:4803){
#   data_complete$spoken_language_count <- list.count(data_complete$spoken_languages[[i]])
# }

# Refactor variables
data_complete <- as.factor(data_complete$movie_id)

