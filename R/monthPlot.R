monthPlotUI <- function(id) {
  tagList(
    fluidRow(
      column(4,
             sliderInput(NS(id, "year_range"),
                         label = h4("Select year range"),
                         min = 2009, max = 2021, value = c(2011, 2021),
                         sep = "")
      ),
    ),
    
    fluidRow(
      column(6, plotOutput(NS(id, "plot_value"))),
      column(6, plotOutput(NS(id, "plot_gr")))
    )
  )
}

monthPlotServer <- function(id, select_area, select_goods) {
  stopifnot(is.reactive(select_area))
  stopifnot(is.reactive(select_goods))
  
  moduleServer(id, function(input, output, session) {
    chart_data <- reactive({
      trade %>%
        dplyr::filter(
          area == select_area(),
          goods == select_goods(),
          month >= lubridate::make_date(input$year_range[1], 1, 1),
          month <= lubridate::make_date(input$year_range[2], 12, 1)
        )
    }) %>% 
      bindCache(select_area(), select_goods(), input$year_range)
    
    output$plot_value <- renderPlot({
      chart_data() %>%
        draw_value()
    }, res = 96)
    
    output$plot_gr <- renderPlot({
      chart_data() %>%
        draw_gr()
    }, res = 96)
    
  })
}

