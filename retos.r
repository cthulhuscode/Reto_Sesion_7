###              ###
##     RETO 1     ##
###              ### 



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






###              ###
##     RETO 2     ##
###              ### 


# De la siguiente dirección donde se muestran los sueldos para Data Scientists
# 
# (https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm), realiza las siguientes acciones:
#   
# Extraer la tabla del HTML
# 
# Quitar los caracteres no necesarios de la columna sueldos (todo lo que no sea número), 
# para dejar solamente la cantidad mensual (Hint: la función gsub podría ser de utilidad)
# 
# Asignar ésta columna como tipo numérico para poder realizar operaciones con ella
# 
# Ahora podrás responder esta pregunta ¿Cuál es la empresa que más paga y la que menos paga?



library(rvest)

theurl <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(theurl)    

tables <- html_nodes(file, "table")  

table1 <- html_table(tables[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))   

str(table) 


sueldo <- gsub("MXN","",table$Sueldo)
sueldo <- gsub(",","",sueldo)
sueldo <- gsub("/mes","",sueldo)
sueldo <- gsub("[^0-9​.]", "", sueldo)
sueldo


cargo <- gsub("Sueldos para Data Scientist en","", table$Cargo)
cargo <- gsub("- [0-9] sueldos informados","", cargo)
cargo

sueldo <- as.numeric(sueldo)

# Agregar filas modificadas
table$Sueldo <- sueldo
table$Cargo <- cargo

# Max sueldo
maxSueldo <- which.max(table$Sueldo)
table[maxSueldo,]

# Min sueldo
maxSueldo <- which.min(table$Sueldo)
table[maxSueldo,]






###              ###
##     RETO 3     ##
###              ### 







