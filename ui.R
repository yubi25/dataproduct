shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Tiny Currency Convertor"),
    sidebarPanel(
      selectInput("cur_a", "Choose a currency from which to convert:", 
                  choices = c("USD", "EUR", "GBP", "JPY", "INR", "SGD", "AUD","HKD")),
      
      selectInput("cur_b", "Choose the currency to convert to:", 
                  choices = c("USD", "EUR", "GBP", "JPY", "INR", "SGD","AUD","HKD")),
      
      numericInput("how_much", "Amount to convert:", 10),
      
      h5('----------------------------------------------------------------------'),
      h5('- This tiny application converts a given amount from one currency into an other'),
      h6('- The graph at the bottom right represents the last year daily rates for this exchange rate'),
      h6('- It is for information only and rates are downloaded from oanda')
  
    ),
    mainPanel(
      h4('Today\'s rate'),
      verbatimTextOutput("rate_result"),
      h4('Convertion result'),
      verbatimTextOutput("result"),
      #tableOutput("time_serie")
      plotOutput("myHist")
    )
  )
)
