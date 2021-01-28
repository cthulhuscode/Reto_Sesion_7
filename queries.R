library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
head(DataDB)

results <-  DataDB %>% filter(Language == "Spanish")
results

results <- as.data.frame(results)

ggplot(results, aes(x = CountryCode, y = Percentage, fill = IsOfficial)) +
  geom_bin2d() +
  coord_flip()