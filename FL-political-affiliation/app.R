#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(readxl)
library(ggplot2)
library(lubridate)

data2 <- read_excel("Voter_Registration_By_Party_Affiliation_Feb_2019.xlsx")
# Data2 is a spreadsheet containing voter registration of FL voters by party as of Feb. 2019 from 1972 to 2019.

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Florida's Republican Affiliation Over Time"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
     sidebarPanel(
       sliderInput("year", 
                   label = h3("Select Years"), 
                   min = min(unique(data2$Year)), 
                   max = max(unique(data2$Year)),
                   value = c(1972, 2019),
                   sep = "")
     ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("barPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$barPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
     gop_subset <- data2 %>% filter(Year >= input$year[1] & Year <= input$year[2])
     
    ggplot(gop_subset, aes(x = Year, y = `Republican Party of Florida`)) + 
      geom_bar(stat="identity", fill = "red", colour = "black")  
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

