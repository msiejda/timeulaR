#' Find Time Entries in given range
#'
#' Find Time Entries which have at least one millisecond in common with provided time range.
#'
#' @param stoppedAfter Timestamp which matches all Time Entries stopped after it. Eg. 2017-01-01T00:00:00.000.
#' @param startedBefore Timestamp which matches all Time Entries started before it. Eg. 2017-12-31T23:59:59.999.
#' @param token Token obtained with \code{\link{signIn}}
#' @param as_df If TRUE a data frame is returned, if FALSE a list is returned.
#' @param tz Desired timezone
#'
#' @return A data frame or list containing id, activity id, name, color, integration, started at, stopped at and a note.
#' @export
#'
#' @examples stoppedAfter <- "2017-09-17T00:00:00.000"
#' startedBefore <- "2017-09-19T00:00:00.000"
#' token <- "123456789"
#' timeEntries(stoppedAfter, startedBefore, token, as_df = TRUE, tz = "CET")
timeEntries <- function(stoppedAfter, startedBefore, token, as_df = TRUE, tz = "CET") {

    base_url <- "api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    resp <- httr::GET(
        url = paste0(base_url, "time-entries", "/", stoppedAfter, "/", startedBefore),
        httr::add_headers(Authorization = bearer_token)
    )

    if ( httr::status_code(resp) == 200 ) {

        parsed <- httr::content(resp, type = "application/json")

    } else {

        stop("Something went wrong!")

    }

    if ( as_df ) {

        parsed <- lapply(parsed$timeEntries, function(entry) {

            data.frame(
                id = ifelse(is.null(entry$id), NA, entry$id),
                activityId = ifelse(is.null(entry$activity$id), NA, entry$activity$id),
                name = ifelse(is.null(entry$activity$name), NA, entry$activity$name),
                color = ifelse(is.null(entry$activity$color), NA, entry$activity$color),
                integration = ifelse(is.null(entry$activity$integration), NA, entry$activity$integration),
                startedAt = switch(
                    EXPR = is.null(entry$duration$startedAt) + 1,
                    timeulaR:::convert_to_posix(entry$duration$startedAt, tz = tz),
                    NA
                ),
                stoppedAt = switch(
                    EXPR = is.null(entry$duration$stoppedAt) + 1,
                    timeulaR:::convert_to_posix(entry$duration$stoppedAt, tz = tz),
                    NA
                ),
                note = ifelse(is.null(entry$note), NA, entry$note),
                stringsAsFactors = FALSE
            )

        })

        parsed <- do.call(rbind, parsed)
        parsed <- parsed[order(parsed$startedAt),]

    }

    return(parsed)
}
