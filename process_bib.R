#install.packages("bib2df")
library(bib2df)
library(dplyr)
bibdf = bib2df::bib2df('Chichester.bib')

#\item text from note \parencite{fewShowMeNumbers2012}.
texdf =
  bibdf %>%
  dplyr::select(BIBTEXKEY, NOTE, TITLE) %>%
  dplyr::mutate(NOTE = ifelse(is.na(NOTE), "", NOTE)) %>%
  dplyr::mutate(TITLE = gsub(pattern='[{}]', replacement='', TITLE)) %>%
  dplyr::mutate(item = paste0("\\item ", TITLE, '. ', NOTE, " \\parencite{", BIBTEXKEY, "}.")) %>%
  dplyr::select(item)

writeLines(texdf$item, 'tex.txt')
