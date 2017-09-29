#' Unassign an activity from a device Side
#'
#' With this endpoint you can unassign an activity from side of your active Device.
#'
#' @param activityId ID of an Activity, eg. 123.
#' @param deviceSide Side of an active Device.
#' @param token Token obtained with \code{\link{signIn}}.
#' @param as_df If TRUE a data frame is returned, if FALSE a list is returned.
#'
#' @return A data frame or list with id, name, color, integration and deviceSide (\code{NULL}).
#' @export
#'
#' @examples token <- "123456789"
#' unassignActivity(activityId = "57302", deviceSide = 8, token, as_df = TRUE)
unassignActivity <- function(activityId = NULL, deviceSide = NULL, token, as_df = TRUE) {

    if (is.null(activityId)) stop("You haven't provided an activityId")
    if (is.null(deviceSide)) stop("You haven't provided a deviceSide")

    # Base url and bearer token
    base_url <- "api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    # Request remove
    resp <- httr::DELETE(
        url = paste0(base_url, "activities/", activityId, "/device-side/", deviceSide),
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
