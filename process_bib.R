#install.packages("bib2df")
library(bib2df)
library(dplyr)
bibdf = bib2df::bib2df('Chichester.bib')

#\item text from note \parencite{fewShowMeNumbers2012}.
texdf =
  bibdf %>%
  dplyr::select(BIBTEXKEY, NOTE) %>%
  dplyr::mutate(NOTE = ifelse(is.na(NOTE), "", NOTE)) %>%
  dplyr::mutate(item = paste0("\\item ", NOTE, " \\parencite{", BIBTEXKEY, "}.")) %>%
  dplyr::select(item)


