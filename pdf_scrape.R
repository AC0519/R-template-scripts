#The goal is to extract all of the speeches from the document except the presidents.

library(pdftools)
library(tm)
library(magrittr)

#Pull in the document and split it on the line breaks
text <- pdf_text("71_PV.62.pdf") 
text <- strsplit(text, "\r\n")

#View the head of the first page
tail(text[[1]],10)


#remove header on the first page
#president_row <- grep("^President:", text)[1]
#text <- text[(president_row + 1):length(text)]


#remove footer on the first page
text <- gsub("This record contains.*", text)
