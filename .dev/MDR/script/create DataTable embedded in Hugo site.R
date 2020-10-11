library(hkdatasets)
library(tidyverse)

data_source <-
  hkdc %>%
  as_tibble() %>%
  mutate(DC_EN = str_replace(DC_EN, "\\(", "- ")) %>%
  mutate(DC_EN = str_remove(DC_EN, "\\)")) %>% # Overcome issue with brackets not rendering properly in YAML
  mutate(DC_EN = str_remove_all(DC_EN, "\\r")) %>%
  mutate(DC_EN = str_remove_all(DC_EN, "\\n")) %>%
  mutate(Email = ifelse(Email == "-", "N/A", Email))

data_source$ConstituencyCode %>%
  purrr::map(function(x){
    
    used_row <- data_source %>% filter(ConstituencyCode == x)
    
    paste0(
      "   - name: ", paste(used_row$DC_ZH, used_row$DC_EN, sep = " / "), "\n",
      "     district: ", paste(used_row$District_ZH, used_row$District_EN, sep = " / "), "\n",
      "     constituency: ", paste(used_row$Constituency_ZH, used_row$Constituency_EN, sep = " / "), "\n",
      "     party: ", paste(used_row$Party_ZH, used_row$Party_EN, sep = " / "), "\n",
      "     email: ", used_row$Email, "\n",
      "     phone: ", used_row$Phone, "\n",
      "     facebook: ", used_row$FacebookURL, "\n",
      "     sitelink: https://hong-kong-districts-info.github.io/dc/", tolower(used_row$ConstituencyCode), "\n"
           )
  }) %>%
  paste(collapse = "\n") %>%
  paste0("  dc_table:\n", .) %>%
  # writeLines("output_yaml/dc_table.yml", useBytes = TRUE)
  writeLines("../../data/dc_table.yml", useBytes = TRUE)
