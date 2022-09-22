#install.packages("bib2df")
library(bib2df)
library(dplyr)
if (file.exists('refs.qmd')) {
  file.remove('refs.qmd')
}
#bib_file = params$bibliography_file
ls()
bibdf = suppressMessages(bib2df::bib2df('Chichester.bib'))
#bibdf = suppressMessages(bib2df::bib2df(bib_file))

#\item text from note \parencite{fewShowMeNumbers2012}.
texdf =
  bibdf %>%
  dplyr::select(BIBTEXKEY, NOTE, TITLE) %>%
  dplyr::mutate(NOTE = ifelse(is.na(NOTE), "", NOTE)) %>%
  dplyr::mutate(TITLE = gsub(pattern='[{}]', replacement='', TITLE)) %>%
  dplyr::mutate(item = paste0("\\item ", TITLE, '. ', NOTE, " \\parencite{", BIBTEXKEY, "}.")) %>%
  dplyr::select(item)

writeLines(texdf$item, 'tex.txt')

texdf2 <-
  bibdf %>%
  dplyr::select(BIBTEXKEY, NOTE, TITLE) %>%
  dplyr::mutate(NOTE = ifelse(is.na(NOTE), "", NOTE)) %>%
  dplyr::mutate(TITLE = gsub(pattern='[{}]', replacement='', TITLE)) %>%
  dplyr::mutate(item = paste0('- ', TITLE, '. ',  NOTE, " [@", BIBTEXKEY, '].'))

writeLines(texdf2$item, 'refs.qmd')
