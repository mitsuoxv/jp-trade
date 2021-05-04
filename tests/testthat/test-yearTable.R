test_that("table_data1 is OK", {
  x = reactiveVal()
  y = reactiveVal()

  testServer(yearTableServer, args = list(select_area = x, select_goods = y), {
    y("Foodstuff")
    session$flushReact()
    session$setInputs(year = 2016)
    
    expect_equal(as.character(table_data1()$ex_im[2]), "export")
    expect_equal(table_data1()$area[2], "Austral")
    expect_equal(table_data1()$value[2], 11.71, tolerance = 0.001)
    
    y("Mineral Fuels")
    session$flushReact()
    
    expect_equal(as.character(table_data1()$ex_im[93]), "import")
    expect_equal(table_data1()$area[93], "Su Arab")
    expect_equal(table_data1()$value[93], 2047.6, tolerance = 0.001)
    
    session$setInputs(year = 2018)
    
    expect_equal(as.character(table_data1()$ex_im[102]), "import")
    expect_equal(table_data1()$area[102], "USA")
    expect_equal(table_data1()$value[102], 1069.0, tolerance = 0.001)
  })
})

test_that("table_data2 is OK", {
  x = reactiveVal()
  y = reactiveVal()
  
  testServer(yearTableServer, args = list(select_area = x, select_goods = y), {
    x("Austral")
    session$flushReact()
    session$setInputs(year = 2016)
    
    expect_equal(as.character(table_data2()$ex_im[2]), "export")
    expect_equal(table_data2()$goods[2], "(Car)")
    expect_equal(table_data2()$value[2], 560, tolerance = 0.001)
    
    x("USA")
    session$flushReact()
    
    expect_equal(as.character(table_data2()$ex_im[2]), "export")
    expect_equal(table_data2()$goods[2], "(Car)")
    expect_equal(table_data2()$value[2], 4310, tolerance = 0.001)
    
    session$setInputs(year = 2018)
    
    expect_equal(as.character(table_data2()$ex_im[2]), "export")
    expect_equal(table_data2()$goods[2], "(Car)")
    expect_equal(table_data2()$value[2], 4420, tolerance = 0.001)
  })
})
