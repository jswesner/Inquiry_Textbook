library(bookdown)
library(here)
library(rmdrive)


# Update from Google Drive ------------------------------------------------


download_rmd(file = c("01-Overview"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("02-TheProcessofScience"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("03-TheStructureofScientificWriting"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("04-IntroductiontoR"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("05-ThinkingQuantitatively"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("06-DataVisualization"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("07-FindingPrimaryLiterature"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("08-Introductions"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("09-Methods"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("10-Results"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("11-Discussion"),
             path = "/Textbook_Wesner_Raiche")

download_rmd(file = c("12-References"),
             path = "/Textbook_Wesner_Raiche")



# Render Book -------------------------------------------------------------


file.remove("_main.Rmd")

# render_book("index.Rmd", output_format = "bookdown::gitbook",
#             output_dir = here("/docs"))

bookdown::publish_book(render = 'local')
bookdown::publish_book()
