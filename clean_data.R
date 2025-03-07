# Necessary library for manipulating ----
library(dplyr)


# Import data for manipulating ----
users_df <- read.csv(".data/users_data.csv", stringsAsFactors=F)
cards_df <- read.csv(".data/cards_data.csv", stringsAsFactors=F)


# Manipulate for users_data.csv (Dataframe) ----
## Check missing value in dataframe
colSums(is.na(users_df))

## Check dimension in dataframe
dim(users_df)

## Check data types in dataframe
str(users_df)

## Combine birth_year and birth_month in dataframe
users_df$birth_month <- sprintf("%02d", users_df$birth_month)
users_df$birth_year <- paste(users_df$birth_month, users_df$birth_year, sep="/")
users_df$birth_month <- NULL

## Convert per_capita_income to integer in dataframe
users_df$per_capita_income <- substr(users_df$per_capita_income, 2, length(users_df$per_capita_income))
users_df$per_capita_income <- as.integer(users_df$per_capita_income)

## Convert yearly_income to integer in dataframe
users_df$yearly_income <- substr(users_df$yearly_income, 2, length(users_df$yearly_income))
users_df$yearly_income <- as.integer(users_df$yearly_income)

## Convert total_debt to integer in dataframe
users_df$total_debt <- substr(users_df$total_debt, 2, length(users_df$total_debt))
users_df$total_debt <- as.integer(users_df$total_debt)

## Change column names in dataframe
users_df <- users_df %>%
  rename(
    client_id = id,
    retire_age = retirement_age,
    birth_date = birth_year,
    capita_income = per_capita_income,
    year_income = yearly_income,
    num_cards = num_credit_cards
  )

## Recheck data types in dataframe
str(users_df)

## Write dataframe to CSV
write.csv(users_df, "clean_users.csv", row.names=F)


# Manipulate for cards_data.csv (Dataframe) ----
## Check missing value in dataframe
colSums(is.na(cards_df))

## Check dimension in dataframe
dim(cards_df)

## Check data types in dataframe
str(cards_df)

## Convert card_number to character in dataframe
cards_df$card_number <- as.character(cards_df$card_number)

## Convert credit_limit to integer in dataframe
cards_df$credit_limit <- substr(cards_df$credit_limit, 2, length(cards_df$credit_limit))
cards_df$credit_limit <- as.integer(cards_df$credit_limit)

## Change column names in dataframe
cards_df <- cards_df %>%
  rename(
    card_id = id,
    expire_date = expires,
    card_cvv = cvv,
    card_chip = has_chip,
    num_issued = num_cards_issued,
    open_date = acct_open_date,
    card_pin = year_pin_last_changed,
    card_darkweb = card_on_dark_web
  )

## Recheck data types in dataframe
str(cards_df)

## Write dataframe to CSV
write.csv(cards_df, "clean_cards.csv", row.names=F)


# Sample data for checking ----
users_df[1:3, ]
cards_df[1:3, ]
