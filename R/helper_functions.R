#' Convert minutes to H:M format
#'
#' @param timeDiff Numeric
#'
#' @return A string containing the converted numeric into the format %H:%M
#'
#' @examples convert_mins_to_hm(timeDiff = 69.9833)
convert_mins_to_hm <- function(timeDiff) {

    hm <- paste0(
        stringr::str_pad(floor(timeDiff / 60), 2, "left", 0), ":",
        stringr::str_pad(ceiling(timeDiff %% 60), 2, "left", 0)
    )

    return(hm)
}
