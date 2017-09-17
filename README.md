
timeulaR
========

Timeular ZEI is a tangible time tracking solution. This package is a wrapper for the Timeular public API.

Installation
------------

You can install timeulaR from github with:

``` r
# install.packages("devtools")
devtools::install_github("Steensson/timeulaR")
```

Obtain access token
-------------------

With this endpoint you can obtain Access Token required to access secured endpoints. To do so, you have to provide API Key & API Secret. They can be generated on the profile website (<https://profile.timeular.com/#/login>).

``` r
apiKey <- "ABCDefgh1234="
apiSecret <- "EFGHijkl5678="
token <- timeulaR::signIn(apiKey, apiSecret)
```

Fetch user's profile
--------------------

``` r
token <- "123456789"
timeulaR::userProfile(token, as_df = TRUE)
#    userId          email firstName  lastName
#  1   7030 ses@damvad.com Sebastian Steenssøn
```

Fetch API key
-------------

``` r
token <- "123456789"
timeulaR::fetchKey(token)
```
