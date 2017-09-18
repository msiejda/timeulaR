
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

List all activities
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

List all known devices
----------------------

``` r
token <- "123456789"
timeulaR::listDevices(token)
#    serial name active disabled
#  TZ008W0S   NA   TRUE    FALSE
```

Show current tracking
---------------------

``` r
token <- "123456789"
timeulaR::currentTracking(token)
#     id                          name   color integration           startedAt note
#  54647 Acquisition and Public Tender #4eae53         zei 2017-09-18 16:32:26   NA
```

Find Time Entries in given range
--------------------------------

Find Time Entries which have at least one millisecond in common with provided time range.

``` r
stoppedAfter <- "2017-09-17T00:00:00.000"
startedBefore <- "2017-09-19T00:00:00.000"
token <- "123456789"
timeulaR::timeEntries(stoppedAfter, startedBefore, token, as_df = TRUE, tz = "CET")
#      id activityId name   color integration           startedAt           stoppedAt note
#  432159      54647  xxx #4eae53         zei 2017-09-17 14:20:03 2017-09-17 15:47:09   NA
#  432267      54647  xxx #4eae53         zei 2017-09-17 16:32:33 2017-09-17 18:24:44   NA
#  436842      54647  xxx #4eae53         zei 2017-09-18 12:08:23 2017-09-18 14:19:12   NA
#  436927      54654  xxx #374046         zei 2017-09-18 14:19:20 2017-09-18 14:28:28   NA
#  437029      54652  xxx #795549         zei 2017-09-18 14:28:28 2017-09-18 14:40:50   NA
#  437188      54654  xxx #374046         zei 2017-09-18 14:40:51 2017-09-18 14:59:41   NA
#  437214      54651  xxx #9b2bae         zei 2017-09-18 14:59:42 2017-09-18 15:02:08   NA
#  437356      54647  xxx #4eae53         zei 2017-09-18 15:02:09 2017-09-18 15:19:07   NA
#  437827      54651  xxx #9b2bae         zei 2017-09-18 15:19:07 2017-09-18 16:11:33   NA
#  437862      54652  xxx #795549         zei 2017-09-18 16:11:34 2017-09-18 16:15:34   NA
#  438043      54651  xxx #9b2bae         zei 2017-09-18 16:15:35 2017-09-18 16:32:26   NA
```
