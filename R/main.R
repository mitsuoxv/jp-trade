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
                         choices = levels_area)
      ),
      column(4,
             selectInput("select_goods",
                         label = h4("Select goods"),
                         choices = levels_goods)
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
             h4("Export to area, billion yen per year"),
             DT::dataTableOutput("export_area")
      ),
      column(6,
             h4("Import from area, billion yen per year"),
             DT::dataTableOutput("import_area")
      )
    ),
    hr(),
    fluidRow(
      column(6,
             h4("Export of goods, billion yen per year"),
             DT::dataTableOutput("export_goods")
      ),
      column(6,
             h4("Import of goods, billion yen per year"),
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
    chart_data1 <- reactive({
      trade %>%
        dplyr::filter(Area == input$select_area,
                      goods == input$select_goods)
    })
    
    output$plot_value <- renderPlot({
      chart_data1() %>%
        dplyr::filter(
          month >= paste0(input$year_range[1], "-01-01"),
          month <= paste0(input$year_range[2], "-12-01")
        ) %>%
        draw_value()
    })
    
    output$plot_gr <- renderPlot({
      chart_data1() %>%
        dplyr::filter(
          month >= paste0(input$year_range[1], "-01-01"),
          month <= paste0(input$year_range[2], "-12-01")
        ) %>%
        draw_gr()
    })
    
    output$export_area <- DT::renderDataTable({
      trade_year %>%
        dplyr::filter(
          `Exp or Imp` == "export",
          Area != "Grand Total",
          goods == input$select_goods,
          year == input$year
        ) %>%
        dplyr::select(Area, value) %>%
        dplyr::mutate(value = round(value, 0)) %>%
        dplyr::arrange(desc(value)) %>%
        DT::datatable()
    })
    
    output$import_area <- DT::renderDataTable({
      trade_year %>%
        dplyr::filter(
          `Exp or Imp` == "import",
          Area != "Grand Total",
          goods == input$select_goods,
          year == input$year
        ) %>%
        dplyr::select(Area, value) %>%
        dplyr::mutate(value = round(value, 0)) %>%
        dplyr::arrange(desc(value)) %>%
        DT::datatable()
    })
    
    output$export_goods <- DT::renderDataTable({
      trade_year %>%
        dplyr::filter(
          `Exp or Imp` == "export",
          goods != "Grand Total",
          Area == input$select_area,
          year == input$year
        ) %>%
        dplyr::select(goods, value) %>%
        dplyr::mutate(value = round(value, 0)) %>%
        dplyr::arrange(desc(value)) %>%
        DT::datatable()
    })
    
    output$import_goods <- DT::renderDataTable({
      trade_year %>%
        dplyr::filter(
          `Exp or Imp` == "import",
          goods != "Grand Total",
          Area == input$select_area,
          year == input$year
        ) %>%
        dplyr::select(goods, value) %>%
        dplyr::mutate(value = round(value, 0)) %>%
        dplyr::arrange(desc(value)) %>%
        DT::datatable()
    })
  }
  
  shinyApp(ui = mainui, server = mainserver)
}


mainui <- fluidPage(
  titlePanel("Japan international trade"),
  
  fluidRow(
    column(4,
           selectInput("select_area",
                       label = h4("Select area"),
                       choices = levels_area)
    ),
    column(4,
           selectInput("select_goods",
                       label = h4("Select goods"),
                       choices = levels_goods)
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
           h4("Export to area, billion yen per year"),
           DT::dataTableOutput("export_area")
    ),
    column(6,
           h4("Import from area, billion yen per year"),
           DT::dataTableOutput("import_area")
    )
  ),
  hr(),
  fluidRow(
    column(6,
           h4("Export of goods, billion yen per year"),
           DT::dataTableOutput("export_goods")
    ),
    column(6,
           h4("Import of goods, billion yen per year"),
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
  chart_data1 <- reactive({
    trade %>%
      dplyr::filter(Area == input$select_area,
                    goods == input$select_goods)
  })
  
  output$plot_value <- renderPlot({
    chart_data1() %>%
      dplyr::filter(
        month >= paste0(input$year_range[1], "-01-01"),
        month <= paste0(input$year_range[2], "-12-01")
      ) %>%
      draw_value()
  })
  
  output$plot_gr <- renderPlot({
    chart_data1() %>%
      dplyr::filter(
        month >= paste0(input$year_range[1], "-01-01"),
        month <= paste0(input$year_range[2], "-12-01")
      ) %>%
      draw_gr()
  })
  
  output$export_area <- DT::renderDataTable({
    trade_year %>%
      dplyr::filter(
        `Exp or Imp` == "export",
        Area != "Grand Total",
        goods == input$select_goods,
        year == input$year
      ) %>%
      dplyr::select(Area, value) %>%
      dplyr::mutate(value = round(value, 0)) %>%
      dplyr::arrange(desc(value)) %>%
      DT::datatable()
  })
  
  output$import_area <- DT::renderDataTable({
    trade_year %>%
      dplyr::filter(
        `Exp or Imp` == "import",
        Area != "Grand Total",
        goods == input$select_goods,
        year == input$year
      ) %>%
      dplyr::select(Area, value) %>%
      dplyr::mutate(value = round(value, 0)) %>%
      dplyr::arrange(desc(value)) %>%
      DT::datatable()
  })
  
  output$export_goods <- DT::renderDataTable({
    trade_year %>%
      dplyr::filter(
        `Exp or Imp` == "export",
        goods != "Grand Total",
        Area == input$select_area,
        year == input$year
      ) %>%
      dplyr::select(goods, value) %>%
      dplyr::mutate(value = round(value, 0)) %>%
      dplyr::arrange(desc(value)) %>%
      DT::datatable()
  })
  
  output$import_goods <- DT::renderDataTable({
    trade_year %>%
      dplyr::filter(
        `Exp or Imp` == "import",
        goods != "Grand Total",
        Area == input$select_area,
        year == input$year
      ) %>%
      dplyr::select(goods, value) %>%
      dplyr::mutate(value = round(value, 0)) %>%
      dplyr::arrange(desc(value)) %>%
      DT::datatable()
  })
}
