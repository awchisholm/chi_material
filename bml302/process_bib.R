#install.packages("bib2df")
library(bib2df)
library(dplyr)
if (file.exists('refs.qmd')) {
  file.remove('refs.qmd')
}
#bib_file = params$bibliography_file

bibdf = suppressMessages(bib2df::bib2df('Chi302.bib'))
#bibdf = suppressMessages(bib2df::bib2df(bib_file))

# This creates one bullet entry for each item in the bibliography file
# It uses any notes found to add as text before the in-text citation
#
texdf2 <-
  bibdf %>%
  dplyr::select(BIBTEXKEY, NOTE, TITLE) %>%
  dplyr::mutate(NOTE = ifelse(is.na(NOTE), "", NOTE)) %>%
  dplyr::mutate(TITLE = gsub(pattern='[{}]', replacement='', TITLE)) %>%
  dplyr::mutate(item = paste0('- ', TITLE, '. ',  NOTE, " [@", BIBTEXKEY, '].'))

writeLines(texdf2$item, 'refs.qmd')
