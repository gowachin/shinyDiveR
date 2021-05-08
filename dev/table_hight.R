library(formattable)
DF <- data.frame(Ticker=c("", "", "", "IBM", "AAPL", "MSFT"),
                 Name=c("Dow Jones", "S&P 500", "Technology", 
                        "IBM", "Apple", "Microsoft"),
                 Value=accounting(c(15988.08, 1880.33, NA, 
                                    130.00, 97.05, 50.99)),
                 Change=percent(c(-0.0239, -0.0216, 0.021, 
                                  -0.0219, -0.0248, -0.0399)))
DF
##   Ticker       Name     Value Change
## 1         Dow Jones 15,988.08 -2.39%
## 2           S&P 500  1,880.33 -2.16%
## 3        Technology        NA  2.10%
## 4    IBM        IBM    130.00 -2.19%
## 5   AAPL      Apple     97.05 -2.48%
## 6   MSFT  Microsoft     50.99 -3.99%
a = formattable(DF, list(
  Name=formatter(
    "span",
    style = x ~ ifelse(x == "Technology", 
                       style(font.weight = "bold"), NA)),
  Value = color_tile("white", "orange"),
  Change = formatter(
    "span",
    style = x ~ style(color = ifelse(x < 0 , "red", "green")),
    x ~ icontext(ifelse(x < 0, "arrow-down", "arrow-up"), x)))
)
a


library("shinydashboard")
library("shiny")
library("formattable")

body <- dashboardBody(
  fluidRow(
    column(width = 12,
           box(formattableOutput("table"))
    )
  )
)

ui <- dashboardPage(
  dashboardHeader(title = "Column layout"),
  dashboardSidebar(),
  body
)

server <- function(input, output) {
  
  test.table <- data.frame(lapply(1:8, function(x) {1:10}))
  
  output$table <- renderFormattable({formattable(test.table, list())})
}
shinyApp(ui = ui, server = server)