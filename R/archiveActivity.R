#' Archive an Activity
#'
#' @param activityId ID of an Activity, eg. 123.
#' @param token Token obtained with \code{\link{signIn}}.
#'
#' @return Nothing is returned, just a message if the activity has been archived.
#' @export
#'
#' @examples token <- "123456789"
#' archiveActivity(activityId = NULL token, as_df = TRUE)
archiveActivity <- function(activityId = NULL, token) {

    if (is.null(activityId)) stop("You haven't provided an activityId")

    # Base url and bearer token
    base_url <- "https://api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    # Request remove
    resp <- httr::DELETE(
        url = paste0(base_url, "activities", "/", activityId),
        encode = "json",
        httr::add_headers(Authorization = bearer_token)
    )

    # Status and stop execution if status different from 200
    status <- httr::status_code(resp)
    if (status != 200) stop("Something went wrong! Error code ", status)

    message("ActivityId ", activityId, " has been archived.")
}
