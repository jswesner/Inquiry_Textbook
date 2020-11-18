library(bookdown)

file.remove("_main.Rmd")

render_book("index.Rmd", output_format = "bookdown::gitbook",
            output_dir = "/docs")

