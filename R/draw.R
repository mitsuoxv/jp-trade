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
    ggplot2::ggplot(ggplot2::aes(x = month, y = value, color = `Exp or Imp`)) +
    ggplot2::geom_line(size = 1) +
    ggplot2::scale_color_discrete(name = "") +
    ggplot2::labs(
      title = stringr::str_c(df$goods[1], " with ", df$Area[1]),
      x = "",
      y = "billion yen per month"
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
    ggplot2::ggplot(ggplot2::aes(x = month, y = gr, color = `Exp or Imp`)) +
    ggplot2::geom_hline(yintercept = 0,
               color = "white",
               size = 2) +
    ggplot2::geom_line(size = 1) +
    ggplot2::scale_color_discrete(name = "") +
    ggplot2::labs(
      title = stringr::str_c("Growth rates of ", df$goods[1], " with ", df$Area[1]),
      x = "",
      y = "YoY percent"
    ) +
    ggplot2::theme(legend.position = "bottom")
}
