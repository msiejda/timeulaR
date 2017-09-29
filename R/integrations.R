#' List enabled Integrations
#'
#' With this endpoint you can list names of all Integrations you have enabled.
#'
#' @param token Token obtained with \code{\link{signIn}}
#' @param as_df If TRUE a data frame is returned, if FALSE a list is returned.
#'
#' @return A data frame or list with names of the integrations.
#' @export
#'
#' @examples token <- "123456789"
#' integrations(token, as_df = TRUE)
integrations <- function(token, as_df = TRUE) {

    # Base url and bearer token
    base_url <- "api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    # Retrieve information
    resp <- httr::GET(
        url = paste0(base_url, "integrations"),
        httr::add_headers(Authorization = bearer_token)
    )

    # Status and stop execution if status different from 200
    status <- httr::status_code(resp)
    if (status != 200) stop("Something went wrong! Error code ", status)

    # Parse response
    parsed <- httr::content(resp, type = "application/json")

    # If as_df is TRUE
    if (as_df) parsed <- as.data.frame(parsed)

    return(parsed)
}
