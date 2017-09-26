#' Get the aggregated timetrack in a specific week
#'
#' @param weekNumber The week number you wish timetracking from
#' @param token Token obtained with \code{\link{signIn}}
#' @param year If \code{NULL} the current year is choosen
#' @param tz The desired timezone
#'
#' @return A data frame containing the date \code{date}, week day \code{weekDay},
#' project name \code{name}, time difference represented as H:M (\code{hm}) and
#' the time difference represented as decimal hours (\code{decHour}).
#' @export
#'
#' @examples token <- "123456789"
#' timetrackWeek(weekNumber = 38, token, year = NULL, tz = "CET")
timetrackWeek <- function(weekNumber = 38, token, year = NULL, tz = "CET") {

    # Year
    if (is.null(year)) year <- lubridate::year(Sys.Date())

    # Origin date of year
    origin <- as.POSIXct(paste0(year, "-01-01"), tz = tz)

    # Dates within weekNumber
    dates <- origin + lubridate::weeks(weekNumber - 1) + lubridate::days(1:7)

    # Loop over every date in dates
    result <- pbapply::pblapply(dates, function(day) {

        data.frame(
            date = day,
            weekDay = lubridate::wday(day, label = TRUE, abb = FALSE),
            timeulaR::timetrackDay(day, token, tz = tz),
            stringsAsFactors = FALSE
        )

    })

    # Bind it together
    result <- do.call(dplyr::bind_rows, result)

    # Sort it by date and name
    result <- dplyr::arrange(result, date, name)

    return(result)
}
