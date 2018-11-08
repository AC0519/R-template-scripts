library(pdftools)
library(tm)
library(magrittr)

text <- pdf_text("71_PV.62.pdf") 
        
text <- strsplit(text, "\n")

head(text[[1]])