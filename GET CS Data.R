## Request from Coinschedule API

# Load packages
# install.packages(c("httr", "jsonlite"))
# install.packages("tidyverse")

library(tidyverse)
library(httr)
library(jsonlite)


# Request data from Coinbase, get response
df1 <- GET('https://api.coinschedule.com/v2/crowdfunds/ended', 
           accept_json(), 
           add_headers('Authentication-Info' = 'Basic B5FDB041799A1CB4'))

# check if download is correct
names(df1)
df1$status_code # must be 200
class(df1) # -> response

df1_content <- content(df1)

# create dataframe from response
#df_final <- lapply(df1_content$crowdfunds, function(x) {
#  df <- data_frame(ID                = unlist(x["ProjID"]),
#                   ProjName          = x["ProjName"],
#                   Description       = x["ProjDesc"],
#                   ProjCatID         = x["ProjCatID"],
#                   ProjCatName       = x["ProjCatName"],
#                   ProjPlatName      = x["ProjPlatName"],
#                   ProjPackageID     = x["ProjPackageID"],
#                   PackageName       = x["PackageName"],
#                   ProjTopOfUpcoming = x["ProjTopOfUpcoming"],
#                   ProjURL           = x["ProjURL"],
#                   EventID           = x["EventID"],
#                   EventName         = x["EventName"],
#                   EventStartDate    = x["EventStartDate"],
#                   EventEndDate      = x["EventEndDate"],
#                   EventURL          = x["EventURL"],
#                   Percent           = x["Percent"],
#                   Status            = x["Status"],
#                   StatusID          = x["StatusID"],
#                  )
#}) %>% bind_rows()

# create dataframe from response and unlist
df_final <- lapply(df1_content$crowdfunds, function(x) {
  df <- data_frame(ID                = unlist(x["ProjID"]),
                   ProjName          = unlist(x["ProjName"]),
                   Description       = unlist(x["ProjDesc"]),
                   ProjCatID         = unlist(x["ProjCatID"]),
                   ProjCatName       = as.character(x["ProjCatName"]),
                   ProjPlatName      = unlist(x["ProjPlatName"]),
                   ProjPackageID     = unlist(x["ProjPackageID"]),
                   PackageName       = unlist(x["PackageName"]),
                   ProjTopOfUpcoming = unlist(x["ProjTopOfUpcoming"]),
                   ProjURL           = unlist(x["ProjURL"]),
                   EventID           = unlist(x["EventID"]),
                   EventName         = unlist(x["EventName"]),
                   EventStartDate    = unlist(x["EventStartDate"]),
                   EventEndDate      = unlist(x["EventEndDate"]),
                   EventURL          = unlist(x["EventURL"]),
                   Percent           = unlist(x["Percent"]),
                   Status            = unlist(x["Status"]),
                   StatusID          = unlist(x["StatusID"]),
  )
}) %>% bind_rows()

rm(df1, df1_content)

# check for class and 
head(df_final)

# write csv
write.csv(df_final, file = "cf_end.csv")


