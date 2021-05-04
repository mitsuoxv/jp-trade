#' Shiny app for Japan trade data
#'
#' @return A Shiny app.
#' @import shiny
#' @export
#'
#' @examples
#' \dontrun{
#' mainApp()
#' }
mainApp <- function() {
  mainUI <- fluidPage(
    titlePanel("Japan international trade"),
    tags$head(includeHTML(("google-analytics.html"))),
    
    fluidRow(
      column(4,
             selectInput("select_area",
                         label = h4("Select area"),
                         choices = levels_area,
                         selected = "Grand Total")
             ),
      column(4,
             selectInput("select_goods",
                         label = h4("Select goods"),
                         choices = levels_goods,
                         selected = "Grand Total")
             )
    ),

    tabsetPanel(
      tabPanel("Monthly data chart",
        monthPlotUI("plot")
      ),
      tabPanel("Annual data table",
        yearTableUI("table")
      ),
      selected = "Monthly data chart"
    ),
    hr(),
    fluidRow(
      column(12,
             # Show source and Shiny app creator
             a(href = "http://www.customs.go.jp/toukei/info/index_e.htm",
               "Source: Trade Statistics of Japan, Ministry of Finance"),
             br(),
             a(href = "https://mitsuoxv.rbind.io/",
               "Shiny app creator: Mitsuo Shiota")
             )
    )
  )

  
  mainServer <- function(input, output, session) {
    area <- reactive(input$select_area)
    goods <- reactive(input$select_goods)
    
    monthPlotServer("plot", area, goods)
    yearTableServer("table", area, goods)
  }
  
  shinyApp(ui = mainUI, server = mainServer)
}
