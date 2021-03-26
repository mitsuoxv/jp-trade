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
  mainui <- fluidPage(
    titlePanel("Japan international trade"),
    
    fluidRow(
      column(4,
             selectInput("select_area",
                         label = h4("Select area"),
                         choices = levels_area,
                         selected = "Grand Total"),
      ),
      column(4,
             selectInput("select_goods",
                         label = h4("Select goods"),
                         choices = levels_goods,
                         selected = "Grand Total")
      ),
      column(4,
             sliderInput("year_range",
                         label = h4("Select year range"),
                         min = 2009, max = 2021, value = c(2011, 2021),
                         sep = "")
      ),
    ),
    fluidRow(
      column(6, plotOutput("plot_value")),
      column(6, plotOutput("plot_gr"))
    ),
    hr(),
    fluidRow(
      column(4,
             sliderInput("year",
                         label = h4("Select year"),
                         min = 2009, max = 2020, value = 2020,
                         sep = "")
      )
    ),
    fluidRow(
      column(6,
             h4(textOutput("ex_goods")),
             DT::dataTableOutput("export_area")
      ),
      column(6,
             h4(textOutput("im_goods")),
             DT::dataTableOutput("import_area")
      )
    ),
    hr(),
    fluidRow(
      column(6,
             h4(textOutput("ex_area")),
             DT::dataTableOutput("export_goods")
      ),
      column(6,
             h4(textOutput("im_area")),
             DT::dataTableOutput("import_goods")
      )
    ),
    hr(),
    
    # Show source and Shiny app creator
    a(href = "http://www.customs.go.jp/toukei/info/index_e.htm",
      "Source: Trade Statistics of Japan, Ministry of Finance"),
    br(),
    a(href = "https://mitsuoxv.rbind.io/",
      "Shiny app creator: Mitsuo Shiota")
  )
  
  mainserver <- function(input, output, session) {
    output$ex_area <- renderText(
      paste0("Export to ", input$select_area, ", billion yen per year")
      )
    
    output$im_area <- renderText(
      paste0("Import from ", input$select_area, ", billion yen per year")
    )
    
    output$ex_goods <- renderText(
      paste0("Export of ", input$select_goods, ", billion yen per year")
    )
    
    output$im_goods <- renderText(
      paste0("Import of ", input$select_goods, ", billion yen per year")
    )
    
    chart_data1 <- reactive({
      trade %>%
        dplyr::filter(area == input$select_area,
                      goods == input$select_goods)
      }) %>% 
      bindCache(input$select_area, input$select_goods)
    
    output$plot_value <- renderPlot({
      chart_data1() %>%
        dplyr::filter(
          month >= lubridate::make_date(input$year_range[1], 1, 1),
          month <= lubridate::make_date(input$year_range[2], 12, 1)
        ) %>%
        draw_value()
    }, res = 96)
    
    output$plot_gr <- renderPlot({
      chart_data1() %>%
        dplyr::filter(
          month >= lubridate::make_date(input$year_range[1], 1, 1),
          month <= lubridate::make_date(input$year_range[2], 12, 1)
        ) %>%
        draw_gr()
    }, res = 96)
    
    table_data1 <- reactive({
      trade_year %>%
        dplyr::filter(
          goods == input$select_goods,
          year == input$year
        ) 
      }) %>% 
      bindCache(input$select_goods, input$year)
    
    output$export_area <- DT::renderDataTable({
      table_data1() %>%
        show_table("export", area)
    })
    
    output$import_area <- DT::renderDataTable({
      table_data1() %>%
        show_table("import", area)
    })
    
    table_data2 <- reactive({
      trade_year %>%
        dplyr::filter(
          area == input$select_area,
          year == input$year
        ) 
    })
    
    output$export_goods <- DT::renderDataTable({
      table_data2() %>%
        show_table("export", goods)
    })
    
    output$import_goods <- DT::renderDataTable({
      table_data2() %>%
        show_table("import", goods)
    })
  }
  
  shinyApp(ui = mainui, server = mainserver)
}
