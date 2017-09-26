#' Get the aggregated timetrack on a specific day
#'
#' @param day A POSIX object of the day one wishes to get time tracking from
#' @param token Token obtained with \code{\link{signIn}}
#' @param tz The desired timezone
#'
#' @return A data frame with activity name (\code{name}), time difference in minutes (\code{timeDiff}),
#' time difference represented as H:M (\code{hm}) and the time difference represented as decimal hours (\code{decHour}).
#' @export
#'
#' @examples token <- "123456789"
#' day <- as.POSIXct("2017-09-21", tz = "CET")
#' timetrackDay(day, token, tz = "CET")
timetrackDay <- function(day = as.POSIXct("2017-09-21", tz = "CET"), token, tz = "CET") {

    # Create Timeular timestamps
    stoppedAfter <- posix_to_timeular(day)
    startedBefore <- posix_to_timeular(day + (23*60*60 + 59*60 + 59.999))

    # Get time entries between stoppedAfter and startedBefore
    result <- timeEntries(stoppedAfter, startedBefore, token, as_df = TRUE)

    # Converting Timeular timestamps to POSIX objects and calculating time
    # difference in minutes
    result <- dplyr::mutate(
        result,
        startedAt = timeular_to_posix(startedAt, tz = tz),
        stoppedAt = timeular_to_posix(stoppedAt, tz = tz),
        timeDiff = as.numeric(difftime(stoppedAt, startedAt, units = "mins"))
    )

    # Grouping on activity name summarise time difference
    result <- dplyr::group_by(result, name)
    result <- dplyr::summarise(result, timeDiff = sum(timeDiff))

    # Convert time difference into H:M and decimal hours
    result <- dplyr::mutate(
        result,
        hm = convert_mins_to_hm(timeDiff),
        decHour = round(timeDiff / 60, 2)
    )

    result <- as.data.frame(result)

    # Remove time difference in minutes
    result$timeDiff <- NULL

    return(result)
}
