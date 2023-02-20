#  Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)

# Data Import
Adata_tbl <- read_delim("../data/Aparticipants.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
Anotes_tbl <- read_csv("../data/Anotes.csv")
Bdata_tbl <- read_delim("../data/Aparticipants.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
Bnotes_tbl <- read_tsv("../data/Bnotes.txt")
# Data Cleaning

Aclean_tbl <- Adata_tbl |> 
  separate(qs, into = paste0("q",1:5), sep = " - ") |> 
  mutate(datadate = as.POSIXct(datadate, format = "%b %d %Y, %H:%M:%S"),
         across(q1:q5, as.integer)) |> 
  inner_join(Anotes_tbl, by = "parnum") |> 
  filter(is.na(notes))
 
  