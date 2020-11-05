library(RefManageR)
library(tidyverse)

#import bibliography as data.frame

bib_zot <- ReadBib("./bib/inquiry_textbook.bib")
bib_man <- ReadBib("./bib/inquiry_textbook_manual.bib")
bib_all <- merge(bib_zot, bib_man)

bib <- as.data.frame(merge(bib_zot, bib_man)) %>% 
  rownames_to_column() %>% 
  arrange(rowname) 

#open bib in new window

bib %>% select(rowname)

WriteBib(bib_all, file = "./bib/inquiry_textbook_all.bib")
