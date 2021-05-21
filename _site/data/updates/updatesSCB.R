### Uppdatera data från SCB via deras API.

library(tidyverse)
library(pxweb)
library(writexl)

year <- 2019


# Folkmängd per kön och åldersgrupp ---------------------------------------

### Hämtar data för befolkningsstorlek per kön och 5-årsåldersgrupp per kommun och sparar ned till excelformat i popsize.xlsx.
### Använder json_query_popsize.json för att definiera kategorier. Önskat årtal behöver ändras i json-filen

xx <- pxweb_get("http://api.scb.se/OV0104/v1/doris/sv/ssd/BE/BE0101A/BefolkningNy",
                query = "data/updates/json_query_popsize.json") %>% 
  as.matrix(xx, column.name.type = "text", variable.value.type = "code")

df <- as_tibble(xx) %>% 
  mutate(popsize = as.numeric(BE0101N1),
         agegrp = as.factor(Alder) %>% 
           fct_relevel("-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49",
                        "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85-89", "90-94", "95-99", "100+")) %>%
  group_by(Region,
           agegrp,
           Kon) %>% 
  summarise(popsize = sum(popsize, na.rm = TRUE)) %>% 
  ungroup()

write_xlsx(df, "data/kommunblad/popsize.xlsx")



# Antal invånare efter födelseregion, åldersgrupper och kön 2020 -------------------------

xx <- pxweb_get("http://api.scb.se/OV0104/v1/doris/sv/ssd/START/BE/BE0101/BE0101E/InrUtrFoddaRegAlKon",
                query = "data/updates/json_query_utrfodda.json") %>% 
  as.matrix(xx, column.name.type = "text", variable.value.type = "code")

df <- as_tibble(xx) %>% 
  mutate(popsize = as.numeric(Folkmängd),
         agegrp = as.factor(ålder) %>% 
           fct_relevel("-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49",
                       "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85-89", "90-94", "95-99", "100+")) %>% 
  group_by(region,
           agegrp,
           kön,
           födelseregion) %>% 
  summarise(popsize = sum(popsize, na.rm = TRUE)) %>% 
  ungroup() %>% 
  mutate(kön = recode(kön, "1" = "Män", "2" = "Kvinnor"),
         födelseregion = recode(födelseregion, "09" = "Född i Sverige", "11" = "Utrikes född"))

write_xlsx(df, "data/kommunblad/utlfodda.xlsx")



# Antalet nyfödda per kön 1999- -------------------------------------------

xx <- pxweb_get("http://api.scb.se/OV0104/v1/doris/sv/ssd/START/BE/BE0101/BE0101H/FoddaK",
                query = "data/updates/json_query_nyfodda.json")  %>% 
  as.matrix(xx, column.name.type = "code", variable.value.type = "code")

df <- as_tibble(xx) %>% 
  mutate(popsize = as.numeric(BE0101E2))  %>% 
         # agegrp = as.factor(ålder) %>% 
         #   fct_relevel("-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49",
         #               "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85-89", "90-94", "95-99", "100+")) %>% 
  # group_by(Region,
  #          # agegrp,
  #          Kon)+
  #          # födelseregion) %>% 
  # summarise(popsize = sum(popsize, na.rm = TRUE)) %>% 
  # ungroup() %>% 
  mutate(Kon = recode(Kon, "1" = "Män", "2" = "Kvinnor")) %>% 
  select(region = Region,
         kön = Kon,
         year = Tid,
         popsize)

write_xlsx(df, "data/kommunblad/nyfodda.xlsx")


