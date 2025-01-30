yearTableUI <- function(id) {
  tagList(
    fluidRow(
      column(4,
             sliderInput(NS(id, "year"),
                         label = h4("Select year"),
                         min = 2009, max = 2024, value = 2024,
                         sep = "")
      )
    ),
    fluidRow(
      column(6,
             h4(textOutput(NS(id, "ex_area"))),
             DT::dataTableOutput(NS(id, "export_goods"))
      ),
      column(6,
             h4(textOutput(NS(id, "im_area"))),
             DT::dataTableOutput(NS(id, "import_goods"))
      )
    ),
    hr(),
    fluidRow(
      column(6,
             h4(textOutput(NS(id, "ex_goods"))),
             DT::dataTableOutput(NS(id, "export_area"))
      ),
      column(6,
             h4(textOutput(NS(id, "im_goods"))),
             DT::dataTableOutput(NS(id, "import_area"))
      )
    )
  )
}

yearTableServer <- function(id, select_area, select_goods) {
  stopifnot(is.reactive(select_area))
  stopifnot(is.reactive(select_goods))
  
  moduleServer(id, function(input, output, session) {
    output$ex_area <- renderText(
      paste0("Export to ", select_area(), ", billion yen per year")
    )
    
    output$im_area <- renderText(
      paste0("Import from ", select_area(), ", billion yen per year")
    )
    
    output$ex_goods <- renderText(
      paste0("Export of ", select_goods(), ", billion yen per year")
    )
    
    output$im_goods <- renderText(
      paste0("Import of ", select_goods(), ", billion yen per year")
    )
    
    
    table_data1 <- reactive({
      trade_year %>%
        dplyr::filter(
          goods == select_goods(),
          year == input$year
        ) 
    }) %>% 
      bindCache(select_goods(), input$year)
    
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
          area == select_area(),
          year == input$year
        ) 
    }) %>% 
      bindCache(select_area(), input$year)
    
    output$export_goods <- DT::renderDataTable({
      table_data2() %>%
        show_table("export", goods)
    })
    
    output$import_goods <- DT::renderDataTable({
      table_data2() %>%
        show_table("import", goods)
    })
  })
}