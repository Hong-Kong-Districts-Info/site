library(tidyverse)
library(googlesheets4)

## Read data from Google Sheets 4
sheet_url <- 'https://docs.google.com/spreadsheets/d/1007RLMHSukSJ5OfCcDJdnJW5QMZyS2P-81fe7utCZwk/'

# put gsheets into de-authorised state
# so no need to provide personal token
gs4_deauth()

data_master_raw <-
  googlesheets4::read_sheet(ss = sheet_url,
                            sheet = 'Master',
                            na = c('N/A', '')) %>% 
  # infoBox colour indicating if FB link exists
  mutate(exists_fb = if_else(condition = !is.na(x = facebook), 'blue', 'black'))

quoquo <- function(x, square = FALSE){
  if(square == FALSE){
    paste0('"', x, '"')  
  } else if(square == TRUE){
    paste0('["', x, '"]')  
  }
}

## map
# out_list <-
data_master_raw %>%
  select(ConstituencyCode,
         DropDownText,
         DC,
         District,
         Region_EN,
         Party,
         facebook) %>%
  pmap(function(ConstituencyCode,
                DropDownText,
                DC,
                District,
                Region_EN,
                Party,
                facebook){
    
    yaml_head <-
      paste0('---\n',
             'title: ', quoquo(DropDownText), '\n',
             'date: ', quoquo(Sys.Date()), '\n',
             # 'image: images/logo-nonhex-g.png\n',
             'image: images/dc-avatar/', str_remove(ConstituencyCode, "-"), ".png\n",
             'feature_image: images/blog/blog-details-image.jpg\n',
             'author: "Hong Kong Districts Info"\n',
             'summary: ', quoquo(DC), '\n',
             'iframe: ', quoquo(facebook), '\n',
             'categories: ', quoquo(Region_EN, square = TRUE), '\n',
             '---\n\n')
    
    text <-
      paste0('### ',
             DropDownText,
             '  \n',
             '![](/images/dc-avatar/', str_remove(ConstituencyCode, "-"), ".png)",
             '  \n',
             DC,
             '  \n',
             District,
             '  \n',
             Party,
             '  \n',
             facebook)
    
    text <- paste0(yaml_head, text)
    
    writeLines(text = text,
               con = paste0('../../content/dc/', ConstituencyCode, '.md'),
               useBytes = TRUE)
  })


