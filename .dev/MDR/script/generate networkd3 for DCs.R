library(tidyverse)
library(hkdatasets)
library(networkD3)

data(MisLinks) # source, target, value
data(MisNodes) # name, group, size

## DC to District
links1 <-
  hkdc %>%
  select(source = "DC_ZH", target = "District_ZH") %>%
  mutate(value = 1)

## DC to Party
links2 <-
  hkdc %>%
  select(source = "DC_ZH", target = "Party_ZH") %>%
  mutate(value = 1)

## Bind links
links_tb <-
  rbind(links1, links2)

## counts
# n_distinct(links1$source) # DCs
# n_distinct(links1$target) # Districts
# n_distinct(links2$target) # Parties

val1 <- rep(1, n_distinct(links1$source))
val2 <- seq(2, n_distinct(links1$target) + 1)
val3 <- seq(max(val2) - 1, n_distinct(links2$target) + max(val2) - 2)


nodes <-
  c(links_tb$source,
    links_tb$target) %>%
  unique() %>%
  tibble(name = .) %>%
  mutate(group = c(val1, val2, val3)) %>%
  mutate(size = 1) %>%
  mutate(id = 0:(nrow(.) - 1))

links <-
  links_tb %>%
  left_join(select(nodes, name, source_id = "id"),
            by = c("source" = "name")) %>%
  left_join(select(nodes, name, target_id = "id"),
            by = c("target" = "name")) %>%
  select(source_id, target_id, value) %>%
  rename(source = "source_id", target = "target_id")

# Plot
dc_network_plot <-
  forceNetwork(
    Links = links,
    Nodes = nodes,
    Source = "source",
    Target = "target",
    Value = "value",
    NodeID = "name",
    Group = "group",
    opacity = 0.95,
    zoom = TRUE,
    fontSize = 15)


htmlwidgets::saveWidget(dc_network_plot, "dc_network_plot.html")
