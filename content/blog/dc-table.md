---
title: "Experimental DataTables in Hugo"
author: Martin Chan
date: 2019-09-06T00:00:00+00:00
draft: true
---

Note: this is an attempt to add DataTables to the Hugo site.

https://input.sh/hugo-data-into-content-with-a-shortcode/

# District Councillors

List of Hong Kong District Councillors (2019):

<!-- {{< book-list data = "books" >}} -->
{{< dc-list data = "dc_table" >}}