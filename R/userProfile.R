#' Fetch user's profile
#'
#' @param token Token obtained with \code{\link{signIn}}
#' @param as_df If TRUE a data frame is returned, if FALSE a list is returned.
#'
#' @return A data frame or list with userId, email, firstName and lastName.
#' @export
#'
#' @examples token <- "123456789"
#' userProfile(token, as_df = TRUE)
userProfile <- function(token, as_df = TRUE) {

    base_url <- "https://api.timeular.com/api/v1/"

    # Building the query string
    bearer_token <- paste("Bearer", token)

    # Post query string to url
    resp <- httr::GET(
        url = paste0(base_url, "user/profile"),
        httr::add_headers(Authorization = bearer_token)
    )

    # Status and stop execution if status different from 200
    status <- httr::status_code(resp)
    if (status != 200) stop("Something went wrong! Error code ", status)

    # Parse response
    parsed <- httr::content(resp, type = "application/json")

    # If as_df is TRUE
    if ( as_df ) parsed <- as.data.frame(parsed)

    return(parsed)
}
