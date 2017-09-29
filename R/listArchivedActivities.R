#' List all archived activities
#'
#' @param token Token obtained with \code{\link{signIn}}.
#' @param as_df If \code{TRUE} a data frame is returned, if \code{FALSE} a list is returned.
#'
#' @return A data frame or list with id, name, color, integration and deviceSide (\code{NULL}).
#' @export
#'
#' @examples token <- "123456789"
#' listArchivedActivities(token, as_df = TRUE)
listArchivedActivities <- function(token, as_df = TRUE) {

    if (is.null(activityId)) stop("You haven't provided an activityId")

    base_url <- "api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    resp <- httr::GET(
        url = paste0(base_url, "archived-activities"),
        httr::add_headers(Authorization = bearer_token)
    )

    # Status and stop execution if status different from 200
    status <- httr::status_code(resp)
    if (status != 200) stop("Something went wrong! Error code ", status)

    # Parse response
    parsed <- httr::content(resp, type = "application/json")

    # If as_df is TRUE
    if (as_df) {

        result <- lapply(parsed$archivedActivities, function(entry) {

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

    }

    return(result)
}
