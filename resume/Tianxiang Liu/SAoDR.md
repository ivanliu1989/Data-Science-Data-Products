---
title       : Shiny App of Diamonds Report
subtitle    : Reproducible Pitch Presentation
author      : Tianxiang Liu
job         : 05 Sep 2014
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : solarized_light      # 
widgets     : [mathjax, quiz, bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- 

## 1. Introduction of Application
This is a presentation to give a breif description about the shiny application of Diamonds Report.</br>
To begin with, there are four main functions/pages in this application, which are 'summary', 'detailed report', 'download datasets' and 'exchange rate'. </br>
Users can access to above four pages via the bar on the top of each page as following: </br></br>
![width](menu.png)</br></br>
In details, a user can do following things in each page: </br> </br>
Next Slide

--- .class #id 

## 2. Summary Page
Summary page is a summary of all diamond product information. Users are able to visualize data from different aspects or attributes of products. Product details have been visualized by a point plot and users are able to customize their own summary chart by selecting different variables users want to explore on x or y axis. You can also choose the categories of diamonds to compare different groups of diamonds.</br> 
Following is a list of all variables users are able to adjust in summary chart. </br></br>

```r
require(ggplot2)
names(diamonds[,1:7])
```

```
[1] "carat"   "cut"     "color"   "clarity" "depth"   "table"   "price"  
```

---

## 3. Detailed Reports Page
Detailed Reports page allow users to view the details of diamonds based on different cut types.</br>
Users can select the variables they want to include in the table. </br>
Users can sort table by different variables and search record based on their preferences. </br>
Users can also determine how many records they want to show on one page. </br>
Following is a screenshoot of detailed reports page </br>
![width](2.png)</br></br>

---

## 4. Download Datasets Page
Download Datasets page allow users to download the entire datasets of diamond products information.Users can select a specific type of  diamonds that they are interested. And the required table will be displayed on the right side of the page. </br>
After that, users need to click the download button as the picture below. </br>

![width](3.png)</br></br>

---

## 5. Exchange Rate Page
Sometimes there will be international trade for diamonds business. So a real-time exchange rate function seems to be necessary in this application.  </br>
In the last page, users can obtain the latest exchange rate regarding the selected currency from the chart above.  </br>
Users are required to select a currency type first, then information will be collected from yahoo finance and be reflected to the line chart below. </br>
![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2.png) 
