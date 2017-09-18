#' Convert Timeular timestamp to POSIX
#'
#' @param timeular_time Timestamp from Timeular
#' @param tz Desired timezone
#'
#' @return A POSIX object with desired timezone
#'
#' @examples convert_to_posix(timeular_time = "2017-09-18T14:32:26.960", tz = "CET")
convert_to_posix <- function(timeular_time, tz = "CET") {

    # Remove "T"
    timeular_time <- stringr::str_replace(timeular_time, "T", " ")

    # Convert to POSIX object
    timeular_time <- as.POSIXct(timeular_time, format = "%Y-%m-%d %H:%M:%S.%OS", tz = "UTC")

    # Convert to desired timezone
    timeular_time <-lubridate::with_tz(timeular_time, tz = tz)

    return(timeular_time)
}
