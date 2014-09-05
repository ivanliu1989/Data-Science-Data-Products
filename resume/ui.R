library(shiny)
library(ggplot2)  # for the diamonds dataset
require(rCharts)
options(shiny.maxRequestSize = 9*1024^2)
shinyUI(navbarPage("AfterPlus Product Report", inverse = FALSE, collapsable = FALSE,
                   tabPanel("Summary",
                            fluidRow(
                                sidebarPanel(
                                    selectInput(inputId = "x",
                                                label = "Choose X",
                                                choices = c('clarity', 'depth', 'price', 'carat'),
                                                selected = "price"),
                                    selectInput(inputId = "y",
                                                label = "Choose Y",
                                                choices = c('clarity', 'depth', 'price', 'carat'),
                                                selected = "caret"),
                                    selectInput(inputId= "z",
                                                label = "Choose Category",
                                                choices = c('cut','color','clarity'),
                                                selected = 'cut')
                                ),
                                mainPanel(
                                    showOutput("myChart1", "polycharts")
                                )
                            ),
                            fluidRow(
#                                 sidebarPanel(
#                                     
#                                 ),
#                                 mainPanel(
# #                                    showOutput("myChart2", "Leaflet")
#                                 )
                            )
                   ),
                   tabPanel("Detailed Report",
                            sidebarLayout(
                                sidebarPanel(
                                        checkboxGroupInput('show_vars_tb1','Columns in Dongdamen to show:',
                                                           names(diamonds), selected = names(diamonds))       
                                ),
                                mainPanel(
                                    tabsetPanel(
                                        id='dataset',
                                        tabPanel('Fair Cut', dataTableOutput('mytable1')),
                                        tabPanel('Good Cut', dataTableOutput('mytable2')),
                                        tabPanel('Very Good Cut', dataTableOutput('mytable3')),
                                        tabPanel('Premium Cut', dataTableOutput('mytable4')),
                                        tabPanel('Ideal Cut', dataTableOutput('mytable5'))
                                    )
                                )
                            )),
                   navbarMenu("More",
                              tabPanel("Download Datasets",
                                       sidebarLayout(
                                           sidebarPanel(
                                               selectInput("datasetD", "Choose a dataset:", 
                                                           choices = c("Fair Cut", "Good Cut", 
                                                                       "Very Good Cut", "Premium Cut", 
                                                                       "Ideal Cut", "All"), 'All'),
                                               downloadButton('downloadData', 'Download')
                                           ),
                                           mainPanel(
                                               tableOutput('table_download')
                                           )
                                       )),
                              tabPanel("Market Information", 
                                       sidebarLayout(
                                           sidebarPanel(
                                               helpText("Select a currency. Information will be collected from yahoo finance."),
                                               textInput("symb", "Symbol", "AUD"),
                                               dateRangeInput("dates", "Date range", 
                                                              start = "2014-01-01", 
                                                              end = as.character(Sys.Date())),
                                               actionButton("get", "Get Stock"),
                                               br(),br(),
                                               checkboxInput("log", "Plot y axis on log scale", value = FALSE),
                                               checkboxInput("adjust", "Adjust prices for inflation", value = FALSE)
                                           ),
                                           mainPanel(plotOutput("plot"))
                                       )
                              )
                   )
)
)