
timeulaR
========

Timeular ZEI is a tangible time tracking solution. This package is a wrapper for the Timeular public API.

### Installation

You can install timeulaR from github with:

``` r
# install.packages("devtools")
devtools::install_github("Steensson/timeulaR")
```

Timeular Public API functions
=============================

### Obtain access token

With this endpoint you can obtain Access Token required to access secured endpoints. To do so, you have to provide API Key & API Secret. They can be generated on the profile website (<https://profile.timeular.com/#/login>).

``` r
apiKey <- "ABCDefgh1234="
apiSecret <- "EFGHijkl5678="
token <- timeulaR::signIn(apiKey, apiSecret)
```

### Fetch API key

With this function you can fetch your API Key.

``` r
token <- "123456789"
timeulaR::fetchKey(token)
```

### Generate new API Key & API Secret

With this function you can generate new pair of API Key & API Secret. Every time you generate a new pair, an old one becomes invalid. Your API Secret won’t be accessible later, so please note it down in some secret place. If you have lost your API Secret, you can generate a new pair of API Key & API Secret here.

``` r
token <- "123456789"
timeulaR::generateKeys(token)
```

### Fetch user's profile

With this function you can fetch your profile data.

``` r
token <- "123456789"
timeulaR::userProfile(token, as_df = TRUE)
#  userId          email firstName  lastName
#    7030 ses@damvad.com Sebastian Steenssøn
```

### List enabled Integrations

With this endpoint you can list names of all Integrations you have enabled on the profile website (<https://profile.timeular.com/#/login>).

``` r
token <- "123456789"
timeulaR::integrations(token, as_df = TRUE)
#  data frame with 0 columns and 0 rows
```

### List all activities

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

### Create an Activity

With this endpoint you can create a new Activity. It should have name and color. Name doesn’t have to be unique. You can also provide Integration to which Activity will belong (zei by default, which means no special Integration). You can obtain list of enabled Integrations by using the function integrations.

``` r
token <- "123456789"
timeulaR::createActivity(name = "being awesome", color = "#a1b2c3", integration = "zei", token, as_df = TRUE)
#     id          name   color integration deviceSide
#  57842 being awesome #a1b2c3         zei         NA
```

### List all known devices

``` r
token <- "123456789"
timeulaR::listDevices(token)
#    serial name active disabled
#  TZ008W0S   NA   TRUE    FALSE
```

### Show current tracking

``` r
token <- "123456789"
timeulaR::currentTracking(token, as_df = TRUE)
#     id                          name   color integration               startedAt note
#  54647 Acquisition and Public Tender #4eae53         zei 2017-09-18T16:32:26.437   NA
```

### Find Time Entries in given range

Find Time Entries which have at least one millisecond in common with provided time range.

``` r
stoppedAfter <- "2017-09-17T00:00:00.000"
startedBefore <- "2017-09-19T00:00:00.000"
token <- "123456789"
timeulaR::timeEntries(stoppedAfter, startedBefore, token, as_df = TRUE)
#      id activityId name   color integration               startedAt               stoppedAt note
#  432159      54647  xxx #4eae53         zei 2017-09-17T12:20:03.578 2017-09-17T13:47:09.602   NA
#  432267      54647  xxx #4eae53         zei 2017-09-17T14:32:33.226 2017-09-17T16:24:44.072   NA
#  436842      54647  xxx #4eae53         zei 2017-09-18T10:08:23.241 2017-09-18T12:19:12.974   NA
#  436927      54654  xxx #374046         zei 2017-09-18T12:19:20.356 2017-09-18T12:28:28.355   NA
#  437029      54652  xxx #795549         zei 2017-09-18T12:28:28.755 2017-09-18T12:40:50.752   NA
#  437188      54654  xxx #374046         zei 2017-09-18T12:40:51.299 2017-09-18T12:59:41.573   NA
#  437214      54651  xxx #9b2bae         zei 2017-09-18T12:59:42.114 2017-09-18T13:02:08.765   NA
#  437356      54647  xxx #4eae53         zei 2017-09-18T13:02:09.163 2017-09-18T13:19:07.182   NA
#  437827      54651  xxx #9b2bae         zei 2017-09-18T13:19:07.587 2017-09-18T14:11:33.595   NA
#  437862      54652  xxx #795549         zei 2017-09-18T14:11:34.088 2017-09-18T14:15:34.792   NA
#  438043      54651  xxx #9b2bae         zei 2017-09-18T14:15:35.306 2017-09-18T14:32:26.413   NA
#  438477      54647  xxx #4eae53         zei 2017-09-18T14:32:26.960 2017-09-18T15:28:00.451   NA
```

Custom functions
================

### Get the aggregated timetrack on a specific day

``` r
token <- "123456789"
day <- as.POSIXct("2017-09-21", tz = "CET")
timeulaR::timetrackDay(day, token, tz = "CET")
#  name    hm decHour
#   xxx 01:10    1.17
#   yyy 00:18    0.30
#   zzz 05:22    5.36
#   xyz 02:07    2.11
#   zyx 00:15    0.24
```

### Get the aggregated timetrack in a specific week

``` r
token <- "123456789"
timeulaR::timetrackWeek(weekNumber = 38, token, tz = "CET")
#        date   weekDay name    hm decHour
#  2017-09-18    Monday  xxx 06:39    6.64
#  2017-09-18    Monday  yyy 00:28    0.47
#  2017-09-18    Monday  zzz 01:12    1.20
#  2017-09-18    Monday  xyz 00:17    0.27
#  2017-09-19   Tuesday  xxx 06:50    6.82
#  2017-09-19   Tuesday  yyy 01:56    1.93
#  2017-09-19   Tuesday  zzz 00:42    0.69
#  2017-09-19   Tuesday  xyz 01:11    1.18
#  2017-09-20 Wednesday  xxx 00:27    0.45
#  2017-09-20 Wednesday  zzz 07:12    7.19
#  2017-09-20 Wednesday  xyz 00:58    0.97
#  2017-09-21  Thursday  xxx 01:10    1.17
#  2017-09-21  Thursday  yyy 00:18    0.30
#  2017-09-21  Thursday  zzz 05:22    5.36
#  2017-09-21  Thursday  xyz 02:07    2.11
#  2017-09-21  Thursday  zyx 00:15    0.24
#  2017-09-22    Friday  xxx 01:15    1.25
#  2017-09-22    Friday  zyx 02:60    2.99
#  2017-09-22    Friday  zzz 05:45    5.75
#  2017-09-23  Saturday  zyx 01:34    1.56
#  2017-09-23  Saturday  zzz 03:00    3.00
#  2017-09-24    Sunday  xxx 03:31    3.52
```

Helper functions
================

### Convert Timeular timestamp to POSIX object

``` r
timeular_time <- "2017-09-18T12:19:20.356"
timeulaR::timeular_to_posix(timeular_time, tz = "CET")
# "2017-09-18 14:19:20 CEST"
```

### Convert POSIX object to Timeular timestamp

``` r
posix <- as.POSIXct("2017-09-18 14:19:20", tz = "CET")
timeulaR::posix_to_timeular(posix)
# "2017-09-18T12:19:20.00"
```
