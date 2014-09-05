library(shiny)
library(quantmod)
source("helpers.R")
library(ggplot2)
require(rCharts)
library(xlsx)
diamonds <- diamonds[1:1000,]
shinyServer(function(input,output){
    ## Summary
    output$myChart1 <- renderChart({
        names(diamonds) = gsub("\\.", "", names(diamonds))
        p1 <- rPlot(input$x, input$y, data = diamonds[1:1000,], color = input$z, 
                    facet = input$z, type = 'point')
        p1$set(xScale='ordinal',yScale='linear',width=600)
        p1$addParams(dom = 'myChart1')
        return(p1)
    })
#     output$myChart2 <- renderChart({
#         map3 <- Leaflet$new()
#         map3$set(xScale='ordinal',yScale='linear',width=600)
#         map3$setView(c(51.505, -0.09), zoom = 13)
#         map3$marker(c(51.5, -0.09), bindPopup = "<p> Hi. I am a popup </p>")
#         map3$marker(c(51.495, -0.083), bindPopup = "<p> Hi. I am another popup </p>")
#         map3$addParams(dom = 'myChart2')
#         return(map3)
#     })
    ## Detailed Report
    output$mytable1 <- renderDataTable({
        diamonds[which(diamonds$cut=='Fair'), input$show_vars_tb1, drop = FALSE]
    }, options = list(bSortClasses = TRUE, aLengthMenu = c(5, 15, 30), iDisplayLength = 15))
    output$mytable2 <- renderDataTable({
        diamonds[which(diamonds$cut=='Good'), input$show_vars_tb1, drop = FALSE]
    }, options = list(bSortClasses = TRUE, aLengthMenu = c(5, 15, 30), iDisplayLength = 15))
    output$mytable3 <- renderDataTable({
        diamonds[which(diamonds$cut=='Very Good'), input$show_vars_tb1, drop = FALSE]
    }, options = list(bSortClasses = TRUE, aLengthMenu = c(5, 15, 30), iDisplayLength = 15))
    output$mytable4 <- renderDataTable({
        diamonds[which(diamonds$cut=='Premium'), input$show_vars_tb1, drop = FALSE]
    }, options = list(bSortClasses = TRUE, aLengthMenu = c(5, 15, 30), iDisplayLength = 15))
    output$mytable5 <- renderDataTable({
        diamonds[which(diamonds$cut=='Ideal'), input$show_vars_tb1, drop = FALSE]
    }, options = list(bSortClasses = TRUE, aLengthMenu = c(5, 15, 30), iDisplayLength = 15))
        
    ## Market Information
    dataInput <- reactive({  
        getSymbols(input$symb, src = "yahoo", 
                   from = input$dates[1],
                   to = input$dates[2],
                   auto.assign = FALSE)
    })
    finalInput <- reactive({
        if (!input$adjust) return(dataInput())
        adjust(dataInput())
    })
    output$plot <- renderPlot({
        chartSeries(finalInput(), theme = chartTheme("white"), 
                    type = "line", log.scale = input$log, TA = NULL)
    })
    

    
    ## Download Datasets
    datasetInput <- reactive({
        switch(input$datasetD,
               "Fair Cut" = diamonds[which(diamonds$cut=='Fair'),],
               "Good Cut" = diamonds[which(diamonds$cut=='Good'),],
               "Very Good Cut" = diamonds[which(diamonds$cut=='Very Good'),],
               "Premium Cut" = diamonds[which(diamonds$cut=='Premium'),],
               "Ideal Cut" = diamonds[which(diamonds$cut=='Ideal'),],
               "All" = diamonds)
    })
    
    output$table_download <- renderTable({
        datasetInput()
    })
    
    output$downloadData <- downloadHandler(
        filename = function() { paste(input$datasetD, '.csv', sep='') },
        content = function(file) {
            write.csv(datasetInput(), file)
        }
    )
    
    
}
)