#' Create an Activity
#'
#' With this endpoint you can create a new Activity. It should have name and color.
#' Name doesn’t have to be unique. You can also provide Integration to which Activity
#' will belong (zei by default, which means no special Integration). You can obtain
#' list of enabled Integrations with the function \code{\link{integrations}}.
#'
#' @param name Name of the new activity.
#' @param color Color of the new activity.
#' @param integration Name of the integration it should integrate with.
#' @param token Token obtained with \code{\link{signIn}}.
#' @param as_df If TRUE a data frame is returned, if FALSE a list is returned.
#'
#' @return A data frame or list with id, name, color, integration and deviceSide (\code{NULL}).
#' @export
#'
#' @examples token <- "123456789"
#' createActivity(name = "being awesome", color = "#a1b2c3", integration = "zei", token, as_df = TRUE)
createActivity <- function(name = "being awesome", color = "#a1b2c3", integration = "zei", token, as_df = TRUE) {

    # Base url and bearer token
    base_url <- "api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    # Query
    query <- list(
        name = name,
        color = color,
        integration = integration
    )

    # Request
    resp <- httr::POST(
        url = paste0(base_url, "activities"),
        body = query,
        encode = "json",
        httr::add_headers(Authorization = bearer_token)
    )

    # Status and stop execution if status different from 200
    status <- httr::status_code(resp)
    if (status != 201) stop("Something went wrong! Error code ", status)

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
