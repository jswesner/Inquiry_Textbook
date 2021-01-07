library(bookdown)
library(here)

# file.remove("_main.Rmd")

# render_book("index.Rmd", output_format = "bookdown::gitbook",
#             output_dir = here("/docs"))

# bookdown::publish_book()
bookdown::publish_book(render = 'local')
