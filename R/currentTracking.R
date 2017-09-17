#' Show current tracking
#'
#' @param token Token obtained with \code{\link{signIn}}
#' @param as_df If TRUE a data frame is returned, if FALSE a list is returned.
#'
#' @return A data frame or list with id, name, color, integration, started at and note of current tracking.
#' @export
#'
#' @examples token <- "123456789"
#' currentTracking(token, as_df = TRUE)
currentTracking <- function(token, as_df = TRUE) {

    base_url <- "api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    resp <- httr::GET(
        url = paste0(base_url, "tracking"),
        httr::add_headers(Authorization = bearer_token)
    )

    if ( httr::status_code(resp) == 200 ) {

        parsed <- httr::content(resp, type = "application/json")

    } else {

        stop("Something went wrong!")

    }

    if ( as_df ) {

        parsed <- data.frame(
            id = ifelse(is.null(parsed$currentTracking$activity$id), NA, parsed$currentTracking$activity$id),
            name = ifelse(is.null(parsed$currentTracking$activity$name), NA, parsed$currentTracking$activity$name),
            color = ifelse(is.null(parsed$currentTracking$activity$color), NA, parsed$currentTracking$activity$color),
            integration = ifelse(is.null(parsed$currentTracking$activity$integration), NA, parsed$currentTracking$activity$integration),
            startedAt = ifelse(is.null(parsed$currentTracking$startedAt), NA, parsed$currentTracking$startedAt),
            note = ifelse(is.null(parsed$currentTracking$note), NA, parsed$currentTracking$note),
            stringsAsFactors = FALSE
        )

    }

    return(parsed)
}
