#' Areas
#'
#' Areas.
#'
#' @source http://www.customs.go.jp/toukei/info/index_e.htm
#' @format A character vector.
#' \describe{
#' \item{areas}{China}
#' }
"levels_area"

#' Goods
#'
#' Goods.
#'
#' @source http://www.customs.go.jp/toukei/info/index_e.htm
#' @format A character vector.
#' \describe{
#' \item{goods}{IC}
#' }
"levels_goods"

#' Trade data by year
#'
#' Trade data by year.
#'
#' @source http://www.customs.go.jp/toukei/info/index_e.htm
#' @format A dataframe.
#' \describe{
#' \item{`Exp or Imp`}{"export" or "import"}
#' \item{Area}{areas}
#' \item{goods}{goods}
#' \item{year}{year}
#' \item{value}{value}
#' }
"trade_year"

#' Trade data by month
#'
#' Trade data by month.
#'
#' @source http://www.customs.go.jp/toukei/info/index_e.htm
#' @format A dataframe.
#' \describe{
#' \item{`Exp or Imp`}{"export" or "import"}
#' \item{Area}{areas}
#' \item{goods}{goods}
#' \item{month}{dates}
#' \item{value}{value}
#' }
"trade"