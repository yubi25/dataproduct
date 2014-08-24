library(UsingR)
library("tseries")
library("zoo")
library("ggplot2")

shinyServer(
  function(input, output) {
    
    # Boundaries between today and one year ago to download the timeserie
    DateEnd<-Sys.Date()
    DateStart<-DateEnd-365
    
    # Convert the currencies choosen into a symbology understandable by oanda
    # For instance cur_a=USD, cur_b=GBP, result is USD/GBP
    cross <- reactive({
      paste(input$cur_a,input$cur_b,sep="/")
    })
    
    # Downloads from oanda the daily closing rates starting from today and up to one year ago
    time_serie <- reactive({
      get.hist.quote(instrument = cross(), provider = "oanda", start = DateStart, end = DateEnd)
    })
    
    # Get today's rate for the convertion
    todays_rate <- reactive({
      coredata(time_serie())[length(coredata(time_serie()))]
    })
    
    # Convert the amount from cur_a to cur_b
    converted_money <- reactive({
      input$how_much*todays_rate()
    })
    
    # Full sentence to display about convertion
    result<-reactive({
      paste(input$how_much,input$cur_a,"is",converted_money(),input$cur_b,"as of",DateEnd,sep=" ")
    })
    
    # Display convertion rate only
    rate_result<-reactive({
      paste(cross(),"=",todays_rate(),sep=" ")
    })
    
    # Printing
    output$todays_rate <- renderText({
      todays_rate()
    })
    output$result<- renderText({
      result()
    })
    output$rate_result<- renderText({
      rate_result()
    })
    output$view <- renderTable({
      head(time_serie(), n = 50)
    })
    
    # Final Graph
   output$myHist <- renderPlot({
     ggplot(aes(x = Index, y = Value), data = fortify(time_serie(), melt = TRUE)) + geom_line() + xlab("Date") + ylab("Exchabge Rate")
    })
    
  }
)
