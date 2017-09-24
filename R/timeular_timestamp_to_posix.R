#' Convert Timeular timestamp to POSIX object
#'
#' @param timeular_time Timestamp from Timeular
#' @param tz Desired timezone
#'
#' @return A POSIX object with desired timezone
#' @export
#'
#' @examples timeular_time_to_posix(timeular_time = "2017-09-18T14:32:26.960", tz = "CET")
timeular_timestamp_to_posix <- function(timeular_time, tz = "CET") {

    # Remove "T"
    timeular_time <- stringr::str_replace(timeular_time, "T", " ")

    # Convert to POSIX object
    posix <- as.POSIXct(timeular_time, format = "%Y-%m-%d %H:%M:%S.%OS", tz = "UTC")

    # Convert to desired timezone
    posix <-lubridate::with_tz(posix, tz = tz)

    return(posix)
}
