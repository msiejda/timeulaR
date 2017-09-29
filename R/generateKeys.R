#' Generate new API key & API secret
#'
#' With this function you can generate new pair of API Key & API Secret.
#' Every time you generate a new pair, an old one becomes invalid.
#' Your API Secret won’t be accessible later, so please note it down in some secret place.
#' If you have lost your API Secret, you can generate a new pair of API Key & API Secret here.
#'
#' @param token Token obtained with \code{\link{signIn}}
#' @param as_df If TRUE a data frame is returned, if FALSE a list is returned.
#'
#' @return A data frame or list with the new API key and API secret key.
#' @export
#'
#' @examples token <- "123456789"
#' generateKeys(token, as_df = TRUE)
generateKeys <- function(token, as_df = TRUE) {

    base_url <- "api.timeular.com/api/v1/"

    # Building the query string
    bearer_token <- paste("Bearer", token)

    # Post query string to url
    resp <- httr::POST(
        url = paste0(base_url, "developer/api-access"),
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
