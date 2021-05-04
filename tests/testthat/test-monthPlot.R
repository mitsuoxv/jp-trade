test_that("chart_data is OK", {
  x = reactiveVal()
  y = reactiveVal()
  
  testServer(monthPlotServer, args = list(select_area = x, select_goods = y), {
    x("USA")
    y("Chemicals")
    session$flushReact()
    session$setInputs(year_range = c(2010, 2010))
    
    expect_equal(as.character(chart_data()$ex_im[3]), "export")
    expect_equal(chart_data()$month[3], as.Date("2010-02-01"))
    expect_equal(chart_data()$value[3], 53.2, tolerance = 0.001)
    expect_equal(chart_data()$gr[3], 0.274, tolerance = 0.001)
    
    
    x("China")
    y("Manufactured Goods")
    session$flushReact()
    
    expect_equal(as.character(chart_data()$ex_im[2]), "import")
    expect_equal(chart_data()$month[2], as.Date("2010-01-01"))
    expect_equal(chart_data()$value[2], 122.8, tolerance = 0.001)
    expect_equal(chart_data()$gr[2], -0.0787, tolerance = 0.001)
    
    
    session$setInputs(year_range = c(2015, 2018))
    
    expect_equal(as.character(chart_data()$ex_im[3]), "export")
    expect_equal(chart_data()$month[3], as.Date("2015-02-01"))
    expect_equal(chart_data()$value[3], 124, tolerance = 0.001)
    expect_equal(chart_data()$gr[3], -0.1404, tolerance = 0.001)
  })
})
