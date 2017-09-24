#' Convert POSIX object to Timeular timestamp
#'
#' @param posix POSIX object
#'
#' @return A timestamp with Timeular style
#' @export
#'
#' @examples posix_to_timeular_timestamp(posix = "2017-09-24 17:18:53 CEST")
posix_to_timeular_timestamp <- function(posix = "2017-09-24 17:18:53 CEST") {

    if ( !any(stringr::str_detect(class(posix), "POSIX")) ) stop("Not POSIX object!")

    # Convert to timezone UTC
    posix <- lubridate::with_tz(posix, tz = "UTC")

    # Concatenate timeular timestamp
    timeular_time <- paste0(
        lubridate::year(posix),
        "-",
        stringr::str_pad(lubridate::month(posix), width = 2, side = "left", pad = 0),
        "-",
        stringr::str_pad(lubridate::day(posix), width = 2, side = "left", pad = 0),
        "T",
        stringr::str_pad(lubridate::hour(posix), width = 2, side = "left", pad = 0),
        ":",
        stringr::str_pad(lubridate::minute(posix), width = 2, side = "left", pad = 0),
        ":",
        stringr::str_pad(round(lubridate::second(posix),0), width = 2, side = "left", pad = 0),
        ".",
        stringr::str_pad(round((lubridate::second(posix) %% 1) * 1000,0), width = 2, side = "left", pad = 0)
    )

    return(timeular_time)
}
