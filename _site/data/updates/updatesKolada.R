### Uppdaterar data från Kolada


# libs --------------------------------------------------------------------

library(tidyverse)
library(rKolada)
# library(httr)
# library(jsonlite)
# library(readxl)
# library(writexl)



# KPI-lista + kommuner ----------------------------------------------------

kpis <- get_kpi()

munics <- get_municipality() %>%
  filter(str_sub(id, 1, 2) == "14"|id == "0000"|id == "0014") %>%
  arrange(id)



# 1 Barnfattigdomsindex efter region, år och resultat -----------

### Definition: Invånare 0-19 år i ekonomiskt utsatta hushåll, andel (%) ----------------

kpi_1 <- kpis %>%
  kpi_search("Invånare 0-19 år i ekonomiskt utsatta hushåll") %>%
  kpi_extract_ids()

df_kpi_1 <- get_values(kpi = kpi_1,
                       municipality = municipality_extract_ids(munics)) %>%
  arrange(municipality_id, year)

write_csv(df_kpi_1, "data/kommunblad/df_kpi_1_poverty.csv")



# 2 Barn och unga med minst en långtidsarbetslös förälder  ------------------

kpi_2 <- kpis %>%
  kpi_search("långtidsarbetslös förälder") %>%
  kpi_extract_ids()

df_kpi_2 <- get_values(kpi = kpi_2,
                       municipality = municipality_extract_ids(munics)) %>%
  arrange(municipality_id, year)

write_csv(df_kpi_2, "data/kommunblad/df_kpi_2_workless_parents.csv")



# 3 Migrationsbakgrund ----------------------------------------------------

kpi_3 <- kpis %>%
  kpi_search("Andel nyinvandrade elever åk. 9 inkl. okänd bakgrund. Elever ") %>%
  kpi_extract_ids()

df_kpi_3 <- get_values(kpi = kpi_3[1],
                       municipality = municipality_extract_ids(munics)) %>%
  arrange(municipality_id, year)

write_csv(df_kpi_3, "data/kommunblad/df_kpi_3_newmigrants.csv")




kpi_3b <- kpis %>%
  kpi_search("Utländsk bakgrund bland elever i åk 1-9, lägeskommun") %>%
  kpi_extract_ids()

df_kpi_3b <- get_values(kpi = kpi_3b,
                       municipality = municipality_extract_ids(munics)) %>%
  arrange(municipality_id, year)

write_csv(df_kpi_3b, "data/kommunblad/df_kpi_3b_migrantbgr.csv")



# 4 Andelen barn med anmärkning vid språktest på BVC 2½-årskontrol --------

### DATA FRÅN CBHV



# 5 Genomförda hembesök från BVC ------------------------------------------

### DATA FRÅN CBHV



# 6 Barn 1-5 år inskrivna i förskola --------------------------------------


kpi_6 <- kpis %>%
  kpi_search("Barn 1-5 år inskrivna i förskola") %>%
  kpi_extract_ids()

df_kpi_6 <- get_values(kpi = kpi_6[1],
                        municipality = municipality_extract_ids(munics)) %>%
  arrange(municipality_id, year)

write_csv(df_kpi_6, "data/kommunblad/df_kpi_6_preschool.csv")



# 7 Elever i åk 9 som är behöriga till yrkesprogram -----------------------



kpi_7 <- kpis %>%
  kpi_search("Elever i åk 9 som är behöriga till yrkesprogram") %>%
  kpi_extract_ids()

df_kpi_7 <- get_values(kpi = kpi_7[1],
                       municipality = municipality_extract_ids(munics)) %>%
  arrange(municipality_id, year)

write_csv(df_kpi_7, "data/kommunblad/df_kpi_7_gymbehorighet.csv")



# 8 Gymnasieelever med examen inom 4 år -----------------------------------

kpi_8 <- kpis %>%
  kpi_search("Gymnasieelever med examen inom 4 år") %>%
  kpi_extract_ids()

df_kpi_8 <- get_values(kpi = kpi_8[4],
                       municipality = municipality_extract_ids(munics)) %>%
  arrange(municipality_id, year)

write_csv(df_kpi_8, "data/kommunblad/df_kpi_8_gymexam.csv")



# 9 Invånare 16-24 år som varken arbetar eller studerar  ------------------

kpi_9 <- kpis %>%
  kpi_search("Invånare 16-24 år som varken arbetar eller studerar") %>%
  kpi_extract_ids()

df_kpi_9 <- get_values(kpi = kpi_9,
                       municipality = municipality_extract_ids(munics)) %>%
  arrange(municipality_id, year)

write_csv(df_kpi_9, "data/kommunblad/df_kpi_9_uvas.csv")












