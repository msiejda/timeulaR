#' Obtain access token
#'
#' With this endpoint you can obtain Access Token required to access secured endpoints.
#' To do so, you have to provide API Key & API Secret.
#' They can be generated on the profile website (https://profile.timeular.com/#/login).
#'
#' @param apiKey Your API key
#' @param apiSecret Your secret API key
#'
#' @return An Access Token required to access secured endpoints
#' @export
#'
#' @examples apiKey <- "ABCDefgh1234="
#' apiSecret <- "EFGHijkl5678="
#' signIn(apiKey, apiSecret)
signIn <- function(apiKey, apiSecret) {

    base_url <- "api.timeular.com/api/v1/"

    # Building the query string
    queryString <- list(
        apiKey = apiKey,
        apiSecret = apiSecret
    )

    # Post query string to url
    resp <- httr::POST(
        url = paste0(base_url, "developer/sign-in"),
        body = queryString,
        encode = "json"
    )

    if ( httr::status_code(resp) == 200 ) {

        # Extract content from the post data
        parsed <- httr::content(resp, type = "application/json")
        token <- parsed$token

    } else {

        stop("Something went wrong!")

    }

    return(token)
}
