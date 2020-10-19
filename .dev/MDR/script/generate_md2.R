library(tidyverse)
library(hkdatasets)

quoquo <- function(x, square = FALSE){
  if(square == FALSE){
    paste0('"', x, '"')  
  } else if(square == TRUE){
    paste0('["', x, '"]')  
  }
}

data_master_raw <-
  hkdc %>%
  mutate(DropDownText = paste0(ConstituencyCode, ": ", Constituency_ZH, " / ", Constituency_EN)) %>%
  mutate(DC = paste0(DC_ZH, "/", DC_EN)) %>%
  mutate(District = paste0(District_ZH, "/", District_EN)) %>%
  mutate(Party = paste0(Party_ZH, "/", Party_EN)) %>%
  mutate(WebsiteURL = ifelse(WebsiteURL == "-", "[No other website provided]", WebsiteURL))

## map
# out_list <-
data_master_raw %>%
  select(ConstituencyCode,
         DropDownText,
         DC,
         District,
         District_EN,
         Region_EN,
         Party,
         Facebook = "FacebookURL",
         Phone,
         Email,
         Address,
         WebsiteURL) %>%
  pmap(function(ConstituencyCode,
                DropDownText,
                DC,
                District,
                District_EN,
                Region_EN,
                Party,
                Facebook,
                Phone,
                Email,
                Address,
                WebsiteURL){
    
    yaml_head <-
      paste0('---\n',
             'title: ', quoquo(DropDownText), '\n',
             'date: ', quoquo(Sys.Date()), '\n',
             # 'image: images/logo-nonhex-g.png\n',
             'image: images/dc-avatar/', str_remove(ConstituencyCode, "-"), ".png\n",
             'feature_image: images/backgrounds/wide-banner.jpg\n',
             'author: "Hong Kong Districts Info"\n',
             'summary: ', quoquo(DC), '\n',
             'iframe: ', quoquo(Facebook), '\n',
             'categories: ', quoquo(Region_EN, square = TRUE), '\n',
             'tags: ', quoquo(District_EN, square = TRUE), '\n',
             '---\n\n')
    
    text <-
      paste0('### ',
             DropDownText,
             '  \n',
             '![](/images/dc-avatar/', str_remove(ConstituencyCode, "-"), ".png)",
             '  \n\n - ',
             DC,
             '  \n - ',
             District,
             '  \n - ',
             Party,
             '  \n - ',
             Phone,
             '  \n - ',
             Email,
             '  \n - ',
             Address,
             '  \n - ',
             WebsiteURL,
             '  \n - ',
             Facebook)
    
    text <- paste0(yaml_head, text)
    
    writeLines(text = text,
               con = paste0('../../content/dc/', ConstituencyCode, '.md'),
               useBytes = TRUE)
  })


