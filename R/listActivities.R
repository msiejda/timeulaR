#' List all activities
#'
#' @param token Token obtained with \code{\link{signIn}}
#' @param as_df If TRUE a data frame is returned, if FALSE a list is returned.
#'
#' @return A data frame or list with id, name, color, integration and device side
#' of the activities.
#' @export
#'
#' @examples token <- "123456789"
#' listActivities(token, as_df = TRUE)
listActivities <- function(token, as_df = TRUE) {

    base_url <- "https://api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    resp <- httr::GET(
        url = paste0(base_url, "activities"),
        httr::add_headers(Authorization = bearer_token)
    )

    if ( httr::status_code(resp) == 200 ) {

        parsed <- httr::content(resp, type = "application/json")

    } else {

        stop("Something went wrong!")

    }

    if ( as_df ) {

        result <- lapply(parsed$activities, function(entry) {

            data.frame(
                id = ifelse(is.null(entry$id), NA, entry$id),
                name = ifelse(is.null(entry$name), NA, entry$name),
                color = ifelse(is.null(entry$color), NA, entry$color),
                integration = ifelse(is.null(entry$integration), NA, entry$integration),
                deviceSide = ifelse(is.null(entry$deviceSide), NA, entry$deviceSide),
                stringsAsFactors = FALSE
            )

        })

        result <- do.call(rbind, result)
        result <- result[order(result$deviceSide), ]

    }

    return(result)
}
