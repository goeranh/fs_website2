### Detta script uppdaterar data från Folkhälsomyndigheten. Myndigheten har f.n. inte något API varför data måste hämtas hem manuellt.
### Scriptet bygger på att data hämtas från myndighetens statistikdatabas (http://fohm-app.folkhalsomyndigheten.se/Folkhalsodata/pxweb/sv/) och 
### exporteras i text-format som en relationsdatafil. Detaljerna beskrivs närmare för varje indikator nedan.


# libs --------------------------------------------------------------------

library(tidyverse)



# Barnfattigdom -----------------------------------------------------------

### Data hämtas från http://fohm-app.folkhalsomyndigheten.se/Folkhalsodata/pxweb/sv/A_Folkhalsodata/A_Folkhalsodata__1_Tidigalivetsvillkor__cBarnfattigdom/Barnfattigdom.px/
### 1. Under Region välj "Kommun" -> samtliga kommuner 1401 till 1499
### 2. Under Resultat välj samtliga alternativ
### 3. UnderÅr välj samtliga alternativ
### 4. Klicka på "Fortsätt".
### 5. Spara tabellen som "Relationstabell som textfil" (i rullisten) och klicka på Spara till fil.
### 6. Kopiera över den exporterade text-filen till data-mappen (../data/kommunblad/)

df <- read_delim("data/kommunblad/Barnfattigdom.txt", 
                 delim = "\t",
                 locale = locale(encoding = "windows-1257"))

