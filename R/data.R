#' Japan trade data by month
#'
#' Monthly data from 2009.
#'
#' @source http://www.customs.go.jp/toukei/info/index_e.htm
#' @format Dataframe
#' \describe{
#' \item{ex_im}{factor of "export" or "import"}
#' \item{area}{Area category}
#' \item{month}{date}
#' \item{goods}{goods category}
#' \item{value}{billion yen per month}
#' \item{gr}{YoY growth rates}
#' }
"trade"


#' Japan trade data by year
#'
#' Annual data from 2009.
#'
#' @source http://www.customs.go.jp/toukei/info/index_e.htm
#' @format Dataframe
#' \describe{
#' \item{ex_im}{factor of "export" or "import"}
#' \item{area}{Area category}
#' \item{goods}{goods category}
#' \item{year}{double}
#' \item{value}{billion yen per year}
#' }
"trade_year"

#' Areas
#'
#' Areas by alphabetical order.
#'
#' @source http://www.customs.go.jp/toukei/info/index_e.htm
#' @format A character vector
#' \describe{
#' \item{distinct areas}{"China", "EU", R Korea", "USA"}
#' }
"levels_area"

#' Goods
#'
#' Goods by first appearance order.
#'
#' @source http://www.customs.go.jp/toukei/info/index_e.htm
#' @format A character vector
#' \describe{
#' \item{distinct goods}{"Transport Equipment", "Machinery"}
#' }
"levels_goods"
