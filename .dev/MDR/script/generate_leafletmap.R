library(leaflet)
library(tidyverse)
library(sf)
library(hkdatasets)

path_shape_district <- here::here("data", "dcca_2019", "DCCA_2019.shp")

## shapefiles
shape_district <- st_read(dsn = path_shape_district)
shape_district <- st_transform(x = shape_district, crs = 4326)
shape_district$centroids <- shape_district %>% 
  st_centroid() %>% 
  st_coordinates()


data_master_raw <-
  hkdc %>%
  mutate(# remove hyphen for joining to shape file
         ConstituencyCode = gsub(x = ConstituencyCode, pattern = "-", replacement = "")) %>%
  left_join(y = shape_district, by = c("ConstituencyCode" = "CACODE")) %>%
  mutate(Region = paste(Region_ZH, "/", Region_EN),
         District = paste(District_ZH, "/", District_EN),
         Party = paste(Party_ZH, "/", Party_EN),
         DC = paste(DC_ZH, "/", DC_EN),
         DropDownText = paste0("<a href = ",
                               '"',
                               DCProjectPageURL,
                               '" ',
                               'target="_blank">',
                               ConstituencyCode,
                               "</br>",
                               Constituency_ZH,
                               " / ",
                               Constituency_EN,
                               "</br>",
                               DC,
                               "</a>"))

arbitrary_view <-
  data_master_raw %>%
  filter(ConstituencyCode == "E17")


map_hk_districts <-
  leaflet(data = st_as_sf(data_master_raw)) %>% 
  addTiles() %>% 
  # addProviderTiles(providers$Stamen.Toner) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(weight = 0.5, 
              fillOpacity = 0.1, 
              color = '#009E73',
              highlightOptions = highlightOptions(color = '#000000', 
                                                  weight = 5,
                                                  bringToFront = TRUE),
              popup = data_master_raw$DropDownText,
              options = popupOptions(clickable = TRUE,
                                     closeOnClick = TRUE)) %>%
  setView(lng = arbitrary_view$centroids[,"X"],
          lat = arbitrary_view$centroids[,"Y"],
          zoom = 13)

## Save leaflet file
htmlwidgets::saveWidget(map_hk_districts, "MapHKDistricts.html")
  

# map_hk_districts %>%
  # addPolygons(data = arbitrary_view,
  #             color = '#D55E00',
  #             weight = 0.5,
  #             fillOpacity = 0.6) %>%
  # addPopups(lng = arbitrary_view$centroids[,"X"],
  #           lat = arbitrary_view$centroids[,"Y"],
  #           popup = arbitrary_view$DropDownText) %>%
  # centre map on user-chosen district
  # setView(lng = arbitrary_view$centroids[,"X"],
  #         lat = arbitrary_view$centroids[,"Y"],
  #         zoom = 30)
