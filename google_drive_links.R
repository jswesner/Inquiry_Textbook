library(googledrive)
library(here)
library(tidyverse)

# drive_find(pattern = "Textbook_Wesner_Raiche")

#make a list of word files of chapters
word_files <- list.files(path = "C:/Users/Jeff.Wesner/Documents/GitHub/Inquiry_Textbook", 
           pattern = ".docx")

#upload word files of chapters
Chapters <- map(word_files, ~ drive_upload(.x, path = as_id("1bnnun4OfCSUTdygYVh2XB6rJFndjmrp5"), verbose = FALSE))

#Import word files of chapters