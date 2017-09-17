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

    base_url <- "api.timeular.com/api/v1/"

    # Building the query string
    bearer_token <- paste("Bearer", token)

    # Post query string to url
    resp <- httr::GET(
        url = paste0(base_url, "user/profile"),
        httr::add_headers(Authorization = bearer_token)
    )

    if ( httr::status_code(resp) == 200 ) {

        # Extract content from the post data
        parsed <- httr::content(resp, type = "application/json")

    } else {

        stop("Something went wrong!")

    }

    if ( as_df ) parsed <- as.data.frame(parsed)

    return(parsed)
}
