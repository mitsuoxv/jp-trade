#' Show table
#' 
#' Show table in DT format
#'
#' @param df A dataframe.
#' @param em either "export" or "import"
#' @param ar_go either area or goods
#'
#' @return A DT table
#'
#' @examples
#' \dontrun{
#' show_table(df, em = "export", ar_go = area)
#' }
show_table <- function(df, em, ar_go) {
  df %>%
    dplyr::filter(
      ex_im == em,
      {{ ar_go }} != "Grand Total"
    ) %>%
    dplyr::select({{ ar_go }}, value) %>%
    dplyr::arrange(dplyr::desc(value)) %>%
    DT::datatable() %>% 
    DT::formatRound('value', digits = 0, interval = 3, mark = ",")
}