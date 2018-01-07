#' Find Time Entries in given range
#'
#' Find Time Entries which have at least one millisecond in common with provided time range.
#'
#' @param stoppedAfter Timestamp which matches all time entries stopped after it. Eg. 2017-01-01T00:00:00.000.
#' @param startedBefore Timestamp which matches all time entries started before it. Eg. 2017-12-31T23:59:59.999.
#' @param token Token obtained with \code{\link{signIn}}
#' @param as_df If \code{TRUE} a data frame is returned, if \code{FALSE} a list is returned.
#'
#' @return A data frame or list containing id (\code{id}), activity id (\code{activityId}),
#' project name (\code{name}), color (\code{color}), integration (\code{integration}),
#' started at (\code{startedAt}), stopped at (\code{stoppedAt}) and a note (\code{note}).
#' @export
#'
#' @examples stoppedAfter <- "2017-09-17T00:00:00.000"
#' startedBefore <- "2017-09-19T00:00:00.000"
#' token <- "123456789"
#' timeEntries(stoppedAfter, startedBefore, token, as_df = TRUE)
timeEntries <- function(stoppedAfter, startedBefore, token, as_df = TRUE) {

    base_url <- "https://api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    resp <- httr::GET(
        url = paste0(base_url, "time-entries", "/", stoppedAfter, "/", startedBefore),
        httr::add_headers(Authorization = bearer_token)
    )

    # Status and stop execution if status different from 200
    status <- httr::status_code(resp)
    if (status != 200) stop("Something went wrong! Error code ", status)

    # Parse response
    parsed <- httr::content(resp, type = "application/json")

    if (length(parsed$timeEntries) != 0) {

        # If as_df is TRUE
        if ( as_df ) {

            result <- lapply(parsed$timeEntries, function(entry) {

                data.frame(
                    id = ifelse(is.null(entry$id), NA, entry$id),
                    activityId = ifelse(is.null(entry$activity$id), NA, entry$activity$id),
                    name = ifelse(is.null(entry$activity$name), NA, entry$activity$name),
                    color = ifelse(is.null(entry$activity$color), NA, entry$activity$color),
                    integration = ifelse(is.null(entry$activity$integration), NA, entry$activity$integration),
                    startedAt = ifelse(is.null(entry$duration$startedAt), NA, entry$duration$startedAt),
                    stoppedAt = ifelse(is.null(entry$duration$stoppedAt), NA, entry$duration$stoppedAt),
                    note = ifelse(is.null(entry$note), NA, entry$note),
                    stringsAsFactors = FALSE
                )

            })

            result <- do.call(rbind, result)
            result <- result[order(result$startedAt),]
            rownames(result) <- 1:nrow(result)

        }

    } else {

        result <- NULL

    }

    return(result)
}
