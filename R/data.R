#' Japan trade data by month
#'
#' Monthly data from 2009.
#'
#' @source http://www.customs.go.jp/toukei/info/index_e.htm
#' @format Dataframe
#' \describe{
#' \item{`Exp or Imp`}{"export" or "import"}
#' \item{Area}{Area category}
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
#' \item{`Exp or Imp`}{factor of "export" or "import"}
#' \item{Area}{Area category}
#' \item{goods}{goods category}
#' \item{year}{double}
#' \item{value}{billion yen per year}
#' }
"trade_year"
