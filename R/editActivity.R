#' Edit an Activity
#'
#' With this function you can edit the activity name or color.
#'
#' @param activityId ID of an Activity, eg. 123.
#' @param name The name you want the activity changed to.
#' @param color The color you want the activity changed to.
#' @param token Token obtained with \code{\link{signIn}}.
#' @param as_df If TRUE a data frame is returned, if FALSE a list is returned.
#'
#' @return A data frame or list with id, name, color, integration and deviceSide (\code{NULL}).
#' @export
#'
#' @examples token <- "123456789"
#' editActivity(activityId = NULL, name = "being fucking awesome", color = "#000000", token, as_df = TRUE)
editActivity <- function(activityId = NULL, name = "being fucking awesome", color = "#000000", token, as_df = TRUE) {

    if (is.null(activityId)) stop("You haven't provided an activityId")

    # Base url and bearer token
    base_url <- "https://api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    # Query
    query <- list(
        name = name,
        color = color
    )

    # Update
    resp <- httr::PATCH(
        url = paste0(base_url, "activities", "/", activityId),
        body = query,
        encode = "json",
        httr::add_headers(Authorization = bearer_token)
    )

    # Status and stop execution if status different from 200
    status <- httr::status_code(resp)
    if (status != 200) stop("Something went wrong! Error code ", status)

    # Parse response
    parsed <- httr::content(resp, type = "application/json")

    # If as_df is TRUE
    if (as_df) {

        parsed <- data.frame(
            id = ifelse(is.null(parsed$id), NA, parsed$id),
            name = ifelse(is.null(parsed$name), NA, parsed$name),
            color = ifelse(is.null(parsed$color), NA, parsed$color),
            integration = ifelse(is.null(parsed$integration), NA, parsed$integration),
            deviceSide = ifelse(is.null(parsed$deviceSide), NA, parsed$deviceSide),
            stringsAsFactors = FALSE
        )

    }

    return(parsed)
}
