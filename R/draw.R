#' Plot volume
#'
#' @param df 
#'
#' @return A plot.
#'
#' @examples
#' \dontrun{
#' draw_value(df)
#' }
draw_value <- function(df) {
  df %>%
    ggplot2::ggplot(ggplot2::aes(month, value, color = `Exp or Imp`)) +
    ggplot2::geom_line(size = 1) +
    ggplot2::scale_y_continuous(labels = scales::comma) +
    ggplot2::expand_limits(y = 0) +
    ggplot2::labs(
      title = stringr::str_c(df$goods[1], " with ", df$Area[1]),
      x = NULL, y = "billion yen per month", color = NULL
    ) +
    ggplot2::theme(legend.position = "bottom")
}

#' Plot growth rates
#'
#' @param df 
#'
#' @return A plot.
#'
#' @examples
#' \dontrun{
#' draw_gr(df)
#' }
draw_gr <- function(df) {
  df %>%
    ggplot2::ggplot(ggplot2::aes(month, gr, color = `Exp or Imp`)) +
    ggplot2::geom_hline(yintercept = 0, color = "white", size = 2) +
    ggplot2::geom_line(size = 1) +
    ggplot2::scale_y_continuous(labels = scales::percent) +
    ggplot2::labs(
      title = stringr::str_c("Growth rates of ", df$goods[1], " with ", df$Area[1]),
      x = NULL, y = "YoY percent", color = NULL
    ) +
    ggplot2::theme(legend.position = "bottom")
}
