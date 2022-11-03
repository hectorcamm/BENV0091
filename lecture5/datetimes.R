library(tidyverse)
library(lubridate)



# Examples 1 --------------------------------------------------------------
# Example datetimes
dt1<-"25th Dec 2021 9am"
as_dt1<-dmy_h(dt1)

dt2<-"2021-12-25 09:00"
as_dt2<-ymd_hm(dt2)

dt3<-"25/12/2021 9:00:00"
as_dt3<-dmy_hms(dt3)

# The power of lubridate:
dateformat1<-"20221103" %>% ymd()
dateformat2<-"2022/11/03"%>% ymd()
dateformat3<-"2022-11-03"%>% ymd()
dateformat4<-"2022/11/03 10am"%>% ymd_h()
dateformat5<-"2022/11/03 10am 7m 3s"%>% ymd_hms()
dateformat6<-"2022/11/03 10.1.2"%>% ymd_hms()

# There is an issue with " \ " back slashes so you should convert them with a substituting function before parsing date time

# Example convverting tz

OlsonNames() # shows you valid timezones

with_tz_as_dt1<-as_dt1 %>% with_tz("GMT")
with_tz_as_dt2<-as_dt2 %>% with_tz("Pacific/Gambier")
with_tz_as_dt3<-as_dt3 %>% with_tz("Hongkong")

# Example sourcing date time values
dateformat5_hour<-dateformat5 %>% hour()
dateformat5_minute<-dateformat5 %>% minute()
dateformat5_second<-dateformat5 %>% second()
dateformat5_year<-dateformat5 %>% year()
dateformat5_month<-dateformat5 %>% month()
dateformat5_day<-dateformat5 %>% day()

# Example creating periods
dateformat5_hours<-dateformat5 %>% hours()
dateformat5_minutes<-dateformat5 %>% minutes()
dateformat5_seconds<-dateformat5 %>% seconds()
dateformat5_years<-dateformat5 %>% years()
dateformat5_months<-dateformat5 %>% months()
dateformat5_days<-dateformat5 %>% days()

# Example Arithmetic
(dateformat6-dateformat5) %>% str
(years(dateformat5 %>% year())) + (days(dateformat1 %>% day())+days(200))


# Getting system dates and times

days_in_month(with_tz_as_dt3)


# Exercise 1 -----------------------------------------------------------------
## Task 1 -------
# Try convert to datetime for the next three strings:
dt4<"March 3rd 2003"
dt5<-" 14.11.2030 16:00:00"
dt6<"Tuesday 2nd August 1966 7:30pm"


## Task 2 -------
dt7<-"1st April 1980 5am" # Convert to date time then convert tz to :
# 1 Europe/London (06:00 BST)
# 2 Asia/Tokyo (14:00 JST)
# 3 America/Los_Angeles (21:00 PST)

## Task 3 -------
# Calculate the time in 123456789 seconds from now

# Calculate your age in seconds by taking the difference between the time now and your DOB


as.POSIXct("16:00:00 14.11.2030", format= "%H:%M:%S %d.%m.%y") %>%
    with_tz(.,"UTC")

hms_dmy("16:00:00 14.11.2030")














