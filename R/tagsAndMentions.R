#' Fetch tags & mentions of given activity
#'
#' Tags and mentions are created with use of # and @ prefixes in notes of your
#' time entries. Moreover if an activity is linked with integration, let’s say
#' JIRA project, JIRA task IDs are visible as tags. With this endpoint you can
#' fetch all tags and mentions valid in context of given activity. In this API
#' version each tag / mention has ID only, while labels are \code{NULL} / \code{NA}.
#'
#' @param activityId ID of an Activity, eg. 123.
#' @param token Token obtained with \code{\link{signIn}}.
#' @param as_df If TRUE a data frame is returned, if FALSE a list is returned.
#'
#' @return A data frame or list with type (tag, mention or error), id and label.
#' @export
#'
#' @examples token <- "123456789"
#' tagsAndMentions(activityId = "57302", token, as_df = TRUE)
tagsAndMentions <- function(activityId = NULL, token, as_df = TRUE) {

    if (is.null(activityId)) stop("You haven't provided an activityId")

    base_url <- "api.timeular.com/api/v1/"
    bearer_token <- paste("Bearer", token)

    resp <- httr::GET(
        url = paste0(base_url, "activities/", activityId, "/tags-and-mentions"),
        httr::add_headers(Authorization = bearer_token)
    )

    # Status and stop execution if status different from 200
    status <- httr::status_code(resp)
    if (status != 200) stop("Something went wrong! Error code ", status)

    # Parse response
    parsed <- httr::content(resp, type = "application/json")

    # If as_df is TRUE
    if (as_df) {

        result <- lapply(1:length(parsed), function(i) {

            if(length(parsed[[i]]) != 0) {

                entries <- lapply(parsed[[i]], function(entry) {

                    data.frame(
                        id = ifelse(is.null(entry$id), NA, entry$id),
                        label = ifelse(is.null(entry$label), NA, entry$label),
                        stringsAsFactors = FALSE
                    )

                })

                data.frame(
                    type = names(parsed)[i],
                    do.call(rbind, entries),
                    stringsAsFactors = FALSE
                )

            } else {

                NULL

            }

        })

        result <- do.call(rbind, result)

    }

    return(result)
}
