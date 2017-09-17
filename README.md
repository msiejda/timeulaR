
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

With this function you can fetch your profile data.

``` r
token <- "123456789"
timeulaR::userProfile(token, as_df = TRUE)
#  userId          email firstName  lastName
#    7030 ses@damvad.com Sebastian Steenssøn
```

Fetch API key
-------------

With this function you can fetch your API Key.

``` r
token <- "123456789"
timeulaR::fetchKey(token)
```

Generate new API Key & API Secret
---------------------------------

With this function you can generate new pair of API Key & API Secret. Every time you generate a new pair, an old one becomes invalid. Your API Secret won’t be accessible later, so please note it down in some secret place. If you have lost your API Secret, you can generate a new pair of API Key & API Secret here.

``` r
token <- "123456789"
timeulaR::generateKeys(token)
```

List all Activities
-------------------

``` r
token <- "123456789"
timeulaR::listActivities(token)
#     id name   color integration deviceSide
#  54649  xxx #4051b3         zei          1
#  54650  xxx #fec22e         zei          2
#  54651  xxx #9b2bae         zei          3
#  54652  xxx #795549         zei          4
#  54647  xxx #4eae53         zei          5
#  54648  xxx #f2483f         zei          6
#  54653  xxx #0f9587         zei          7
#  54654  xxx #374046         zei          8
```
