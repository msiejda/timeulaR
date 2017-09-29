#' Fetch API key
#'
#' With this function you can fetch your API Key.
#'
#' @param token Token obtained with \code{\link{signIn}}
#'
#' @return A character containing your API key.
#' @export
#'
#' @examples token <- "123456789"
#' fetchKey(token)
fetchKey <- function(token) {

    base_url <- "api.timeular.com/api/v1/"

    # Building the query string
    bearer_token <- paste("Bearer", token)

    # Post query string to url
    resp <- httr::GET(
        url = paste0(base_url, "developer/api-access"),
        httr::add_headers(Authorization = bearer_token)
    )

    # Status and stop execution if status different from 200
    status <- httr::status_code(resp)
    if (status != 200) stop("Something went wrong! Error code ", status)

    # Parse response
    parsed <- httr::content(resp, type = "application/json")

    return(result)
}
