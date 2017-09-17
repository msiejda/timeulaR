#' Fetch API Key
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

    if ( httr::status_code(resp) == 200 ) {

        # Extract content from the post data
        parsed <- httr::content(resp, type = "application/json")

    } else {

        stop("Something went wrong!")

    }

    return(parsed)
}
