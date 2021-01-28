#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# libraries
library(shiny)
library(tidyverse)

# load data
load("data/jptrade.rdata")

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Japan international trade"),
  
  fluidRow(
    column(4,
           selectInput("select_area", label = h4("Select area"), 
                  choices = levels_area)
           ),
    column(4,
           selectInput("select_goods", label = h4("Select goods"), 
                  choices = levels_goods)
    )
  ),
  sliderInput("year_range",
              label = h4("Select year range"), 
              min = 2009,
              max = 2020,
              value = c(2011, 2020),
              sep = ""),
  fluidRow(
    column(6, plotOutput("plot_value")),
    column(6, plotOutput("plot_gr"))
  ),
  hr(),
  sliderInput("year",
              label = h4("Select year"), 
              min = 2009,
              max = 2020,
              value = 2020,
              sep = ""),
  fluidRow(
    column(6, h4("Export to area, billion yen per year"), 
           DT::dataTableOutput("export_area")),
    column(6, h4("Import from area, billion yen per year"), 
           DT::dataTableOutput("import_area"))
  ),
  hr(),
  fluidRow(
    column(6, h4("Export of goods, billion yen per year"), 
           DT::dataTableOutput("export_goods")),
    column(6, h4("Import of goods, billion yen per year"), 
           DT::dataTableOutput("import_goods"))
  ),
  hr(),
  
  # Show source and Shiny app creator
  a(href = "http://www.customs.go.jp/toukei/info/index_e.htm", 
    "Source: Trade Statistics of Japan, Ministry of Finance"),
  br(),
  a(href = "https://mitsuoxv.rbind.io/", 
    "Shiny app creator: Mitsuo Shiota")
)


# Functions
draw_value <- function(df) {
  df %>% 
    ggplot(aes(x = month, y = value, color = `Exp or Imp`)) +
    geom_line(size = 1) +
    scale_color_discrete(name = "") +
    labs(
      title = str_c(df$goods[1], " with ", df$Area[1]),
      x = "", y = "billion yen per month"
    ) +
    theme(legend.position = "bottom")
}

draw_gr <- function(df) {
  df %>% 
    ggplot(aes(x = month, y = gr, color = `Exp or Imp`)) +
    geom_hline(yintercept = 0, color = "white", size = 2) +
    geom_line(size = 1) +
    scale_color_discrete(name = "") +
    labs(
      title = str_c("Growth rates of ", df$goods[1], " with ", df$Area[1]),
      x = "", y = "YoY percent"
    ) +
    theme(legend.position = "bottom")
}

# Define server logic required to draw a chart
server <- function(input, output) {
  chart_data1 <- reactive({
    trade %>% 
      filter(Area == input$select_area,
             goods == input$select_goods)
  })
  
  output$plot_value <- renderPlot({
    chart_data1() %>% 
      filter(month >= paste0(input$year_range[1], "-01-01"),
             month <= paste0(input$year_range[2], "-12-01")) %>% 
      draw_value()
  })

  output$plot_gr <- renderPlot({
    chart_data1() %>% 
      filter(month >= paste0(input$year_range[1], "-01-01"),
             month <= paste0(input$year_range[2], "-12-01")) %>% 
      draw_gr()
  })
  
  output$export_area <- DT::renderDataTable({
    trade_year %>% 
      filter(`Exp or Imp` == "export", 
        Area != "Grand Total",
        goods == input$select_goods,
        year == input$year) %>% 
      select(Area, value) %>% 
      mutate(value = round(value, 0)) %>% 
      arrange(desc(value)) %>% 
      DT::datatable()
  })

  output$import_area <- DT::renderDataTable({
    trade_year %>% 
      filter(`Exp or Imp` == "import", 
             Area != "Grand Total",
             goods == input$select_goods,
             year == input$year) %>% 
      select(Area, value) %>% 
      mutate(value = round(value, 0)) %>% 
      arrange(desc(value)) %>% 
      DT::datatable()
  })
  
  output$export_goods <- DT::renderDataTable({
    trade_year %>% 
      filter(`Exp or Imp` == "export", 
             goods != "Grand Total",
             Area == input$select_area,
             year == input$year) %>% 
      select(goods, value) %>% 
      mutate(value = round(value, 0)) %>% 
      arrange(desc(value)) %>% 
      DT::datatable()
  })
  
  output$import_goods <- DT::renderDataTable({
    trade_year %>% 
      filter(`Exp or Imp` == "import", 
             goods != "Grand Total",
             Area == input$select_area,
             year == input$year) %>% 
      select(goods, value) %>% 
      mutate(value = round(value, 0)) %>% 
      arrange(desc(value)) %>% 
      DT::datatable()
  })
}


# Run the application 
shinyApp(ui = ui, server = server)
