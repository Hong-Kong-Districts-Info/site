data_master_raw %>%
  select(ConstituencyCode, District_EN) %>%
  mutate(ConstituencyCode = substr(ConstituencyCode, 1, 1)) %>%
  count(ConstituencyCode, District_EN) %>%
  mutate(District_EN = tolower(District_EN) %>%
           str_replace_all(" ", "-")) %>%
  pull(District_EN) %>%
  paste0("tags/", .) %>%
  enframe() %>%
  wpa::export()
