---
title: "Hong Kong District Councillors"
date: 2019-12-30T20:56:42+06:00
type: portfolio
image: "images/projects/2560px-2019DC_election_map_by_official_party_affiliation.svg.png"
category: ["PROJECTS"]
# project_images: ["images/projects/spongebob-hammer.gif"]
---

### Project Objective

Our project objective is as follows:

>  To provide a convenient site for live information on the district councillors in Hong Kong, via aggregating posts and feeds from their public Facebook pages.

---

### The App
The Shiny app is deployed onto shinyapps.io in the links below:

https://hkdistricts-info.shinyapps.io/dashboard-hkdistrictcouncillors/

### GitHub Repository
The GitHub repo can be accessed [here](https://github.com/Hong-Kong-Districts-Info/dashboard-hkdistrictcouncillors). 

As part of the philosophy of the project, we have tried to adhere as closely as possible to the best practices in open-source app development. This includes:

- Version control (git)
- Dependency management (using the package {renv})
- Cookie use permission (a pop out dialogue to request user permission)

### Data sources
This app uses data from:
- Wikipedia
- Facebook pages from each District Councillor
- [Shapefiles of Hong Kong District Councils]https://accessinfo.hk/en/request/shapefileshp_for_2019_district_c)

Most of the data is put together as part of our other project {hkdatasets}, which collects public domain data about Hong Kong district councillors in an R package. Click [here](../../portfolio/hkdatasets/) to find out more.
