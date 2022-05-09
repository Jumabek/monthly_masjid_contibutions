#install.packages('gsheet')
library(ggplot2)
library(gsheet)
library(ggridges)
library(dplyr)
library(tidyr)
library(readr)
#install.packages("dplyr") 


# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Hello Shiny!"),
  
  # Sidebar layout with input and output definitions ----
  #sidebarLayout(
    
    # Sidebar panel for inputs ----
    #sidebarPanel(
      
      # sliderInput(inputId = "bins",
      #             label = "Number of bins:",
      #             min = 1,
      #             max = 50,
      #             value = 30)
      
    #),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      
    )
  #)
)


server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    
    df <- gsheet2tbl('https://docs.google.com/spreadsheets/d/1eDroRXXyC59goS7J8cyZ3-OJcqLX5HkOgyyF78hQq_o/edit#gid=0')
    
    df <- df[!is.na(df$Name),]
    df <- head(df, - 1)              # Apply head function
    df <- df %>%
      pivot_longer(!Name, names_to = "month", values_to = "amount")
    df$amount <- parse_number(df$amount)
    df[is.na(df$amount), "amount"] <- 0.


    ggplot(df, aes(x = amount, y = month, fill = stat(x))) +
      geom_density_ridges_gradient(scale = 1, rel_min_height = 0.01, panel_scaling=FALSE) +
      #geom_density_ridges(alpha=0.3, stat="binline", bins=20) +
      scale_fill_viridis_c(name = "Temp. [F]", option = "C") +
      labs(title = 'Uzbek Grad S. Contributions')
    
  })
  
}


shinyApp(ui = ui, server = server)


# df <- gsheet2tbl('https://docs.google.com/spreadsheets/d/1eDroRXXyC59goS7J8cyZ3-OJcqLX5HkOgyyF78hQq_o/edit#gid=0')
# 
# df <- df[!is.na(df$Name),]
# df <- head(df, - 1)              # Apply head function
# df <- df %>%
#   pivot_longer(!Name, names_to = "month", values_to = "amount")
# df$amount <- parse_number(df$amount)
# df[is.na(df$amount), "amount"] <- 0.
# 
# ggplot(df, aes(x = amount, y = month, fill = stat(x))) +
#   geom_density_ridges_gradient(scale = 1, rel_min_height = 0.01, panel_scaling=FALSE) +
#   #geom_density_ridges(alpha=0.3, stat="binline", bins=20,panel_scaling=FALSE) +
#   scale_fill_viridis_c(name = "Temp. [F]", option = "C") +
#   labs(title = 'Uzbek Grad S. Contributions')



