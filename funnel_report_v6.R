
# Load Libraries ----
library(sqldf, warn.conflicts = FALSE, quietly = TRUE)
library(openxlsx, warn.conflicts = FALSE, quietly = TRUE)
library(dplyr, warn.conflicts = FALSE, quietly = TRUE)
library(lubridate, warn.conflicts = FALSE, quietly = TRUE)
library(tidyverse, warn.conflicts = FALSE, quietly = TRUE)
library(tidyr, warn.conflicts = FALSE, quietly = TRUE)
library(DataCombine, warn.conflicts = FALSE,  quietly = TRUE)
library(stringr, warn.conflicts = FALSE, quietly = TRUE)

# Remove everything from Environment ----
rm(list=ls())
gc(reset = T)

# Load data  ----
# eruditus_lead = read.csv(text=paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\ERU_lead_all_time.csv"), -7), collapse="\n"), stringsAsFactors = F)
# lead_file_1 = read.csv(text=paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\EM_lead_from_201601_to_201812.csv"), -7), collapse="\n"), stringsAsFactors = F)
# lead_file_2 = read.csv(text=paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\EM_lead_from_201901_to_201911.csv"), -7), collapse="\n"), stringsAsFactors = F)
# lead_file_3 = read.csv(text=paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\EM_lead_from_201912_to_202003.csv"), -7), collapse="\n"), stringsAsFactors = F)
 
# cost_fb_1 = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201601_to_201908_FB.xlsx", sheet = "FB_from_201601_to_201902")
# cost_fb_2 = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201601_to_201908_FB.xlsx", sheet = "FB_from_201903_to_201908")
# cost_fb_3 <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201909_to_202005_FB.xlsx", sheet = "FB_from_201909_to_202005")
 
# cost_fb_crsl_1 = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201601_to_202005.xlsx", sheet = "FB_CRSL_from_201601_to_202001")
# cost_fb_common = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201601_to_202005.xlsx", sheet = "FB_COMMON")
# cost_li_1 = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201601_to_202005.xlsx", sheet = "LI_from_201601_to_202005")
# cost_gg_1 = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201601_to_202005.xlsx", sheet = "GG_from_201601_to_202005")

load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\eruditus_lead.RData")
load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\lead_file_1.RData")
load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\lead_file_2.RData")
load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\lead_file_3.RData")
load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_fb_1.RData")
load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_fb_2.RData")
load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_fb_3.RData")
load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_fb_crsl_1.RData")
load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_fb_common.RData")
load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_li_1.RData")
load("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_gg_1.RData")

# cost_ra = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201601_to_202002.xlsx", sheet = "RA")
# cost_tw = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201601_to_202002.xlsx", sheet = "TW")
# cost_bg = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201601_to_202002.xlsx", sheet = "BING")
# cost_qr = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_from_201601_to_202002.xlsx", sheet = "QUORA")

lead_file_current = read.csv(text=paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\R\\EM_lead_from_202004_till_today.csv"), -7), collapse="\n"), stringsAsFactors = F)
stage = read.csv(text=paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\R\\EM_stage_all_time_till_today.csv"), -7), collapse="\n"), stringsAsFactors = F)
corporate_B2C = read.csv(text=paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\R\\EM_corporate_B2C_all_time_till_today.csv"), -7), collapse="\n"), stringsAsFactors = F)
cost_fb_current = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cost_from_202006_till_today.xlsx", sheet = "FB")
cost_li_current = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cost_from_202006_till_today.xlsx", sheet = "LI")
cost_gg_current = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cost_from_202006_till_today.xlsx", sheet = "GG")
cost_af = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cost_from_202006_till_today.xlsx", sheet = "AF")
cost_fb_crsl_current = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cost_from_202006_till_today.xlsx", sheet = "FB_CRSL")

# load("D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\lead_object.RData")
# load("D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\cost_object.RData")
# load("D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\stage_object.RData")

# Join and Rename data frames ----
emeritus_lead = rbind(lead_file_1, lead_file_2, lead_file_3, lead_file_current)
cost_fb <- rbind(cost_fb_1, cost_fb_2, cost_fb_3, cost_fb_current)
cost_fb_crsl <- rbind(cost_fb_crsl_1, cost_fb_crsl_current)
cost_li <- rbind(cost_li_1, cost_li_current)
cost_gg <- rbind(cost_gg_1, cost_gg_current)

rm(lead_file_1, lead_file_2, lead_file_3, lead_file_current,cost_fb_1, cost_fb_2, cost_fb_3, cost_fb_current,cost_fb_crsl_1, cost_fb_crsl_current, cost_li_1, cost_li_current,cost_gg_1, cost_gg_current)

emeritus_lead <- emeritus_lead %>%
  rename(LEAD_ID = Lead..Lead.ID,
         IC_ID = Interested.Course..ID,
         LEAD_CREATED_DATE = Lead..Created.Date,
         IC_CREATED_DATE = Interested.Course..Created.Date,
         IC_ACTIVE_STATUS = Active,
         LEAD_OWNER = Lead..Lead.Owner,
         PROGRAM = Programme,
         RATING = Rating,
         SUB_RATING = Sub.Rating,
         FIRST_NAME = Lead..First.Name,
         LAST_NAME = Lead..Last.Name,
         EMAIL = Email,
         LEAD_PHONE = Lead..Phone,
         LEAD_COUNTRY = Country,
         ZIP_CODE = Lead..Zip.Postal.Code,
         WORK_EXPERIENCE = Lead..Work.Experience,
         UTM_CAMPAIGN = Utm.Campaign,
         UTM_SOURCE = Utm.Source,
         UTM_MEDIUM = Utm.Medium,
         UTM_TERM = Utm.Term,
         UTM_CONTENT = Utm.Content,
         GA_CAMPAIGN = Lead..Google.Analytics.Campaign,
         GA_SOURCE = Lead..Google.Analytics.Source,
         LEAD_SOURCE = Lead.Source,
         UTM_PLACEMENT = UTM.Placement,
         UTM_CAMPAIGN_ID = UTM.Campaign.ID,
         UTM_ADSET_ID = UTM.Adset.ID,
         UTM_AD_ID = UTM.AD.ID)

eruditus_lead <- eruditus_lead %>%
  rename(LEAD_ID = Lead..Lead.ID,
         EMAIL = Email,
         WORK_EXPERIENCE = Work.Experience,
         IC_ID = Interested.Course..ID,
         PROGRAM = Programme,
         GA_CAMPAIGN = Lead..Google.Analytics.Campaign,
         LEAD_CREATED_DATE = Lead..Created.Date,
         LEAD_COUNTRY = Country,
         GA_SOURCE = Lead..Google.Analytics.Source,
         IC_CREATED_DATE = Created.Dates,
         RATING = Rating,
         LEAD_SOURCE = Lead.Source,
         LEAD_OWNER = Lead..Lead.Owner,
         IC_ACTIVE_STATUS = Active)

eruditus_lead$SUB_RATING = NA
eruditus_lead$FIRST_NAME = NA
eruditus_lead$LAST_NAME = NA
eruditus_lead$LEAD_PHONE = NA
eruditus_lead$ZIP_CODE = NA
eruditus_lead$UTM_CAMPAIGN = NA
eruditus_lead$UTM_SOURCE = NA
eruditus_lead$UTM_MEDIUM = NA
eruditus_lead$UTM_TERM = NA
eruditus_lead$UTM_CONTENT = NA
eruditus_lead$UTM_PLACEMENT = NA
eruditus_lead$UTM_CAMPAIGN_ID = NA
eruditus_lead$UTM_ADSET_ID = NA
eruditus_lead$UTM_AD_ID = NA

lead = rbind(emeritus_lead, eruditus_lead)
rm(emeritus_lead, eruditus_lead)

stage <- stage %>%
  rename(LEAD_ID = Lead.ID,
         IC_ID = Interested.Course.Id,
         APP_ID = Online.Application.ID,
         LEAD_CREATED_DATE = Created.Date,
         IC_CREATED_DATE = Interested.Course..Created.Dates,
         APP_CREATED_DATE = Created.Date.Custom,
         LAST_STAGE_CHANGE_DATE = Last.Stage.Change.Date,
         LEAD_OWNER = Lead.Owner..Full.Name,
         FIRST_NAME = First.Name,
         LAST_NAME = Last.Name,
         PHONE = Mobile.Number,
         APPLICATION_STAGE = Stage,
         AMOUNT = Amount,
         APPLICATION_TYPE = Online.Application.Record.Type,
         BATCH_ID = Batch..Name,
         PROGRAM = Batch..Product..Product.Name,
         ONLINE_APPLICATION_NAME = Online.Application.Name,
         SALUTATION = Salutation,
         EMAIL = Email.Address,
         CITY = City,
         COUNTRY = Country.of.Residence,
         WORK_EXPERIENCE = Work.Experience,
         INCOME = Current.Annual.Compensation.in.USD,
         COMPANY_NAME = Company.Name,
         INDUSTRY = Your.Industry,
         INDUSTRY_OTHER = Your.Industry.Other.,
         FUNCTION = Your.Function,
         FUNCTION_OTHER = Your.Function.Other.,
         JOB_TITLE = Job.Title,
         UTM_CAMPAIGN = Interested.Course..Utm.Campaign,
         UTM_CONTENT = Interested.Course..Utm.Content,
         UTM_MEDIUM = Interested.Course..Utm.Medium,
         UTM_SOURCE = Interested.Course..Utm.Source,
         UTM_TERM = Interested.Course..Utm.Term,
         UTM_AD_ID = Interested.Course..UTM.AD.ID,
         UTM_ADSET_ID = Interested.Course..UTM.Adset.ID,
         UTM_CAMPAIGN_ID = Interested.Course..UTM.Campaign.ID,
         UTM_PLACEMENT = Interested.Course..UTM.Placement,
         GA_CAMPAIGN = Google.Analytics.Campaign,
         GA_SOURCE = Google.Analytics.Source,
         LEAD_SOURCE = Lead.Source)

# Lead Backup 1 ----
# lead_bk_after_rename <- lead

# Remove NA PROGRAM rows from lead ----
na_program_leads <- lead[(lead$PROGRAM == ""),]
save(na_program_leads, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\1_na_program_leads.RData")
rm(na_program_leads)
lead <- lead[(lead$PROGRAM != ""),]
lead$PROGRAM = replace(lead$PROGRAM, lead$PROGRAM == 'EMERITUS PGDGM', 'PGDGM') # Correct programme name

# Date format correction ----
lead$LEAD_CREATED_DATE = as.Date(lead$LEAD_CREATED_DATE,"%m/%d/%Y")
lead$IC_CREATED_DATE = as.Date(lead$IC_CREATED_DATE,"%m/%d/%Y")

stage$LEAD_CREATED_DATE = as.Date(stage$LEAD_CREATED_DATE,"%m/%d/%Y")
stage$IC_CREATED_DATE = as.Date(stage$IC_CREATED_DATE,"%m/%d/%Y")
stage$APP_CREATED_DATE = as.Date(stage$APP_CREATED_DATE,"%m/%d/%Y")
stage$LAST_STAGE_CHANGE_DATE = as.Date(stage$LAST_STAGE_CHANGE_DATE,"%m/%d/%Y")

# NA IC date = Lead date
stage$S_IC_CREATED_DATE_NEW <- ifelse(is.na(stage$IC_CREATED_DATE), stage$LEAD_CREATED_DATE, stage$IC_CREATED_DATE)
stage$IC_CREATED_DATE <- as_date(stage$S_IC_CREATED_DATE_NEW)
stage$S_IC_CREATED_DATE_NEW <- NULL

# When diff btw ic and l is negative. Change lead date = ic date
stage$DiffInLeadAndIC <- difftime(stage$IC_CREATED_DATE, stage$LEAD_CREATED_DATE, units = c("days"))
stage$S_LEAD_CREATED_DATE_new <- ifelse((stage$DiffInLeadAndIC <= -1), stage$LEAD_CREATED_DATE + days(stage$DiffInLeadAndIC), stage$LEAD_CREATED_DATE)
stage$LEAD_CREATED_DATE <- as_date(stage$S_LEAD_CREATED_DATE_new)
stage$DiffInLeadAndIC <- NULL
stage$S_LEAD_CREATED_DATE_new <- NULL

# When diff btw app and ic is negative. Change app create date = ic date.
stage$DiffInAppAndIC <- difftime(stage$APP_CREATED_DATE, stage$IC_CREATED_DATE,units = c("days"))
stage$S_APPLICATION_CREATED_DATE_NEW <- ifelse((stage$DiffInAppAndIC <= -1), stage$APP_CREATED_DATE - days(stage$DiffInAppAndIC), stage$APP_CREATED_DATE)
stage$APP_CREATED_DATE <- as_date(stage$S_APPLICATION_CREATED_DATE_NEW)
stage$DiffInAppAndIC = NULL
stage$S_APPLICATION_CREATED_DATE_NEW = NULL

cost_fb$DATE = as.Date(cost_fb$DATE, origin = "1899-12-30")
cost_li$DATE = as.Date(cost_li$DATE, origin = "1899-12-30")
cost_gg$DATE = as.Date(cost_gg$DATE, origin = "1899-12-30")
cost_af$DATE = as.Date(cost_af$DATE, origin = "1899-12-30")
cost_fb_crsl$DATE = as.Date(cost_fb_crsl$DATE, origin = "1899-12-30")
cost_fb_common$DATE = as.Date(cost_fb_common$DATE, origin = "1899-12-30")

# cost_tw$DATE = as.Date(cost_tw$DATE, origin = "1899-12-30")
# cost_ra$DATE = as.Date(cost_ra$DATE, origin = "1899-12-30")
# cost_qr$DATE = as.Date(cost_qr$DATE, origin = "1899-12-30")
# cost_bg$DATE = as.Date(cost_bg$DATE, origin = "1899-12-30")

# BUCKETING Leads into Batches ----
batch_file <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
batch_file <- select(batch_file, BATCH_ID, PROGRAM, LEAD_FLOW_START, LEAD_FLOW_END)
batch_file$LEAD_FLOW_START <- as.Date(batch_file$LEAD_FLOW_START, origin = "1899-12-30")
batch_file$LEAD_FLOW_END <- as.Date(batch_file$LEAD_FLOW_END, origin = "1899-12-30")
date_table <- data.frame(day = (seq(as.Date('2016-01-01'), Sys.Date(), by = 1)))
date_table_BIG <- sqldf("select * from batch_file
                        cross join date_table
                        where (date_table.day >= batch_file.LEAD_FLOW_START and date_table.day <= batch_file.LEAD_FLOW_END)
                        order by PROGRAM, LEAD_FLOW_START, LEAD_FLOW_END, day")
date_table_BIG$comb <- paste0(date_table_BIG$day, date_table_BIG$PROGRAM)
lead$comb <- paste0(lead$IC_CREATED_DATE, lead$PROGRAM)
date_table_BIG <- select(date_table_BIG, comb, BATCH_ID)
lead <- merge(lead, date_table_BIG, by.x = 'comb', by.y = 'comb', all.x = T, all.y = F)
lead$comb <- NULL
rm(batch_file, date_table, date_table_BIG)

# Lead Backup 2 ----
# lead_bk_after_bucketing <- lead
# stage_bk_after_date_formatting <- stage

# Remove NA / Rename / Incorrect Data leads ----
na_batch_id_leads <- lead[is.na(lead$BATCH_ID),]
save(na_batch_id_leads, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\2_na_batch_id_leads.RData")
rm(na_batch_id_leads)
lead <- lead[!is.na(lead$BATCH_ID),]

# Replace Alumni/Solo batch ----
alumni_batch <- data.frame(from = c("B-5361","B-5420","B-5427","B-5506","B-8591","B-9063","B-6441","B-6444","B-8472","B-9053","B-5425","B-5503","B-6445","B-8592","B-9130","B-9140","B-9142","B-6440","B-6446","B-9097", "B-9657", "B-9985", "B-9987", "B-9986"),
                           to = c("B-5067","B-5225","B-5396","B-5505","B-6574","B-7948","B-5546","B-5552","B-6557","B-7353","B-5374","B-5422","B-5549","B-6562","B-8101","B-9139","B-9141","B-5563","B-6420","B-7041", "B-8612", "B-9582", "B-9590", "B-9591"))
stage <- FindReplace(data = stage, Var = "BATCH_ID", replaceData = alumni_batch, from = "from", to = "to", exact = FALSE)
rm(alumni_batch)

# Data Correction  ----
lead$RATING <- ifelse((lead$RATING == "" | lead$RATING == "open" | lead$RATING == "Pratik"), "Open", lead$RATING)
lead$RATING <- ifelse((lead$RATING == "Working on App."), "Working on App", lead$RATING)

lead$LEAD_COUNT = 1
stage$APP = 1
stage$PAID_APP = ifelse((stage$APPLICATION_STAGE == 'Admission Granted'), 1, 0)
stage$REVENUE = ifelse((stage$APPLICATION_STAGE == 'Admission Granted'), stage$AMOUNT, 0)
stage$REVENUE[is.na(stage$REVENUE)] <- 0
stage$UTM_ADSET_ID <- as.character(stage$UTM_ADSET_ID)     # Convert ID columns into Character
stage$UTM_CAMPAIGN_ID <- as.character(stage$UTM_CAMPAIGN_ID)      # Convert ID columns into Character
stage$AMOUNT[is.na(stage$AMOUNT)] <- 0   # Changing NA to zero
stage <- stage[(stage$BATCH_ID != ""),]    # Remove blank from Batch ID

lead$UTM_CAMPAIGN = replace(lead$UTM_CAMPAIGN, lead$UTM_CAMPAIGN == 'B-3010_DM_Nov_17_Aff', NA)
lead$UTM_CAMPAIGN = replace(lead$UTM_CAMPAIGN, lead$UTM_CAMPAIGN == 'B-3010_DM_Nov\'17_Aff', NA)
lead$UTM_CAMPAIGN = replace(lead$UTM_CAMPAIGN, lead$UTM_CAMPAIGN == 'B-3761_IN_AF_DM_March_18', NA)
lead$UTM_CAMPAIGN = replace(lead$UTM_CAMPAIGN, lead$UTM_CAMPAIGN == 'B-5405_US_AF_WBA_Jun_19', NA)
lead$GA_CAMPAIGN = replace(lead$GA_CAMPAIGN, lead$GA_CAMPAIGN == 'B-3010_DM_Nov_17_Aff', NA)
lead$GA_CAMPAIGN = replace(lead$GA_CAMPAIGN, lead$GA_CAMPAIGN == 'B-3010_DM_Nov\'17_Aff', NA)
lead$GA_CAMPAIGN = replace(lead$GA_CAMPAIGN, lead$GA_CAMPAIGN == 'B-3761_IN_AF_DM_March_18', NA)
lead$GA_CAMPAIGN = replace(lead$GA_CAMPAIGN, lead$GA_CAMPAIGN == 'B-5405_US_AF_WBA_Jun_19', NA)

stage$UTM_CAMPAIGN = replace(stage$UTM_CAMPAIGN, stage$UTM_CAMPAIGN == 'B-3010_DM_Nov_17_Aff', NA)
stage$UTM_CAMPAIGN = replace(stage$UTM_CAMPAIGN, stage$UTM_CAMPAIGN == 'B-3010_DM_Nov\'17_Aff', NA)
stage$UTM_CAMPAIGN = replace(stage$UTM_CAMPAIGN, stage$UTM_CAMPAIGN == 'B-3761_IN_AF_DM_March_18', NA)
stage$GA_CAMPAIGN = replace(stage$GA_CAMPAIGN, stage$GA_CAMPAIGN == 'B-3010_DM_Nov_17_Aff', NA)
stage$GA_CAMPAIGN = replace(stage$GA_CAMPAIGN, stage$GA_CAMPAIGN == 'B-3010_DM_Nov\'17_Aff', NA)
stage$GA_CAMPAIGN = replace(stage$GA_CAMPAIGN, stage$GA_CAMPAIGN == 'B-3761_IN_AF_DM_March_18', NA)
stage$UTM_CAMPAIGN = replace(stage$UTM_CAMPAIGN, stage$UTM_CAMPAIGN == 'B-5405_US_AF_WBA_Jun_19', NA)
stage$GA_CAMPAIGN = replace(stage$GA_CAMPAIGN, stage$GA_CAMPAIGN == 'B-5405_US_AF_WBA_Jun_19', NA)

# Incorrect Campaign Leads ----
lead <- lead %>% filter(UTM_CAMPAIGN != "B-9582_ROW_GG_RM_PGDDB_JUNE_20_APPSTART") %>% select_all()

# Country & Region working : LEAD & STAGE ----
cal_country <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country")
cal_country <- sqldf("select lower(COUNTRY_AS_PER_FILE) as COUNTRY_AS_PER_FILE, COUNTRY_PROPER, REGION from cal_country")
unique_lead_country <- distinct(lead, LEAD_COUNTRY=tolower(LEAD_COUNTRY))
NA_unique_lead_country <- merge(unique_lead_country, cal_country, by.x = 'LEAD_COUNTRY', by.y = 'COUNTRY_AS_PER_FILE', all.x = T, all.y = F)
A7_na_lead_countries = sqldf("select LEAD_COUNTRY from NA_unique_lead_country where COUNTRY_PROPER IS NULL group by LEAD_COUNTRY") # this will export get export with other files
cal_country <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country")
cal_country <- sqldf("select lower(COUNTRY_AS_PER_FILE) as COUNTRY_AS_PER_FILE, COUNTRY_PROPER, REGION from cal_country")
lead$LEAD_COUNTRY = tolower(lead$LEAD_COUNTRY)
lead = merge(lead, cal_country, by.x = 'LEAD_COUNTRY', by.y = 'COUNTRY_AS_PER_FILE', all.x = T, all.y = F)
lead$COUNTRY_PROPER[is.na(lead$COUNTRY_PROPER)] <- "All/Unknown"
lead$REGION[is.na(lead$REGION)] <- "All/Unknown"

stage$COUNTRY = tolower(stage$COUNTRY)
stage = merge(stage, cal_country, by.x = 'COUNTRY', by.y = 'COUNTRY_AS_PER_FILE', all.x = T, all.y = F)
stage$COUNTRY_PROPER[is.na(stage$COUNTRY_PROPER)] <- "All/Unknown"
stage$REGION[is.na(stage$REGION)] <- "All/Unknown"

rm(cal_country, unique_lead_country, NA_unique_lead_country)

# Country & Region working : Cost ----
# Facebook
cal_country_fb_codes <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country_fb_codes")
cal_country_fb_codes$COUNTRY_CODE = tolower(cal_country_fb_codes$COUNTRY_CODE)
cost_fb$COUNTRY_CODE = tolower(cost_fb$COUNTRY_CODE)
cost_fb_crsl$COUNTRY_CODE = tolower(cost_fb_crsl$COUNTRY_CODE)
cost_fb_common$COUNTRY_CODE = tolower(cost_fb_common$COUNTRY_CODE)
cost_fb = merge(cost_fb, cal_country_fb_codes, by.x = 'COUNTRY_CODE', by.y = 'COUNTRY_CODE', all.x = T, all.y = F)
cost_fb_crsl = merge(cost_fb_crsl, cal_country_fb_codes, by.x = 'COUNTRY_CODE', by.y = 'COUNTRY_CODE', all.x = T, all.y = F)
cost_fb_common = merge(cost_fb_common, cal_country_fb_codes, by.x = 'COUNTRY_CODE', by.y = 'COUNTRY_CODE', all.x = T, all.y = F)

rm(cal_country_fb_codes)

lead$LEAD_COUNTRY <- NULL
stage$COUNTRY <- NULL
cost_fb$COUNTRY_CODE = NULL
cost_fb_crsl$COUNTRY_CODE = NULL
cost_fb_common$COUNTRY_CODE = NULL

# Test Lead Working ----
# lead$TEST_EMAIL <- ifelse((str_detect(lead$EMAIL,
#                                             paste(c("^test@gmail.com", "^test@test.com", "^asd@asd.com", "@test.com", "^jesseocon\\+",
#                                             "^hmzatesting@gmail.com", "^hmzatesting\\+", "^jesseocon@gma", "^noemail@emeritus.org", "^testuser",
#                                             "^junaiditeluknipah71@gmail.com", "\\@crayoninfotech.com", "^abc@xyz.com", "^test@emeritus.org",
#                                             "^test1@gmail.com", "^asd@sad.asd", "^abc@123.com", "^a@gmail.com"), collapse = '|'))), 1, 0)
# lead$TEST_EMAIL <- ifelse(((nchar(lead$EMAIL)) <= 9),1, lead$TEST_EMAIL)
# lead$TEST_EMAIL <- ifelse((str_detect(lead$EMAIL, paste(c("^xx@xx.com", "^vt@fh.ag", "^ts@sky.pl", "^mb@mnb.sk", "^a@aj.tc", "^nd@hp.com"), collapse = '|'))),0, lead$TEST_EMAIL)
# 
# test_lead_email_base <- lead[(lead$TEST_EMAIL == 1),]
# save(test_lead_email_base, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\3_test_lead_email_base.RData")

# lead <- lead[(lead$TEST_EMAIL == 0),]
# lead$TEST_EMAIL <- NULL

# test_lead_email_base <- select(lead, PROGRAM, EMAIL, TEST_EMAIL)
# test_lead_email_base <- test_lead_email_base[(test_lead_email_base$TEST_EMAIL == 1),]
# test_lead_email_base <- test_lead_email_base %>% group_by_all() %>% tally()
# write.csv(test_lead_email_base, "test_lead_email_base.csv")
# rm(test_lead_email_base)

# Test App Working ----
# stage$TEST_EMAIL <- ifelse((str_detect(stage$EMAIL,
#                                       paste(c("^test@gmail.com", "^test@test.com", "^asd@asd.com", "@test.com", "^jesseocon\\+",
#                                               "^hmzatesting@gmail.com", "^hmzatesting\\+", "^jesseocon@gma", "^noemail@emeritus.org", "^testuser",
#                                               "^junaiditeluknipah71@gmail.com", "\\@crayoninfotech.com", "^abc@xyz.com", "^test@emeritus.org",
#                                               "^test1@gmail.com", "^asd@sad.asd", "^abc@123.com", "^a@gmail.com"), collapse = '|'))), 1, 0)
# stage$TEST_EMAIL <- ifelse(((nchar(stage$EMAIL)) <= 9),1, stage$TEST_EMAIL)
# stage$TEST_EMAIL <- ifelse((str_detect(stage$EMAIL, paste(c("^xx@xx.com", "^vt@fh.ag", "^ts@sky.pl", "^mb@mnb.sk", "^a@aj.tc", "^nd@hp.com"), collapse = '|'))),0, stage$TEST_EMAIL)
# 
# test_stage_email_base <- stage[(stage$TEST_EMAIL == 1),]
# save(test_stage_email_base, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\3_test_stage_email_base.RData")

# stage <- stage[(stage$TEST_EMAIL == 0),]
# stage$TEST_EMAIL <- NULL

# test_stage_email_base <- select(stage, PROGRAM, EMAIL, TEST_EMAIL, PAID_APP, REVENUE)
# test_stage_email_base <- test_stage_email_base[(test_stage_email_base$TEST_EMAIL == 1),]
# test_stage_email_base <- test_stage_email_base %>% group_by_all() %>% tally()
# write.csv(test_stage_email_base, "test_stage_email_base.csv")
# rm(test_stage_email_base)

# Backup 2.1 ----
# lead_bk_after_test <- lead
# stage_bk_after_test <- stage

# China Lead Working ----
lead_CHINA_1 <- lead %>% select_all() %>% filter(grepl("CN_FB|CN_LI|^CN", UTM_CAMPAIGN) & IC_CREATED_DATE >= "2020-01-01")
lead_CHINA_2 <- lead %>% select_all() %>% filter(grepl("Kyrene Wang|Rachel Guo|David Zhou", LEAD_OWNER) & IC_CREATED_DATE >= "2020-01-01" & UTM_CAMPAIGN == "" & UTM_SOURCE == "" & COUNTRY_PROPER == "China")
lead_CHINA <- rbind(lead_CHINA_1, lead_CHINA_2)
lead <- anti_join(lead, lead_CHINA, by="IC_ID")
write.csv(lead_CHINA, paste0("C:\\Users\\yogesh.alkari\\Downloads\\lead_CHINA_", Sys.Date(), ".csv"), row.names=F)
save(lead_CHINA, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\2_lead_CHINA.RData")
rm(lead_CHINA_1, lead_CHINA_2, lead_CHINA)

# Work Experience / Income / Gender working ----
# Lead
cal_work_ex_master <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_work_experience")
lead$LEAD_WORK_EXPERIENCE_REV <- gsub(pattern="[[:punct:]][[:alpha:]]{2}[[:punct:]]", lead$WORK_EXPERIENCE, replacement="")
lead_work_ex_check <- distinct(lead, LEAD_WORK_EXPERIENCE_REV)
lead_work_ex_check <- lead_work_ex_check %>% rename(WORK_EXPERIENCE = LEAD_WORK_EXPERIENCE_REV)
lead_work_ex_check = merge(lead_work_ex_check, cal_work_ex_master, by.x = 'WORK_EXPERIENCE', by.y = 'work_experience', all.x = T, all.y = F)
A6_na_work_ex = sqldf("select WORK_EXPERIENCE from lead_work_ex_check where work_ex_slab IS NULL group by WORK_EXPERIENCE")  # this will export get export with other files
lead = merge(lead, cal_work_ex_master, by.x = 'LEAD_WORK_EXPERIENCE_REV', by.y = 'work_experience', all.x = T, all.y = F)
na_work_ex_leads <- lead[is.na(lead$WORK_EX_SLAB),]
save(na_work_ex_leads, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\3_na_work_ex_leads.RData")
lead$WORK_EX_SLAB[is.na(lead$WORK_EX_SLAB)] <- "1-5 yrs"
rm(lead_work_ex_check, na_work_ex_leads, cal_work_ex_master)

# Stage
stage$WORK_EX_SLAB = ifelse((stage$WORK_EXPERIENCE >= 21), "20+ yrs",
                                    ifelse((stage$WORK_EXPERIENCE >= 16), "16-20 yrs",
                                           ifelse((stage$WORK_EXPERIENCE >= 11), "11-15 yrs",
                                                  ifelse((stage$WORK_EXPERIENCE >= 6), "6-10 yrs", "1-5 yrs"))))
stage$WORK_EX_SLAB <- ifelse(is.na(stage$WORK_EX_SLAB), "1-5 yrs", stage$WORK_EX_SLAB)

stage$INCOME_SLAB = ifelse((stage$INCOME == "Above USD 200,000"), ">200k",
                           ifelse((stage$INCOME == "USD 150,001 to USD 200,000"), "150k-200k",
                                  ifelse((stage$INCOME == "USD 100,001 to USD 150,000"), "100k-150k",
                                         ifelse((stage$INCOME == "USD 50,001 to USD 100,000"), "50k-100k", "<50k"))))
stage$INCOME_SLAB <- ifelse(is.na(stage$INCOME_SLAB), "<50k", stage$INCOME_SLAB)
stage$GENDER = ifelse((stage$SALUTATION == "Mr." | stage$SALUTATION == "Dr." | stage$SALUTATION == ""), "Male", "Female")

lead[,c('LEAD_WORK_EXPERIENCE_REV', 'WORK_EXPERIENCE')] <- list(NULL)
stage[,c('SALUTATION', 'WORK_EXPERIENCE', 'INCOME')] <- list(NULL)

# Currency and Discount working ----
cost_gg$AMOUNT_IN_USD = ifelse((cost_gg$CURRENCY == "SGD"), cost_gg$COST * 0.72, cost_gg$COST)
cost_gg[,c('COST', 'CURRENCY')] <- list(NULL)

# cost_tw$AMOUNT_IN_USD = as.numeric(cost_tw$COST_IN_SGD * 0.72)
# cost_bg$COST_IN_USD = as.numeric(cost_bg$COST_IN_SGD * 0.72)
# cost_tw$COST_IN_SGD = NULL
# cost_bg$COST_IN_SGD = NULL

cal_li_discount_rate <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_discount_li")
cal_li_discount_rate$ACCOUNT_NAME = tolower(cal_li_discount_rate$ACCOUNT_NAME)
cost_li$ACCOUNT_NAME = tolower(cost_li$ACCOUNT_NAME)
cost_li = merge(cost_li, cal_li_discount_rate, by.x = 'ACCOUNT_NAME', by.y = 'ACCOUNT_NAME', all.x = T, all.y = F)
cost_li$AMOUNT_AFTER_DISCOUNT = cost_li$AMOUNT * cost_li$DISCOUNT_RATE * cost_li$GST
cost_li[,c('ACCOUNT_TYPE', 'DISCOUNT_RATE', 'GST')] <- list(NULL)
rm(cal_li_discount_rate)

# LOB Mapping ---- 
cal_LOB_base <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "lob")
cal_LOB_base <- data.frame(BATCH_ID=cal_LOB_base$Name, LOB=cal_LOB_base$LOB)
stage <- merge(stage, cal_LOB_base, by.x = 'BATCH_ID', by.y = 'BATCH_ID', all.x = T, all.y = F)
other_lob_stage <- stage[(stage$LOB == "Latam" | stage$LOB == "Non_Marketed_Cohorts" | is.na(stage$LOB)),]
save(other_lob_stage, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\4_other_lob_stage.RData")
stage <- stage[(stage$LOB != "Latam" & stage$LOB != "Non_Marketed_Cohorts" & !is.na(stage$LOB)),]
rm(cal_LOB_base, other_lob_stage)

# Deferred working ----
application_name_split = strsplit(stage$ONLINE_APPLICATION_NAME, "/", 0)
splitted_application_name = data.frame(do.call(rbind,application_name_split))
stage = cbind(stage,splitted_application_name)
names(stage)[names(stage)=="X2"]="ORIGINAL_BATCH_ID"
stage[, c('X1', 'X3')] <- list(NULL)
stage$ORIGINAL_BATCH_ID = toupper(stage$ORIGINAL_BATCH_ID)
stage$DEFERRED = ifelse((stage$BATCH_ID == stage$ORIGINAL_BATCH_ID),"New","Deferred")
rm(splitted_application_name, application_name_split)

# Lead Backup 3 ----
# lead_bk_after_data_correction <- lead
# stage_bk_after_data_correction <- stage

# Linkedin & Reddit country working (Part 1 of 2) ----
cal_country_as_per_campaign_for_li_and_ra <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country_li_and_ra")
cal_country_as_per_campaign_for_li_and_ra$CAMPAIGN_NAME = tolower(cal_country_as_per_campaign_for_li_and_ra$CAMPAIGN_NAME)

cost_li_unique_country <- distinct(cost_li, CAMPAIGN_NAME)
cost_li_unique_country$CAMPAIGN_NAME = tolower(cost_li_unique_country$CAMPAIGN_NAME)

NA_countries_li_check = merge(cost_li_unique_country, cal_country_as_per_campaign_for_li_and_ra, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
A1_NA_countries_li = sqldf("select CAMPAIGN_NAME , count (*) from NA_countries_li_check
                        where COUNTRY_AS_PER_CAMPAIGN_NAME IS NULL group by CAMPAIGN_NAME")  # this will export get export with other files
rm(cal_country_as_per_campaign_for_li_and_ra, cost_li_unique_country, NA_countries_li_check)

# Bing country working (Part 1 of 2) ----
# cal_country_working_for_bg <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country_bg")
# cal_country_working_for_bg$CAMPAIGN_NAME = tolower(cal_country_working_for_bg$CAMPAIGN_NAME)
# cost_bg_country <- data.frame(unique(cost_bg$CAMPAIGN_NAME))
# names(cost_bg_country)[names(cost_bg_country)=="unique.cost_bg.CAMPAIGN_NAME."]="CAMPAIGN_NAME"
# cost_bg_country$CAMPAIGN_NAME <- tolower(cost_bg_country$CAMPAIGN_NAME)
# na_cost_bg_check = merge(cost_bg_country, cal_country_working_for_bg, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
# A2_NA_countries_BG = sqldf("select CAMPAIGN_NAME , count (*) from na_cost_bg_check
#                         where COUNTRY_AS_PER_CAMPAIGN_NAME IS NULL group by CAMPAIGN_NAME")  # this will export get export with other files
# rm(cal_country_working_for_bg, cost_bg_country, na_cost_bg_check)

# FB OTHER's Course attribution (Part 1 of 2) ----
cal_ad_name_fb <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_ad_name_fb")
cal_ad_name_fb$FB_ID = tolower(cal_ad_name_fb$FB_ID)
unique_crsl <- distinct(cost_fb_crsl, FB_ID)
unique_common <- distinct(cost_fb_common, FB_ID)
unique_cc_common <- rbind(unique_crsl, unique_common)
unique_cc_common$FB_ID <- tolower(unique_cc_common$FB_ID)
na_cost_fb_oth = merge(unique_cc_common, cal_ad_name_fb, by.x = 'FB_ID', by.y = 'FB_ID', all.x = T, all.y = F)
A3_na_cost_fb_oth_NA = sqldf("select FB_ID, count(*) from na_cost_fb_oth where COHORT IS NULL group by FB_ID")  # this will export get export with other files
rm(cal_ad_name_fb, unique_crsl, unique_common, unique_cc_common, na_cost_fb_oth)

# FB OTHER's Channel attribution (Part 1 of 2) ----
cal_campaign_name_fb <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_campaign_name_fb")
cal_campaign_name_fb$CAMPAIGN_NAME = tolower(cal_campaign_name_fb$CAMPAIGN_NAME)
uniqeu_cost_fb_crsl_campaign <- distinct(cost_fb_crsl, CAMPAIGN_NAME)
uniqeu_cost_fb_common_campaign <- distinct(cost_fb_common, CAMPAIGN_NAME)
uniqeu_cost_fb_other_campaign <- rbind(uniqeu_cost_fb_crsl_campaign, uniqeu_cost_fb_common_campaign)
uniqeu_cost_fb_other_campaign$CAMPAIGN_NAME = tolower(uniqeu_cost_fb_other_campaign$CAMPAIGN_NAME)
na_campaing_cost_fb_other = merge(uniqeu_cost_fb_other_campaign, cal_campaign_name_fb, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
A4_na_campaing_cost_fb_other_NA = sqldf("select CAMPAIGN_NAME, count(*) from na_campaing_cost_fb_other
                                     where SUB_CHANNEL_AS_PER_CAMPAIGN_NAME IS NULL group by CAMPAIGN_NAME")  # this will export get export with other files
rm(cal_campaign_name_fb, uniqeu_cost_fb_crsl_campaign, uniqeu_cost_fb_common_campaign, uniqeu_cost_fb_other_campaign, na_campaing_cost_fb_other)

unique_lead_utm_campaign = distinct(lead, CAMPAIGN_NAME=UTM_CAMPAIGN)
unique_lead_ga_campaign = distinct(lead, CAMPAIGN_NAME=GA_CAMPAIGN)
unique_lead_utm_source = distinct(lead, CAMPAIGN_NAME=UTM_SOURCE)
unique_lead_ga_source = distinct(lead, CAMPAIGN_NAME=GA_SOURCE)
unique_lead_lead_source = distinct(lead, CAMPAIGN_NAME=LEAD_SOURCE)

uniqeu_cost_fb_campaign = distinct(cost_fb, CAMPAIGN_NAME)
uniqeu_cost_li_campaign = distinct(cost_li, CAMPAIGN_NAME)
uniqeu_cost_gg_campaign = distinct(cost_gg, CAMPAIGN_NAME)

# uniqeu_cost_ra_campaign = distinct(cost_ra, CAMPAIGN_NAME)
# uniqeu_cost_tw_campaign = distinct(cost_tw, CAMPAIGN_NAME)
# uniqeu_cost_bg_campaign = distinct(cost_bg, CAMPAIGN_NAME)

unique_campaign_name = rbind(unique_lead_utm_campaign,
                             unique_lead_ga_campaign,
                             unique_lead_utm_source,
                             unique_lead_ga_source,
                             unique_lead_lead_source,
                             uniqeu_cost_fb_campaign,
                             uniqeu_cost_li_campaign,
                             uniqeu_cost_gg_campaign)

# unique_campaign_name = rbind(unique_lead_utm_campaign,
#                              unique_lead_ga_campaign,
#                              unique_lead_utm_source,
#                              unique_lead_ga_source,
#                              unique_lead_lead_source,
#                              uniqeu_cost_fb_campaign,
#                              uniqeu_cost_li_campaign,
#                              uniqeu_cost_gg_campaign,
#                              uniqeu_cost_ra_campaign,
#                              uniqeu_cost_tw_campaign,
#                              uniqeu_cost_bg_campaign)

unique_campaign_name = unique(unique_campaign_name)

cal_campaign <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_campaign")
cal_campaign$CAMPAIGN_NAME = tolower(cal_campaign$CAMPAIGN_NAME)
unique_campaign_name$CAMPAIGN_NAME = tolower(unique_campaign_name$CAMPAIGN_NAME)
na_source = merge(unique_campaign_name, cal_campaign, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
A5_na_source_NA = sqldf("select CAMPAIGN_NAME, count (*) from na_source where CHANNEL_AS_PER_CAMPAIGN_NAME IS NULL group by CAMPAIGN_NAME")  # this will export get export with other files

rm(unique_lead_utm_campaign, unique_lead_ga_campaign, unique_lead_ga_source, unique_lead_utm_source, unique_lead_lead_source,
   uniqeu_cost_fb_campaign, uniqeu_cost_li_campaign, uniqeu_cost_gg_campaign, cal_campaign, unique_campaign_name, na_source)
# rm(uniqeu_cost_ra_campaign, uniqeu_cost_tw_campaign,uniqeu_cost_bg_campaign)

# Create Workbook and export NA sheets ----
na_values <- createWorkbook()
addWorksheet(na_values, "li_na_countries")
addWorksheet(na_values, "na_countries")
addWorksheet(na_values, "na_work_ex")
# addWorksheet(na_values, "bg_na_countries")
addWorksheet(na_values, "fb_campaign")
addWorksheet(na_values, "fb_comm_and_cour_names")
addWorksheet(na_values, "na_sources")
writeData(na_values, sheet = "li_na_countries", x = A1_NA_countries_li)
# writeData(na_values, sheet = "bg_na_countries", x = A2_NA_countries_BG)
writeData(na_values, sheet = "fb_comm_and_cour_names", x = A3_na_cost_fb_oth_NA)
writeData(na_values, sheet = "fb_campaign", x = A4_na_campaing_cost_fb_other_NA)
writeData(na_values, sheet = "na_sources", x = A5_na_source_NA)
writeData(na_values, sheet = "na_work_ex", x = A6_na_work_ex)
writeData(na_values, sheet = "na_countries", x = A7_na_lead_countries)
saveWorkbook(na_values, "D:\\Emeritus\\Reports\\Automation\\R\\na_values.xlsx", overwrite = TRUE)

rm(A7_na_lead_countries, A1_NA_countries_li, A3_na_cost_fb_oth_NA, A4_na_campaing_cost_fb_other_NA, A5_na_source_NA, A6_na_work_ex)
# rm(A2_NA_countries_BG)


# BREAK and UPDATE -------- NA FILES ----------------------------------------------------------------------------------------------

# FB OTHER's COHORT attribution (Part 2 of 2) ----
cal_master_fb_oth <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_ad_name_fb")
cal_master_fb_oth$FB_ID = tolower(cal_master_fb_oth$FB_ID)
cost_fb_crsl$FB_ID = tolower(cost_fb_crsl$FB_ID)
cost_fb_common$FB_ID = tolower(cost_fb_common$FB_ID)
cost_fb_crsl = merge(cost_fb_crsl, cal_master_fb_oth, by.x = 'FB_ID', by.y = 'FB_ID', all.x = T, all.y = F)
cost_fb_common = merge(cost_fb_common, cal_master_fb_oth, by.x = 'FB_ID', by.y = 'FB_ID', all.x = T, all.y = F)
rm(cal_master_fb_oth)

# FB OTHER's Sub-Channel attribution (Part 2 of 2) ----
cal_master_fb_oth <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_campaign_name_fb")
cal_master_fb_oth$CAMPAIGN_NAME = tolower(cal_master_fb_oth$CAMPAIGN_NAME)
cost_fb_crsl$CAMPAIGN_NAME = tolower(cost_fb_crsl$CAMPAIGN_NAME)
cost_fb_common$CAMPAIGN_NAME = tolower(cost_fb_common$CAMPAIGN_NAME)
cost_fb_crsl = merge(cost_fb_crsl, cal_master_fb_oth, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
cost_fb_common = merge(cost_fb_common, cal_master_fb_oth, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
cost_fb_crsl$CHANNEL_AS_PER_CAMPAIGN_NAME = "Facebook"
cost_fb_common$CHANNEL_AS_PER_CAMPAIGN_NAME = "Facebook"
rm(cal_master_fb_oth)

# Linkedin & Reddit (Part 2 of 2) ----
country_as_per_campaign_for_li_and_ra <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country_li_and_ra")
country_as_per_campaign_for_li_and_ra$CAMPAIGN_NAME = tolower(country_as_per_campaign_for_li_and_ra$CAMPAIGN_NAME)
cost_li$CAMPAIGN_NAME = tolower(cost_li$CAMPAIGN_NAME)
cost_li = merge(cost_li, country_as_per_campaign_for_li_and_ra, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)

# cost_ra$CAMPAIGN_NAME <- tolower(cost_ra$CAMPAIGN_NAME)
# cost_ra = merge(cost_ra, country_as_per_campaign_for_li_and_ra, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)

### NA_countries_ra = sqldf("select CAMPAIGN_NAME , count (*) from cost_ra where COUNTRY_AS_PER_CAMPAIGN_NAME IS NULL group by CAMPAIGN_NAME")
### View(NA_countries_ra)
### write.xlsx(NA_countries_ra, "NA_countries_RA.xlsx")
rm(country_as_per_campaign_for_li_and_ra)

# Update Proper Country to BING (Part 2 of 2) ----
# country_working_for_bg <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country_bg")
# country_working_for_bg$CAMPAIGN_NAME = tolower(country_working_for_bg$CAMPAIGN_NAME)
# cost_bg$CAMPAIGN_NAME <- tolower(cost_bg$CAMPAIGN_NAME)
# cost_bg = merge(cost_bg, country_working_for_bg, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
# rm(country_working_for_bg)

# Region working for GG, TW, QR and AF ----
cal_country_for_gg_tw_QR_AF <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country")
cal_country_for_gg_tw_QR_AF <- select(cal_country_for_gg_tw_QR_AF, COUNTRY_AS_PER_FILE, COUNTRY_PROPER, REGION)
cost_gg$COUNTRY <- tolower(cost_gg$COUNTRY)
cost_af$COUNTRY <- tolower(cost_af$COUNTRY)
cal_country_for_gg_tw_QR_AF$COUNTRY_AS_PER_FILE <- tolower(cal_country_for_gg_tw_QR_AF$COUNTRY_AS_PER_FILE)
cost_gg <- merge(cost_gg, cal_country_for_gg_tw_QR_AF, by.x = 'COUNTRY', by.y = 'COUNTRY_AS_PER_FILE', all.x = T, all.y = F)
cost_af <- merge(cost_af, cal_country_for_gg_tw_QR_AF, by.x = 'COUNTRY', by.y = 'COUNTRY_AS_PER_FILE', all.x = T, all.y = F)
cost_gg$COUNTRY = NULL
cost_af$COUNTRY = NULL

# cost_tw$COUNTRY <- tolower(cost_tw$COUNTRY)
# cost_qr$COUNTRY <- tolower(cost_qr$COUNTRY)
# cost_tw <- merge(cost_tw, cal_country_for_gg_tw_QR_AF, by.x = 'COUNTRY', by.y = 'COUNTRY_AS_PER_FILE', all.x = T, all.y = F)
# cost_qr <- merge(cost_qr, cal_country_for_gg_tw_QR_AF, by.x = 'COUNTRY', by.y = 'COUNTRY_AS_PER_FILE', all.x = T, all.y = F)
# cost_tw$COUNTRY = NULL
# cost_qr$COUNTRY = NULL
rm(cal_country_for_gg_tw_QR_AF)

# Channel Attribution  to Lead ----
cal_campaign <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_campaign")
cal_campaign$COHORT = NULL
lead$UTM_CAMPAIGN = tolower(lead$UTM_CAMPAIGN)
lead$GA_CAMPAIGN = tolower(lead$GA_CAMPAIGN)
lead$UTM_SOURCE = tolower(lead$UTM_SOURCE)
lead$GA_SOURCE = tolower(lead$GA_SOURCE)
lead$LEAD_SOURCE = tolower(lead$LEAD_SOURCE)
cal_campaign$CAMPAIGN_NAME = tolower(cal_campaign$CAMPAIGN_NAME)

lead = merge(lead, cal_campaign, by.x = 'UTM_CAMPAIGN', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
lead <- lead %>% rename(UTM_CAMPAIGN_PROPER_CHANNEL = CHANNEL_AS_PER_CAMPAIGN_NAME, UTM_CAMPAIGN_PROPER_SUB_CHANNEL = SUB_CHANNEL_AS_PER_CAMPAIGN_NAME)

lead = merge(lead, cal_campaign, by.x = 'GA_CAMPAIGN', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
lead <- lead %>% rename(GA_CAMPAIGN_PROPER_CHANNEL = CHANNEL_AS_PER_CAMPAIGN_NAME, GA_CAMPAIGN_PROPER_SUB_CHANNEL = SUB_CHANNEL_AS_PER_CAMPAIGN_NAME)

lead = merge(lead, cal_campaign, by.x = 'UTM_SOURCE', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
lead <- lead %>% rename(UTM_SOURCE_PROPER_CHANNEL = CHANNEL_AS_PER_CAMPAIGN_NAME, UTM_SOURCE_PROPER_SUB_CHANNEL = SUB_CHANNEL_AS_PER_CAMPAIGN_NAME)

lead = merge(lead, cal_campaign, by.x = 'GA_SOURCE', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
lead <- lead %>% rename(GA_SOURCE_PROPER_CHANNEL = CHANNEL_AS_PER_CAMPAIGN_NAME, GA_SOURCE_PROPER_SUB_CHANNEL = SUB_CHANNEL_AS_PER_CAMPAIGN_NAME)

lead = merge(lead, cal_campaign, by.x = 'LEAD_SOURCE', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
lead <- lead %>% rename(LEAD_SOURCE_PROPER_CHANNEL = CHANNEL_AS_PER_CAMPAIGN_NAME, LEAD_SOURCE_PROPER_SUB_CHANNEL = SUB_CHANNEL_AS_PER_CAMPAIGN_NAME)

# Final Lead Source Calculations
lead$FINAL_CHANNEL = ifelse(!is.na(lead$UTM_CAMPAIGN_PROPER_CHANNEL), as.character(lead$UTM_CAMPAIGN_PROPER_CHANNEL),
                            ifelse(!is.na(lead$UTM_SOURCE_PROPER_CHANNEL), as.character(lead$UTM_SOURCE_PROPER_CHANNEL),
                                   ifelse(!is.na(lead$GA_CAMPAIGN_PROPER_CHANNEL), as.character(lead$GA_CAMPAIGN_PROPER_CHANNEL),
                                          ifelse(!is.na(lead$GA_SOURCE_PROPER_CHANNEL), as.character(lead$GA_SOURCE_PROPER_CHANNEL),
                                                 ifelse(!is.na(lead$LEAD_SOURCE_PROPER_CHANNEL), as.character(lead$LEAD_SOURCE_PROPER_CHANNEL), "Other")))))

lead$FINAL_SUB_CHANNEL = ifelse(!is.na(lead$UTM_CAMPAIGN_PROPER_SUB_CHANNEL), as.character(lead$UTM_CAMPAIGN_PROPER_SUB_CHANNEL),
                                ifelse(!is.na(lead$UTM_SOURCE_PROPER_SUB_CHANNEL), as.character(lead$UTM_SOURCE_PROPER_SUB_CHANNEL),
                                       ifelse(!is.na(lead$GA_CAMPAIGN_PROPER_SUB_CHANNEL), as.character(lead$GA_CAMPAIGN_PROPER_SUB_CHANNEL),
                                              ifelse(!is.na(lead$GA_SOURCE_PROPER_SUB_CHANNEL), as.character(lead$GA_SOURCE_PROPER_SUB_CHANNEL),
                                                     ifelse(!is.na(lead$LEAD_SOURCE_PROPER_SUB_CHANNEL), as.character(lead$LEAD_SOURCE_PROPER_SUB_CHANNEL), "Other_Unidentified")))))
rm(cal_campaign)
lead[,c('GA_CAMPAIGN_PROPER_CHANNEL', 'GA_CAMPAIGN_PROPER_SUB_CHANNEL', 'GA_SOURCE_PROPER_CHANNEL', 'GA_SOURCE_PROPER_SUB_CHANNEL',
        'LEAD_SOURCE_PROPER_CHANNEL', 'LEAD_SOURCE_PROPER_SUB_CHANNEL', 'UTM_CAMPAIGN_PROPER_CHANNEL', 'UTM_CAMPAIGN_PROPER_SUB_CHANNEL',
        'UTM_SOURCE_PROPER_CHANNEL', 'UTM_SOURCE_PROPER_SUB_CHANNEL')] <- list(NULL)

# Channel Attribution  to Cost ----
channel_and_programme_for_cost_data <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_campaign")
channel_and_programme_for_cost_data$CAMPAIGN_NAME = tolower(channel_and_programme_for_cost_data$CAMPAIGN_NAME)

cost_fb$CAMPAIGN_NAME = tolower(cost_fb$CAMPAIGN_NAME)
cost_li$CAMPAIGN_NAME = tolower(cost_li$CAMPAIGN_NAME)
cost_gg$CAMPAIGN_NAME = tolower(cost_gg$CAMPAIGN_NAME)
cost_fb = merge(cost_fb, channel_and_programme_for_cost_data, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
cost_li = merge(cost_li, channel_and_programme_for_cost_data, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
cost_gg = merge(cost_gg, channel_and_programme_for_cost_data, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)

# cost_tw$CAMPAIGN_NAME = tolower(cost_tw$CAMPAIGN_NAME)
# cost_ra$CAMPAIGN_NAME = tolower(cost_ra$CAMPAIGN_NAME)
# cost_bg$CAMPAIGN_NAME = tolower(cost_bg$CAMPAIGN_NAME)
# cost_tw = merge(cost_tw, channel_and_programme_for_cost_data, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
# cost_ra = merge(cost_ra, channel_and_programme_for_cost_data, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
# cost_bg = merge(cost_bg, channel_and_programme_for_cost_data, by.x = 'CAMPAIGN_NAME', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
rm(channel_and_programme_for_cost_data)

# Channel Attribution  to Stage ----
cal_campaign_for_stage <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_campaign")
cal_campaign_for_stage$COHORT = NULL

stage$UTM_CAMPAIGN = tolower(stage$UTM_CAMPAIGN)
stage$GA_CAMPAIGN = tolower(stage$GA_CAMPAIGN)
stage$UTM_SOURCE = tolower(stage$UTM_SOURCE)
stage$GA_SOURCE = tolower(stage$GA_SOURCE)
stage$LEAD_SOURCE = tolower(stage$LEAD_SOURCE)
cal_campaign_for_stage$CAMPAIGN_NAME = tolower(cal_campaign_for_stage$CAMPAIGN_NAME)

stage = merge(stage, cal_campaign_for_stage, by.x = 'UTM_CAMPAIGN', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
stage <- stage %>% rename(UTM_CAMPAIGN_PROPER_CHANNEL = CHANNEL_AS_PER_CAMPAIGN_NAME, UTM_CAMPAIGN_PROPER_SUB_CHANNEL = SUB_CHANNEL_AS_PER_CAMPAIGN_NAME)

stage = merge(stage, cal_campaign_for_stage, by.x = 'GA_CAMPAIGN', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
stage <- stage %>% rename(GA_CAMPAIGN_PROPER_CHANNEL = CHANNEL_AS_PER_CAMPAIGN_NAME, GA_CAMPAIGN_PROPER_SUB_CHANNEL = SUB_CHANNEL_AS_PER_CAMPAIGN_NAME)

stage = merge(stage, cal_campaign_for_stage, by.x = 'UTM_SOURCE', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
stage <- stage %>% rename(UTM_SOURCE_PROPER_CHANNEL = CHANNEL_AS_PER_CAMPAIGN_NAME, UTM_SOURCE_PROPER_SUB_CHANNEL = SUB_CHANNEL_AS_PER_CAMPAIGN_NAME)

stage = merge(stage, cal_campaign_for_stage, by.x = 'GA_SOURCE', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
stage <- stage %>% rename(GA_SOURCE_PROPER_CHANNEL = CHANNEL_AS_PER_CAMPAIGN_NAME, GA_SOURCE_PROPER_SUB_CHANNEL = SUB_CHANNEL_AS_PER_CAMPAIGN_NAME)

stage = merge(stage, cal_campaign_for_stage, by.x = 'LEAD_SOURCE', by.y = 'CAMPAIGN_NAME', all.x = T, all.y = F)
stage <- stage %>% rename(LEAD_SOURCE_PROPER_CHANNEL = CHANNEL_AS_PER_CAMPAIGN_NAME, LEAD_SOURCE_PROPER_SUB_CHANNEL = SUB_CHANNEL_AS_PER_CAMPAIGN_NAME)

# Final stage Source Calculations
stage$FINAL_CHANNEL = ifelse(!is.na(stage$UTM_CAMPAIGN_PROPER_CHANNEL), as.character(stage$UTM_CAMPAIGN_PROPER_CHANNEL),
                             ifelse(!is.na(stage$UTM_SOURCE_PROPER_CHANNEL), as.character(stage$UTM_SOURCE_PROPER_CHANNEL),
                                    ifelse(!is.na(stage$GA_CAMPAIGN_PROPER_CHANNEL), as.character(stage$GA_CAMPAIGN_PROPER_CHANNEL),
                                           ifelse(!is.na(stage$GA_SOURCE_PROPER_CHANNEL), as.character(stage$GA_SOURCE_PROPER_CHANNEL),
                                                  ifelse(!is.na(stage$LEAD_SOURCE_PROPER_CHANNEL), as.character(stage$LEAD_SOURCE_PROPER_CHANNEL), "Other")))))

stage$FINAL_SUB_CHANNEL = ifelse(!is.na(stage$UTM_CAMPAIGN_PROPER_SUB_CHANNEL), as.character(stage$UTM_CAMPAIGN_PROPER_SUB_CHANNEL),
                                 ifelse(!is.na(stage$UTM_SOURCE_PROPER_SUB_CHANNEL), as.character(stage$UTM_SOURCE_PROPER_SUB_CHANNEL),
                                        ifelse(!is.na(stage$GA_CAMPAIGN_PROPER_SUB_CHANNEL), as.character(stage$GA_CAMPAIGN_PROPER_SUB_CHANNEL),
                                               ifelse(!is.na(stage$GA_SOURCE_PROPER_SUB_CHANNEL), as.character(stage$GA_SOURCE_PROPER_SUB_CHANNEL),
                                                      ifelse(!is.na(stage$LEAD_SOURCE_PROPER_SUB_CHANNEL), as.character(stage$LEAD_SOURCE_PROPER_SUB_CHANNEL), "Other_Unidentified")))))
rm(cal_campaign_for_stage)
stage[,c('GA_CAMPAIGN_PROPER_CHANNEL', 'GA_CAMPAIGN_PROPER_SUB_CHANNEL', 'GA_SOURCE_PROPER_CHANNEL', 'GA_SOURCE_PROPER_SUB_CHANNEL',
         'LEAD_SOURCE_PROPER_CHANNEL', 'LEAD_SOURCE_PROPER_SUB_CHANNEL', 'UTM_CAMPAIGN_PROPER_CHANNEL', 'UTM_CAMPAIGN_PROPER_SUB_CHANNEL',
         'UTM_SOURCE_PROPER_CHANNEL', 'UTM_SOURCE_PROPER_SUB_CHANNEL')] <- list(NULL)

# Lead Backup 4 ----
# lead_bk_after_channel_mapping <- lead
# stage_bk_after_channel_mapping <- stage

# Load comm_lp cost data ----
# ++++++++++ Script for calculating Common LP cost ++++++++++
#
#
#
# ++++++++++ Script for calculating Common LP cost ++++++++++
load(file = "D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_base_comm_lp.RData")
cost_data_comm_lp <- cost_lp_comm %>% select(-PROGRAMME, -leadcount) %>% 
  rename(COUNTRY = COUNTRY_PROPER, CHANNEL = FINAL_CHANNEL, SUB_CHANNEL = FINAL_SUB_CHANNEL, CLICKS = LINK_CLICKS, COST = AMOUNT, REGION = Region)

# Removeing Common LP cost from main cost base ----
comm_lp_cost_fb <- filter(cost_fb,str_detect(SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,'Comm_LP'))
comm_lp_cost_fb_common <- filter(cost_fb_common, str_detect(cost_fb_common$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME, 'Comm_LP'))
comm_lp_cost_gg <- filter(cost_gg, str_detect(cost_gg$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME, 'Comm_LP'))

save(comm_lp_cost_fb, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\5_common_lp_cost_from_cost_fb.RData")
save(comm_lp_cost_fb_common, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\5_common_lp_cost_from_cost_fb.RData")
save(comm_lp_cost_gg, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\5_common_lp_from_cost_gg.RData")
rm(comm_lp_cost_fb, comm_lp_cost_fb_common, comm_lp_cost_gg)

cost_fb <- filter(cost_fb,!str_detect(SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,'Comm_LP'))
cost_fb_common <- filter(cost_fb_common, !str_detect(cost_fb_common$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME, 'Comm_LP'))
cost_gg <- filter(cost_gg, !str_detect(cost_gg$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME, 'Comm_LP'))

# Removing B-0000 carousel spent from main cost base ----
cost_fb$sbtstr <- substr(cost_fb$CAMPAIGN_NAME, 1, 6)
cost_fb$check <- ifelse((cost_fb$sbtstr == "b-0000"),NA, "keep")
crsl_cost_in_cost_fb <- cost_fb[is.na(cost_fb$check),]
save(crsl_cost_in_cost_fb, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\5_crsl_cost_in_cost_fb.RData")
rm(crsl_cost_in_cost_fb)
cost_fb <- cost_fb[!is.na(cost_fb$check),]
cost_fb$sbtstr = NULL
cost_fb$check = NULL

# Always on Google Campaign calculation ----
cost_gg_alwon <- filter(cost_gg, str_detect(CAMPAIGN_NAME, 'b-365d'))
cost_gg <- filter(cost_gg, !str_detect(CAMPAIGN_NAME, 'b-365d'))
cost_gg_alwon_ext <- strsplit(cost_gg_alwon$CAMPAIGN_NAME, "_", 0)
cost_gg_alwon_splited <- data.frame(do.call(rbind, cost_gg_alwon_ext))
cost_gg_alwon <- cbind(cost_gg_alwon, cost_gg_alwon_splited)
names(cost_gg_alwon)[names(cost_gg_alwon)== "X5"] = "Short_Code"
cost_gg_alwon <- select(cost_gg_alwon, CAMPAIGN_NAME, ACCOUNT_NAME, DATE, IMPRESSIONS, LINK_CLICKS, AMOUNT_IN_USD, COUNTRY_PROPER, REGION, CHANNEL_AS_PER_CAMPAIGN_NAME, SUB_CHANNEL_AS_PER_CAMPAIGN_NAME, Short_Code)

rm(cost_gg_alwon_ext, cost_gg_alwon_splited)

batch_file <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
batch_file <- select(batch_file, COHORT, SHORT_CODE, LEAD_FLOW_START, PROGRAM_START)
batch_file$LEAD_FLOW_START <- as.Date(batch_file$LEAD_FLOW_START, origin = "1899-12-30")
batch_file$PROGRAM_START <- as.Date(batch_file$PROGRAM_START, origin = "1899-12-30")
date_table <- data.frame(day = (seq(as.Date('2016-01-01'), Sys.Date(), by = 1)))
date_table_BIG <- sqldf("select * from batch_file
                        cross join date_table
                        where (date_table.day >= batch_file.LEAD_FLOW_START and date_table.day <= batch_file.PROGRAM_START)
                        order by SHORT_CODE, LEAD_FLOW_START, PROGRAM_START, day")
date_table_BIG$SHORT_CODE <- tolower(date_table_BIG$SHORT_CODE)
date_table_BIG$comb <- paste0(date_table_BIG$day, date_table_BIG$SHORT_CODE)

cost_gg_alwon$comb <- paste0(cost_gg_alwon$DATE, cost_gg_alwon$Short_Code)
date_table_BIG <- select(date_table_BIG, comb, COHORT)

cost_gg_alwon <- merge(cost_gg_alwon, date_table_BIG, by.x = 'comb', by.y = 'comb', all.x = T, all.y = F)
cost_gg_alwon$comb <- NULL

cost_gg_alwon$Short_Code <- NULL
cost_gg <- rbind(cost_gg, cost_gg_alwon)
save(cost_gg_alwon, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\cost_gg_alwon.RData")
cost_gg_alwon <- select(cost_gg_alwon, DATE, CAMPAIGN_NAME, COHORT)
write.csv(cost_gg_alwon, paste0("D:\\Emeritus\\Reports\\Keyword Funnel report\\Keyword_cost_gg_alwon_base_", Sys.Date(),".csv"), row.names = F)

rm(cost_gg_alwon, batch_file, date_table, date_table_BIG)

# Saving cost objects ----
save(cost_fb, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\7_cost_fb.RData")
save(cost_gg, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\7_cost_gg.RData")
save(cost_li, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\7_cost_li.RData")
save(cost_gg, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\7_cost_gg.RData")
save(cost_af, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\7_cost_af.RData")
save(cost_fb_crsl, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\7_cost_fb_crsl.RData")
save(cost_fb_common, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\7_cost_fb_common.RData")

# save(cost_tw, file = "D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_tw.RData")
# save(cost_bg, file = "D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_bg.RData")
# save(cost_ra, file = "D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_ra.RData")
# save(cost_qr, file = "D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_qr.RData")

load(file = "D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_tw.RData")
load(file = "D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_bg.RData")
load(file = "D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_ra.RData")
load(file = "D:\\Emeritus\\Reports\\Automation\\R\\old_base_files\\cost_qr.RData")

# CONSO COST DATA ----
cost_data_fb <- aggregate(list(IMPRESSIONS=cost_fb$IMPRESSIONS, CLICKS=cost_fb$LINK_CLICKS, COST=cost_fb$AMOUNT),
                          by=list(DATE=cost_fb$DATE, CHANNEL=cost_fb$CHANNEL_AS_PER_CAMPAIGN_NAME, SUB_CHANNEL=cost_fb$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,
                                  COUNTRY=cost_fb$COUNTRY_PROPER, REGION=cost_fb$REGION, COHORT=cost_fb$COHORT), FUN=sum)
cost_data_li <- aggregate(list(IMPRESSIONS=cost_li$IMPRESSIONS, CLICKS=cost_li$LINK_CLICKS, COST=cost_li$AMOUNT_AFTER_DISCOUNT),
                          by=list(DATE=cost_li$DATE, CHANNEL=cost_li$CHANNEL_AS_PER_CAMPAIGN_NAME, SUB_CHANNEL=cost_li$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,
                                  COUNTRY=cost_li$COUNTRY_AS_PER_CAMPAIGN_NAME, REGION=cost_li$REGION, COHORT=cost_li$COHORT), FUN=sum)
cost_data_li_b4_discounting <- aggregate(list(IMPRESSIONS=cost_li$IMPRESSIONS, CLICKS=cost_li$LINK_CLICKS, COST=cost_li$AMOUNT),
                                         by=list(DATE=cost_li$DATE, CHANNEL=cost_li$CHANNEL_AS_PER_CAMPAIGN_NAME, SUB_CHANNEL=cost_li$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,
                                                 COUNTRY=cost_li$COUNTRY_AS_PER_CAMPAIGN_NAME, REGION=cost_li$REGION, COHORT=cost_li$COHORT), FUN=sum)
cost_data_gg <- aggregate(list(IMPRESSIONS=cost_gg$IMPRESSIONS, CLICKS=cost_gg$LINK_CLICKS, COST=cost_gg$AMOUNT_IN_USD),
                          by=list(DATE=cost_gg$DATE, CHANNEL=cost_gg$CHANNEL_AS_PER_CAMPAIGN_NAME, SUB_CHANNEL=cost_gg$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,
                                  COUNTRY=cost_gg$COUNTRY_PROPER, REGION=cost_gg$REGION, COHORT=cost_gg$COHORT), FUN=sum)
cost_data_af <- aggregate(list(IMPRESSIONS=cost_af$IMPRESSIONS, CLICKS=cost_af$LINK_CLICKS, COST=cost_af$AMOUNT),
                          by=list(DATE=cost_af$DATE, CHANNEL=cost_af$CHANNEL, SUB_CHANNEL=cost_af$SUB_CHANNEL,
                                  COUNTRY=cost_af$COUNTRY_PROPER, REGION=cost_af$REGION, COHORT=cost_af$COURSE), FUN=sum)
cost_data_fb_crsl <- aggregate(list(CLICKS=cost_fb_crsl$LINK_CLICKS, COST=cost_fb_crsl$AMOUNT),
                               by=list(DATE=cost_fb_crsl$DATE, CHANNEL=cost_fb_crsl$CHANNEL_AS_PER_CAMPAIGN_NAME, SUB_CHANNEL=cost_fb_crsl$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,
                                       COUNTRY=cost_fb_crsl$COUNTRY_PROPER, REGION=cost_fb_crsl$REGION, COHORT=cost_fb_crsl$COHORT), FUN=sum)
cost_data_fb_common <- aggregate(list(IMPRESSIONS=cost_fb_common$IMPRESSIONS, CLICKS=cost_fb_common$LINK_CLICKS, COST=cost_fb_common$AMOUNT),
                                 by=list(DATE=cost_fb_common$DATE, CHANNEL=cost_fb_common$CHANNEL_AS_PER_CAMPAIGN_NAME, SUB_CHANNEL=cost_fb_common$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,
                                         COUNTRY=cost_fb_common$COUNTRY_PROPER, REGION=cost_fb_common$REGION, COHORT=cost_fb_common$COHORT), FUN=sum)
cost_data_tw <- aggregate(list(IMPRESSIONS=cost_tw$IMPRESSIONS, CLICKS=cost_tw$LINK_CLICKS, COST=cost_tw$AMOUNT_IN_USD),
                          by=list(DATE=cost_tw$DATE, CHANNEL=cost_tw$CHANNEL_AS_PER_CAMPAIGN_NAME, SUB_CHANNEL=cost_tw$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,
                                  COUNTRY=cost_tw$COUNTRY_PROPER, REGION=cost_tw$REGION, COHORT=cost_tw$COHORT), FUN=sum)
cost_data_ra <- aggregate(list(IMPRESSIONS=cost_ra$IMPRESSIONS, CLICKS=cost_ra$LINK_CLICKS, COST=cost_ra$AMOUNT),
                          by=list(DATE=cost_ra$DATE, CHANNEL=cost_ra$CHANNEL_AS_PER_CAMPAIGN_NAME, SUB_CHANNEL=cost_ra$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,
                                  COUNTRY=cost_ra$COUNTRY_AS_PER_CAMPAIGN_NAME, REGION=cost_ra$REGION, COHORT=cost_ra$COHORT), FUN=sum)
cost_data_bg <- aggregate(list(IMPRESSIONS=cost_bg$IMPRESSIONS, CLICKS=cost_bg$LINK_CLICKS, COST=cost_bg$COST_IN_USD),
                          by=list(DATE=cost_bg$DATE, CHANNEL=cost_bg$CHANNEL_AS_PER_CAMPAIGN_NAME, SUB_CHANNEL=cost_bg$SUB_CHANNEL_AS_PER_CAMPAIGN_NAME,
                                  COUNTRY=cost_bg$COUNTRY_AS_PER_CAMPAIGN_NAME, REGION=cost_bg$REGION, COHORT=cost_bg$COHORT), FUN=sum)
cost_data_qr <- aggregate(list(IMPRESSIONS=cost_qr$IMPRESSIONS, CLICKS=cost_qr$LINK_CLICKS, COST=cost_qr$AMOUNT),
                          by=list(DATE=cost_qr$DATE, CHANNEL=cost_qr$CHANNEL, SUB_CHANNEL=cost_qr$SUB_CHANNEL,
                                  COUNTRY=cost_qr$COUNTRY_PROPER, REGION=cost_qr$REGION, COHORT=cost_qr$COURSE), FUN=sum)

cost_data_fb$DATA_SOURCE = "FB"
cost_data_li$DATA_SOURCE = "LI"
cost_data_li_b4_discounting$DATA_SOURCE = "LI"
cost_data_gg$DATA_SOURCE = "GG"
cost_data_tw$DATA_SOURCE = "TW"
cost_data_ra$DATA_SOURCE = "RA"
cost_data_bg$DATA_SOURCE = "BG"
cost_data_qr$DATA_SOURCE = "QR"
cost_data_af$DATA_SOURCE = "AF"
cost_data_fb_crsl$DATA_SOURCE = "FB_C"
cost_data_fb_common$DATA_SOURCE = "FB_Comm"
cost_data_fb_crsl$IMPRESSIONS = 0
cost_data_comm_lp$DATA_SOURCE = "Comm_LP"

save(cost_data_li_b4_discounting, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\7_cost_data_li_b4_discounting.RData")

cost <- rbind(cost_data_fb, cost_data_li, cost_data_gg, cost_data_tw, cost_data_ra, cost_data_bg, cost_data_qr, cost_data_af, cost_data_fb_crsl, cost_data_fb_common, cost_data_comm_lp)

rm(cost_fb, cost_gg, cost_af, cost_bg, cost_fb_crsl, cost_fb_common, cost_tw, cost_qr, cost_ra, cost_li, cost_lp_comm, cost_data_li_b4_discounting)
rm(cost_data_fb, cost_data_li, cost_data_gg, cost_data_tw, cost_data_ra, cost_data_bg, cost_data_qr, cost_data_af, cost_data_fb_crsl, cost_data_fb_common, cost_data_comm_lp)

# Remove 'All_Programme_B2B_Events_Test' from Cost ----
na_cost_cohort = cost[(cost$COHORT == "All_Program_B2B_Events_Test"),]
save(na_cost_cohort, file = paste0("D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\8_na_cost_cohort.RData"))
rm(na_cost_cohort)
cost = cost[(cost$COHORT != "All_Program_B2B_Events_Test"),]

# Corporate B2C apps working ----
corporate_B2C <- data.frame(ONLINE_APP_NAME=corporate_B2C$Online.Application.Name, PAID_APPS=corporate_B2C$Quantity, AMOUNT=corporate_B2C$Amount)
corporate_B2C$ONLINE_APP_NAME <- as.character(corporate_B2C$ONLINE_APP_NAME)
corp_app_name_split <- strsplit(corporate_B2C$ONLINE_APP_NAME, "/", 0)
splited_corp_app_name <- data.frame(do.call(rbind, corp_app_name_split))
corporate_B2C <- cbind(corporate_B2C, splited_corp_app_name$X3)
names(corporate_B2C)[names(corporate_B2C)=="splited_corp_app_name$X3"] = "BATCH_ID"

calendar <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
calendar <- data.frame(COHORT=calendar$COHORT, PROGRAM_TYPE=calendar$PROGRAM_TYPE, PROGRAM=calendar$PROGRAM, FY_Q=calendar$FY_Q_NO,
                       BATCH_ID=calendar$BATCH_ID, SCHOOL=calendar$SCHOOL, PROGRAM_FEE=calendar$PROGRAM_FEE)
corp_B2C <- merge(corporate_B2C, calendar, by.x = 'BATCH_ID', by.y = 'BATCH_ID', all.x = T, all.y = F)
save(corp_B2C, file = paste0("D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\7_corp_B2C.RData"))

na_corp_B2C <- corp_B2C[is.na(corp_B2C$COHORT),]
save(na_corp_B2C, file = paste0("D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\8_na_corp_B2C.RData"))
rm(na_corp_B2C)
corp_B2C <- corp_B2C[!is.na(corp_B2C$COHORT),]
save(corp_B2C, file = paste0("D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\corp_B2C.RData"))

corp_B2C_data_for_funnel <- data.frame(db_lead=corp_B2C$PAID_APPS, db_app=corp_B2C$PAID_APPS, db_paid_app=corp_B2C$PAID_APPS,
                                       db_revenue=corp_B2C$AMOUNT, db_cohort=corp_B2C$COHORT, db_program_type=corp_B2C$PROGRAM_TYPE,
                                       db_program=corp_B2C$PROGRAM, db_FY_Q=corp_B2C$FY_Q, db_school=corp_B2C$SCHOOL, db_program_fee=corp_B2C$PROGRAM_FEE)
corp_B2C_data_for_funnel <- corp_B2C_data_for_funnel %>%
  mutate(db_category = "Corporate", db_channel = "Corp_Apps", db_sub_channel = "Corp_B2C", db_country = "All/Unknown", db_region = "All/Unknown",
         db_imp = 0, db_clicks = 0, db_cost = 0, db_deferred = "New")

rm(corporate_B2C, corp_app_name_split, splited_corp_app_name, calendar)

# Joining Cal_Master ----
# Lead
cal_calendar <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
cal_batch_id_and_status_for_lead = data.frame(BATCH_ID=cal_calendar$BATCH_ID, BATCH_STATUS=cal_calendar$ACTIVE, COHORT=cal_calendar$COHORT,
                                              PROGRAM_TYPE=cal_calendar$PROGRAM_TYPE, FY_Q=cal_calendar$FY_Q_NO, FY=cal_calendar$FY,
                                              MKT_START=cal_calendar$MKT_START, SCHOOL=cal_calendar$SCHOOL, PROGRAM_FEE=cal_calendar$PROGRAM_FEE)
cal_batch_id_and_status_for_lead$BATCH_ID = tolower(cal_batch_id_and_status_for_lead$BATCH_ID)
lead$BATCH_ID = tolower(lead$BATCH_ID)
lead = merge(lead, cal_batch_id_and_status_for_lead, by.x = 'BATCH_ID', by.y = 'BATCH_ID', all.x = T, all.y = F)
lead$MKT_START = as.Date(lead$MKT_START, origin = "1899-12-30")
lead$BATCH_ID = toupper(lead$BATCH_ID)
rm(cal_batch_id_and_status_for_lead)

# Stage
cal_batch_id_and_status_for_stage = data.frame(BATCH_ID=cal_calendar$BATCH_ID, COHORT=cal_calendar$COHORT, BATCH_STATUS=cal_calendar$ACTIVE,
                                               PROGRAM_TYPE=cal_calendar$PROGRAM_TYPE, FY_Q=cal_calendar$FY_Q_NO, FY=cal_calendar$FY,
                                               MKT_START=cal_calendar$MKT_START, PROGRAM_FEE=cal_calendar$PROGRAM_FEE, SCHOOL=cal_calendar$SCHOOL)
stage = merge(stage, cal_batch_id_and_status_for_stage, by.x = 'BATCH_ID', by.y = 'BATCH_ID', all.x = T, all.y = F)
stage$MKT_START <- as.Date(stage$MKT_START, origin = "1899-12-30")
rm(cal_batch_id_and_status_for_stage)

# Cost
prog_type_for_cost = data.frame(COHORT=cal_calendar$COHORT, PROGRAM_TYPE=cal_calendar$PROGRAM_TYPE, PROGRAM=cal_calendar$PROGRAM,
                                FY_Q_NO=cal_calendar$FY_Q_NO, PROGRAM_FEE=cal_calendar$PROGRAM_FEE, SCHOOL=cal_calendar$SCHOOL)
cost = merge(cost, prog_type_for_cost, by.x = 'COHORT', by.y = 'COHORT', all.x = T, all.y = F)
rm(prog_type_for_cost)

# Funnel dataframe LEAD ----
lead_data_for_funnel <- lead %>%
  filter(IC_ACTIVE_STATUS == 1) %>%
  select(db_channel=FINAL_CHANNEL, db_sub_channel=FINAL_SUB_CHANNEL, db_country=COUNTRY_PROPER, db_program=PROGRAM,
         db_cohort=COHORT, db_program_type=PROGRAM_TYPE, db_FY_Q=FY_Q, db_region=REGION, db_school=SCHOOL) %>%
  group_by_all() %>%
  tally(name = "db_lead") %>%
  mutate(db_category = "Lead", db_imp = 0, db_clicks = 0, db_cost = 0, db_app = 0, db_paid_app = 0, db_revenue = 0, db_deferred = "New", db_program_fee = 0)

# Funnel dataframe STAGE ----
stage_data_for_funnel <- aggregate(list(db_app=stage$APP, db_paid_app=stage$PAID_APP, db_revenue=stage$REVENUE),
                                   by = list(db_channel=stage$FINAL_CHANNEL, db_sub_channel=stage$FINAL_SUB_CHANNEL,
                                             db_country=stage$COUNTRY_PROPER, db_program=stage$PROGRAM, db_cohort=stage$COHORT,
                                             db_program_type=stage$PROGRAM_TYPE, db_deferred=stage$DEFERRED, db_FY_Q=stage$FY_Q, db_school=stage$SCHOOL,
                                             db_program_fee=stage$PROGRAM_FEE, db_region=stage$REGION), FUN = sum, na.rm = TRUE)
stage_data_for_funnel <- stage_data_for_funnel %>%
  mutate(db_category = "Stage", db_imp = 0, db_clicks = 0, db_lead = 0, db_cost = 0)

# FUNNEL dataframe COST ----
cost_data_for_funnel <- aggregate(list(db_imp=cost$IMPRESSIONS, db_clicks=cost$CLICKS, db_cost=cost$COST),
                                  by=list(db_category=cost$DATA_SOURCE,  db_channel=cost$CHANNEL, db_sub_channel=cost$SUB_CHANNEL,
                                          db_country=cost$COUNTRY, db_region=cost$REGION, db_cohort=cost$COHORT, db_program=cost$PROGRAM,
                                          db_program_type=cost$PROGRAM_TYPE, db_FY_Q=cost$FY_Q_NO, db_school=cost$SCHOOL, db_program_fee=cost$PROGRAM_FEE), FUN=sum)
cost_data_for_funnel <- cost_data_for_funnel %>%
  mutate(db_lead = 0, db_app = 0, db_paid_app = 0, db_revenue = 0, db_deferred = "New")

# # FUNNEL DF - ALL ----
extract_for_funnel = rbind(lead_data_for_funnel, cost_data_for_funnel, stage_data_for_funnel, corp_B2C_data_for_funnel)
extract_for_funnel$db_revenue_as_per_fees <- extract_for_funnel$db_paid_app * extract_for_funnel$db_program_fee
extract_for_funnel$db_program_fee = NULL
cal_calendar_add <- select(cal_calendar, COHORT, db_mkt_days_left=MKT_DAYS_LEFT)
extract_for_funnel <- merge(extract_for_funnel, cal_calendar_add, by.x = 'db_cohort', by.y = 'COHORT', all.x = T, all.y = F)
funnel_col_order <- c("db_category", "db_channel", "db_sub_channel", "db_school", "db_program_type", "db_program", "db_cohort", "db_country", "db_region",
                      "db_FY_Q", "db_imp", "db_clicks", "db_lead", "db_app", "db_paid_app", "db_cost", "db_revenue", "db_deferred", "db_revenue_as_per_fees", "db_mkt_days_left")
extract_for_funnel <- extract_for_funnel[, funnel_col_order]
write.csv(extract_for_funnel, paste0("C:\\Users\\yogesh.alkari\\Downloads\\extract_for_funnel_", Sys.Date(),".csv"), row.names=F)

cal_calendar_add <- select(cal_calendar, SR_NO, SHORT_CODE, BATCH_ID, COHORT, PROGRAM, SCHOOL, MKT_START, PROGRAM_START, LEAD_FLOW_START, LEAD_FLOW_END, FY_Q_NO, ACTIVE, DAYS_MKT_START, MKT_DAYS_LEFT)
write.csv(cal_calendar_add, paste0("C:\\Users\\yogesh.alkari\\Downloads\\extract_cal_calendar_add_", Sys.Date(),".csv"), row.names=F)

# Performance Analysis Report Power BI ----
PAR_lead_cpl = sqldf("select FINAL_CHANNEL as Channel, COUNTRY_PROPER as Country, COHORT as Cohort, sum(IC_ACTIVE_STATUS) as Lead_Count, 0 as Cost
                     from lead
                     where IC_ACTIVE_STATUS in ('1')
                     group by FINAL_CHANNEL, COUNTRY_PROPER, COHORT")

PAR_cost_cpl <- sqldf("select CHANNEL as Channel, COUNTRY as Country, COHORT as Cohort, sum(COST) as Cost, 0 as Lead_Count
                      from cost
                      group by CHANNEL, COUNTRY, COHORT")
PAR_lead_and_cost = rbind(PAR_lead_cpl, PAR_cost_cpl)

PAR_lead_with_cpl = sqldf("select Channel, Country, Cohort, sum(Lead_Count) Lead_Count, sum(Cost) Cost from PAR_lead_and_cost group by Channel, Country, Cohort")
PAR_lead_with_cpl$CPL = PAR_lead_with_cpl$Cost / PAR_lead_with_cpl$Lead_Count
PAR_lead_with_cpl <- PAR_lead_with_cpl[!is.na(PAR_lead_with_cpl$CPL),]
PAR_lead_with_cpl_inf <- PAR_lead_with_cpl[is.infinite(PAR_lead_with_cpl$CPL),]
PAR_lead_with_cpl_inf <- PAR_lead_with_cpl_inf[(PAR_lead_with_cpl_inf$Cost >= 100),]
PAR_lead_with_cpl_inf$Lead_Count = 1
PAR_lead_with_cpl_inf$CPL <- NULL
PAR_lead_with_cpl_inf$Cost = 0

PAR_lead_cpl <- rbind(PAR_lead_cpl, PAR_lead_with_cpl_inf)
PAR_lead_cpl$Cost = 0
PAR_lead_and_cost = rbind(PAR_lead_cpl, PAR_cost_cpl)

PAR_lead_with_cpl = sqldf("select Channel, Country, Cohort, sum(Lead_Count) Lead_Count, sum(Cost) Cost from PAR_lead_and_cost group by Channel, Country, Cohort")
PAR_lead_with_cpl$CPL = PAR_lead_with_cpl$Cost / PAR_lead_with_cpl$Lead_Count
PAR_lead_with_cpl <- PAR_lead_with_cpl[!is.na(PAR_lead_with_cpl$CPL),]
PAR_lead_with_cpl$conca = paste0(PAR_lead_with_cpl$Channel, PAR_lead_with_cpl$Country, PAR_lead_with_cpl$Cohort)

PAR_lead_with_cpl_inf$Cost <- NULL
PAR_lead_with_cpl_inf$Work_Exp <- "1-5 yrs"

# Applying CPL alongwith work experience
PAR_lead_base <- sqldf("select FINAL_CHANNEL as Channel, COUNTRY_PROPER as Country, COHORT as Cohort, sum(IC_ACTIVE_STATUS) as Lead_Count, WORK_EX_SLAB as Work_Exp
                       from lead
                       where IC_ACTIVE_STATUS in ('1')
                       group by FINAL_CHANNEL, COUNTRY_PROPER, COHORT, WORK_EX_SLAB")
PAR_lead_base <- rbind(PAR_lead_base, PAR_lead_with_cpl_inf)

PAR_lead_base$conca = paste0(PAR_lead_base$Channel, PAR_lead_base$Country, PAR_lead_base$Cohort)
PAR_lead = merge(PAR_lead_base, PAR_lead_with_cpl[,c("conca", "CPL")], by.x = 'conca', by.y = 'conca', all.x = T, all.y = F)
PAR_lead$Cost = PAR_lead$Lead * PAR_lead$CPL
PAR_lead$conca = NULL
PAR_lead$CPL = NULL
PAR_lead$Apps = 0
PAR_lead$Paid_Apps = 0
PAR_lead$Revenue = 0
PAR_lead$Gender <- NA
PAR_lead$Income <- NA
PAR_lead$Function <- NA
PAR_lead$Industry <- NA
PAR_lead$Job_Title <- NA

PAR_stage_base = sqldf("select FINAL_CHANNEL Channel, COUNTRY_PROPER Country, COHORT Cohort, sum(APP) Apps, sum(PAID_APP) Paid_Apps,
                       WORK_EX_SLAB Work_Exp, GENDER Gender, INCOME_SLAB Income, FUNCTION Function, INDUSTRY Industry, JOB_TITLE Job_Title,
                       sum(REVENUE) Revenue, 0 as Lead_Count, 0 as Cost
                       from stage
                       group by FINAL_CHANNEL, COUNTRY_PROPER, COHORT, WORK_EX_SLAB, GENDER, INCOME_SLAB, FUNCTION, INDUSTRY, JOB_TITLE")
PAR_base_data = rbind(PAR_lead, PAR_stage_base)

Calendar <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
Calendar <- select(Calendar, COHORT, PROGRAM, PROGRAM_TYPE, SCHOOL, MKT_START, PROGRAM_START, LEAD_FLOW_START, LEAD_FLOW_END, FY_Q_NO, ACTIVE, SR_NO, CATEGORY)
Calendar <- Calendar %>% rename(Cohort = COHORT,
                                Program = PROGRAM,
                                Program_Type = PROGRAM_TYPE,
                                School = SCHOOL,
                                Mkt_Start_Date = MKT_START,
                                Program_Start_Date = PROGRAM_START,
                                Lead_Flow_Start_Date = LEAD_FLOW_START,
                                Lead_Flow_End_Date = LEAD_FLOW_END,
                                FY_Q = FY_Q_NO,
                                Batch_Active = ACTIVE,
                                Sr_No = SR_NO,
                                Category = CATEGORY)

Calendar$Mkt_Start_Date <- as.Date(Calendar$Mkt_Start_Date, origin = "1899-12-30")
Calendar$Program_Start_Date <- as.Date(Calendar$Program_Start_Date, origin = "1899-12-30")
Calendar$Lead_Flow_Start_Date <- as.Date(Calendar$Lead_Flow_Start_Date, origin = "1899-12-30")
Calendar$Lead_Flow_End_Date <- as.Date(Calendar$Lead_Flow_End_Date, origin = "1899-12-30")
Country_Base <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country")
Country_Base <- data.frame(COUNTRY_PROPER=Country_Base$COUNTRY_PROPER, Region=Country_Base$REGION)
Country_Base <- unique(Country_Base)
PAR_base_data <- merge(PAR_base_data, Calendar, by.x = 'Cohort', by.y = 'Cohort', all.x = T, all.y = F)
PAR_base_data <- merge(PAR_base_data, Country_Base, by.x = 'Country', by.y = 'COUNTRY_PROPER', all.x = T, all.y = F)
PAR_base_data <- filter(PAR_base_data, !str_detect(PAR_base_data$FY_Q, '^FY15') & !str_detect(PAR_base_data$FY_Q, '^FY16') & !str_detect(PAR_base_data$FY_Q, '^FY17'))

save(PAR_base_data, file = "D:\\Emeritus\\Reports\\Automation\\Power BI\\Performance Analysis Report\\base_file\\PAR_base_data.RData")
save(PAR_base_data, file = "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Analytics Core Team - Shared Folder\\PowerBI_RObjects\\PAR_base_data.RData")

rm(Calendar, Country_Base, PAR_base_data, PAR_cost_cpl, PAR_lead, PAR_lead_and_cost, PAR_lead_base, PAR_lead_cpl, PAR_lead_with_cpl, PAR_lead_with_cpl_inf, PAR_stage_base)

# TAR with Country and Channel Power BI  ----
# Lead
L_base <- data.frame(DATE_IC=lead$IC_CREATED_DATE, Course=lead$COHORT, IC_STATUS=lead$IC_ACTIVE_STATUS, Channel=lead$FINAL_CHANNEL, Country=lead$COUNTRY_PROPER) # 1
L_base <- subset(L_base, IC_STATUS >0, select = c(DATE_IC, Course, Channel, Country)) # 1
L_base$Lead <- 1
L_base <- sqldf("select DATE_IC, Course, Channel, Country, sum(Lead) Lead from L_base group by DATE_IC, Course, Channel, Country") # Group by 1

# Stage App
S_base_App <- data.frame(Date=stage$APP_CREATED_DATE, Course=stage$COHORT, App=stage$APP, Deferred=stage$DEFERRED, Channel=stage$FINAL_CHANNEL, Country=stage$COUNTRY_PROPER) # 3
S_base_App = sqldf("select Date, Course, Deferred, Channel, Country, sum(App) App from S_base_App group by Date, Course, Deferred, Channel, Country") # Group by 3

# Stage Paid App
S_base_Paid_App <- data.frame(Date=stage$LAST_STAGE_CHANGE_DATE, Course=stage$COHORT, Country=stage$COUNTRY_PROPER, Paid_App=stage$PAID_APP,
                              Deferred=stage$DEFERRED, Revenue=stage$REVENUE, Channel=stage$FINAL_CHANNEL)
S_base_Paid_App <- S_base_Paid_App[(S_base_Paid_App$Paid_App == 1),]
S_base_Paid_App <- sqldf("select Date, Course, Deferred, Channel, Country, sum(Paid_App) Paid_App, sum(Revenue) Revenue
                         from S_base_Paid_App group by Date, Course, Deferred, Channel, Country")
# Cost
C_base = sqldf("select COHORT as Course, CHANNEL as Channel, COUNTRY as Country, sum(COST) Cost, DATE from cost group by COHORT, DATE, CHANNEL, COUNTRY")
names(C_base)[names(C_base) == "DATE"] <- "Date"

FY_base_data <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
FY_base_data = data.frame(Course=FY_base_data$COHORT, Req_Cohort=FY_base_data$ACH_REP)

L_base <- merge(L_base, FY_base_data, by.x = 'Course', by.y = 'Course', all.x = T, all.y = F)
S_base_App <- merge(S_base_App, FY_base_data, by.x = 'Course', by.y = 'Course', all.x = T, all.y = F)
S_base_Paid_App <- merge(S_base_Paid_App, FY_base_data, by.x = 'Course', by.y = 'Course', all.x = T, all.y = F)
C_base <- merge(C_base, FY_base_data, by.x = 'Course', by.y = 'Course', all.x = T, all.y = F)

L_base <- L_base[(L_base$Req_Cohort == 1),]
S_base_App <- S_base_App[(S_base_App$Req_Cohort == 1),]
S_base_Paid_App <- S_base_Paid_App[(S_base_Paid_App$Req_Cohort == 1),]
C_base <- C_base[(C_base$Req_Cohort == 1),]
C_base <- C_base[!is.na(C_base$Course),]

names(L_base)[names(L_base)=="DATE_IC"]="Date"
C_base$new_val <- ifelse((C_base$Cost > 0 | C_base$Cost < 1), round(C_base$Cost, digits = 0), C_base$Cost)
C_base$Cost = NULL
names(C_base)[names(C_base)=="new_val"]="Cost"

C_base <- aggregate(list(Cost=C_base$Cost), by=list(Date=C_base$Date, Course=C_base$Course, Channel=C_base$Channel, Country=C_base$Country), FUN=sum)
C_base <- C_base[(C_base$Cost >= 1),]

L_base$Req_Cohort <- NULL
S_base_App$Req_Cohort = NULL
S_base_Paid_App$Req_Cohort = NULL
C_base$Req_Cohort = NULL

L_base$App = 0
L_base$Paid_App = 0
L_base$Revenue = 0
L_base$Cost = 0
S_base_App$Lead = 0
S_base_App$Paid_App = 0
S_base_App$Revenue = 0
S_base_App$Cost = 0
S_base_Paid_App$Lead = 0
S_base_Paid_App$App = 0
S_base_Paid_App$Cost = 0
C_base$Lead = 0
C_base$App = 0
C_base$Paid_App = 0
C_base$Revenue = 0
L_base$Deferred = "New"
C_base$Deferred = "New"

Ach_base <- rbind(L_base, C_base, S_base_App, S_base_Paid_App)

Ach_base$Channel_rev <- ifelse((Ach_base$Channel == "Facebook" | Ach_base$Channel == "Instagram"), "Facebook",
                               ifelse((Ach_base$Channel == "Linkedin"), "Linkedin",
                                      ifelse((Ach_base$Channel == "Google"), "Google",
                                             ifelse((Ach_base$Channel == "Affiliate"), "Affiliate",
                                                    ifelse((Ach_base$Channel == "Bing"), "Other-Paid", "Other-Non Paid")))))

Ach_base <- aggregate(list(Lead=Ach_base$Lead, App=Ach_base$App, Paid_App=Ach_base$Paid_App, Revenue=Ach_base$Revenue, Cost=Ach_base$Cost),
                      by=list(Date=Ach_base$Date, Course=Ach_base$Course, Deferred=Ach_base$Deferred, Channel=Ach_base$Channel_rev, Country=Ach_base$Country), FUN=sum)
Ach_base <- Ach_base %>% rename(Cohort = Course)
Ach_base_backup_after_agg <- Ach_base
FY_base_data <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
FY_base_data = data.frame(Cohort=FY_base_data$COHORT, Mkt_Start=FY_base_data$MKT_START, Prog_Start=FY_base_data$PROGRAM_START,
                          Program=FY_base_data$PROGRAM, Program_Type=FY_base_data$PROGRAM_TYPE, Sr_No=FY_base_data$SR_NO, School=FY_base_data$SCHOOL)
Ach_base <- merge(Ach_base, FY_base_data, by.x = 'Cohort', by.y = 'Cohort', all.x = T, all.y = F)
Ach_base$Mkt_Start <- as.Date(Ach_base$Mkt_Start, origin = "1899-12-30")
Ach_base$Prog_Start <- as.Date(Ach_base$Prog_Start, origin = "1899-12-30")
Ach_base$LEAD_FLOW_END_DATE <- Ach_base$Prog_Start + 7
Ach_base$Date_Rev <- if_else(Ach_base$Date <= Ach_base$Mkt_Start, Ach_base$Mkt_Start,
                             if_else(Ach_base$Date >= Ach_base$LEAD_FLOW_END_DATE, Ach_base$LEAD_FLOW_END_DATE, Ach_base$Date))
Ach_base$Mkt_Day <- Ach_base$Prog_Start - Ach_base$Date_Rev
Ach_base$Date = NULL
Ach_base <- Ach_base %>% rename(Date = Date_Rev)
Ach_base$Prog_Start <- NULL
Ach_base$Mkt_Start = NULL
Ach_base$LEAD_FLOW_END_DATE = NULL
Ach_base <- Ach_base[order(Ach_base$Date),]
Ach_base$Mkt_Day <- as.numeric(Ach_base$Mkt_Day)
Region_working <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country")
Region_working <- data.frame(Country=Region_working$COUNTRY_PROPER, Region=Region_working$REGION)
Region_working <- unique(Region_working)
Ach_base <- merge(Ach_base, Region_working, by.x = 'Country', by.y = 'Country', all.x = T, all.y = F)
rm(Region_working, FY_base_data)

na_Ach_base <- Ach_base[is.na(Ach_base$Region),]
Ach_base <- Ach_base[!is.na(Ach_base$Region),]

save(Ach_base, file = "D:\\Emeritus\\Reports\\Automation\\Power BI\\Trend Analysis Report\\base_file\\TAR_base.RData")
save(Ach_base, file = "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Analytics Core Team - Shared Folder\\PowerBI_RObjects\\TAR_base.RData")

# Last Cohort Same Day report for Outreach team ----
CPPA_Trend_base_PA <- rbind(L_base, S_base_App, S_base_Paid_App)
CPPA_Trend_base_PA <- aggregate(list(Lead=CPPA_Trend_base_PA$Lead, App=CPPA_Trend_base_PA$App, Paid_App=CPPA_Trend_base_PA$Paid_App),
                                by=list(Date=CPPA_Trend_base_PA$Date, Course=CPPA_Trend_base_PA$Course, Deferred=CPPA_Trend_base_PA$Deferred), FUN=sum)
FY_base_data <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
FY_base_data <- data.frame(Course=FY_base_data$COHORT, FY=FY_base_data$FY)
CPPA_Trend_base_PA <- merge(CPPA_Trend_base_PA, FY_base_data, by.x = 'Course', by.y = 'Course', all.x = T, all.y = F)
CPPA_Trend_base_PA <- subset(CPPA_Trend_base_PA, FY =='FY18-19' | FY =='FY19-20' , select = c(Date, Course, Lead, App, Paid_App, Deferred))
CPPA_Trend_base_PA$sum <- CPPA_Trend_base_PA$Lead + CPPA_Trend_base_PA$App + CPPA_Trend_base_PA$Paid_App
CPPA_Trend_base_PA <- CPPA_Trend_base_PA %>% arrange(CPPA_Trend_base_PA$Date)
write.csv(CPPA_Trend_base_PA, file = paste0("C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Mohsin Belim - Last_Cohort_Same_Day_Base_Data_From_Mkt\\extract_Trend_Analysis_base_PA.csv"), row.names=F)

rm(L_base, C_base, S_base_App, S_base_Paid_App, Ach_base_backup_after_agg, FY_base_data, Ach_base, CPPA_Trend_base_PA, na_Ach_base)

# LSR with Channel Power BI ----
# Lead
lsr_lead <- data.frame(LEAD_OWNER=lead$LEAD_OWNER, LEAD_RATING=lead$RATING, COURSE=lead$COHORT, COUNTRY=lead$COUNTRY_PROPER,
                       PROGRAM_TYPE=lead$PROGRAM_TYPE,FY=lead$FY, IC_STATUS=lead$IC_ACTIVE_STATUS, REGION=lead$REGION,
                       CHANNEL=lead$FINAL_CHANNEL, SUB_CHANNEL=lead$FINAL_SUB_CHANNEL)
lsr_lead <- lsr_lead[!(lsr_lead$IC_STATUS == 0),]
lsr_lead <- lsr_lead[!(lsr_lead$FY == "FY15-16"),]
lsr_lead <- lsr_lead[!(lsr_lead$FY == "FY16-17"),]
lsr_lead$FY = NULL
lsr_lead$IC_STATUS = NULL

# Lead Rating spliting
lsr_lead$LEAD_RATING_LEVEL <- ifelse(lsr_lead$LEAD_RATING == "Open",1,
                                     ifelse(lsr_lead$LEAD_RATING == "Unreachable 1",2,
                                            ifelse(lsr_lead$LEAD_RATING == "Unreachable 2",3,
                                                   ifelse(lsr_lead$LEAD_RATING == "Dead", 4,
                                                          ifelse(lsr_lead$LEAD_RATING == "Callback",5,
                                                                 ifelse(lsr_lead$LEAD_RATING == "Hot",6,
                                                                        ifelse(lsr_lead$LEAD_RATING == "Warm",7,
                                                                               ifelse(lsr_lead$LEAD_RATING == "Cold",8,
                                                                                      ifelse(lsr_lead$LEAD_RATING == "Working on App",9,
                                                                                             ifelse(lsr_lead$LEAD_RATING == "Applied",10,11))))))))))
levels <- unique(lsr_lead$LEAD_RATING_LEVEL)
levels <-sort(levels)
# Consider last level  as reference category
for( i in 1:(length(levels)) ){
  colName <- paste("Rating",levels[i],sep="_")
  lsr_lead[,colName] <- ifelse(lsr_lead$LEAD_RATING_LEVEL==levels[i],1,0)
}
lsr_lead$LEAD_RATING_LEVEL = NULL

lsr_agg_lead <- aggregate(x = lsr_lead[c("Rating_1","Rating_2","Rating_3","Rating_4","Rating_5","Rating_6","Rating_7","Rating_8","Rating_9","Rating_10")],
                          by = lsr_lead[c("LEAD_OWNER","COURSE","COUNTRY","PROGRAM_TYPE", "REGION", "CHANNEL", "SUB_CHANNEL")], FUN = sum)

names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_1"]="Open"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_2"]="UR_1"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_3"]="UR_2"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_4"]="Dead"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_5"]="Callback"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_6"]="Hot"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_7"]="Warm"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_8"]="Cold"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_9"]="Working_on_App"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_10"]="Applied"

lsr_agg_lead$App = 0
lsr_agg_lead$Paid_App = 0
lsr_agg_lead$Total_Leads <- rowSums(lsr_agg_lead[, c("Open","UR_1","UR_2","Dead","Callback","Hot","Warm","Cold","Working_on_App","Applied")], na.rm = FALSE)

# Stage
lsr_stage <- data.frame(LEAD_OWNER=stage$LEAD_OWNER, COURSE=stage$COHORT, COUNTRY=stage$COUNTRY_PROPER, PROGRAM_TYPE=stage$PROGRAM_TYPE,
                        App=stage$APP, Paid_App=stage$PAID_APP, FY=stage$FY, REGION=stage$REGION, CHANNEL=stage$FINAL_CHANNEL, SUB_CHANNEL=stage$FINAL_SUB_CHANNEL)
lsr_stage <- lsr_stage[!(lsr_stage$FY == "FY15-16"),]
lsr_stage <- lsr_stage[!(lsr_stage$FY == "FY16-17"),]

lsr_agg_stage <- aggregate(x = lsr_stage[c("App", "Paid_App")],
                           by = lsr_stage[c("LEAD_OWNER","COURSE","COUNTRY","PROGRAM_TYPE","REGION", "CHANNEL", "SUB_CHANNEL")],
                           FUN = sum)
lsr_agg_stage$Open = 0
lsr_agg_stage$UR_1 = 0
lsr_agg_stage$UR_2 = 0
lsr_agg_stage$Dead = 0
lsr_agg_stage$Callback = 0
lsr_agg_stage$Hot = 0
lsr_agg_stage$Warm = 0
lsr_agg_stage$Cold = 0
lsr_agg_stage$Working_on_App = 0
lsr_agg_stage$Applied = 0
lsr_agg_stage$Total_Leads = 0

lsr_base = rbind(lsr_agg_lead, lsr_agg_stage)
rm(lsr_lead, lsr_agg_lead, lsr_stage, lsr_agg_stage)

daily_cal_master <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
new_columns <- data.frame(batch_id=daily_cal_master$COHORT, Batch_Status=daily_cal_master$ACTIVE,
                          Programme_Code=daily_cal_master$PROGRAM, Sr_No=daily_cal_master$SR_NO, Ach_Req=daily_cal_master$ACH_REP)
lsr_base = merge(lsr_base, new_columns, by.x = 'COURSE', by.y = 'batch_id', all.x = T, all.y = F)
lsr_base$Batch_Status = ifelse(lsr_base$Batch_Status == 1, "Active", "Inactive")
lsr_base <- lsr_base[(lsr_base$Ach_Req == 1),]
lsr_base <- lsr_base %>% rename(PROGRAMME_TYPE = PROGRAM_TYPE)

save(lsr_base, file = "D:\\Emeritus\\Reports\\Automation\\Power BI\\Lead Status Report\\base_file\\lsr_base_with_channel_object.RData")
save(lsr_base, file = "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Analytics Core Team - Shared Folder\\PowerBI_RObjects\\lsr_base_with_channel_object.RData")

rm(new_columns, lsr_base, i, colName, levels)

# Google Keyword Funnel report ----
# Lead
keyword_lead_base <- data.frame(utm_term=lead$UTM_TERM, cohort=lead$COHORT, ic_status=lead$IC_ACTIVE_STATUS,
                                utm_campaign=lead$UTM_CAMPAIGN, channel=lead$FINAL_CHANNEL, fy=lead$FY_Q, lead=lead$LEAD_COUNT)
keyword_lead_base<- filter(keyword_lead_base, keyword_lead_base$ic_status == '1' & keyword_lead_base$channel == "Google"
                           & (keyword_lead_base$fy == 'FY20 Q4'))
# Stage
keyword_stage_base <- data.frame(utm_term=stage$UTM_TERM, cohort=stage$COHORT, utm_campaign=stage$UTM_CAMPAIGN, channel=stage$FINAL_CHANNEL,
                                 fy=stage$FY_Q, app=stage$APP, paid_app=stage$PAID_APP, revenue=stage$REVENUE)
keyword_stage_base <- filter(keyword_stage_base, keyword_stage_base$channel == "Google" & keyword_stage_base$fy == 'FY20 Q4')

keyword_lead_base$fy = NULL
keyword_lead_base$channel = NULL
keyword_lead_base$ic_status = NULL
keyword_stage_base$fy <- NULL
keyword_stage_base$channel <- NULL

lead_and_stage_base <- createWorkbook()
addWorksheet(lead_and_stage_base, "lead")
addWorksheet(lead_and_stage_base, "stage")
writeData(lead_and_stage_base, sheet = "lead", x = keyword_lead_base)
writeData(lead_and_stage_base, sheet = "stage", x = keyword_stage_base)
saveWorkbook(lead_and_stage_base, paste0("D:\\Emeritus\\Reports\\Keyword Funnel report\\Keyword_lead_and_stage_base_", Sys.Date(),".xlsx"), overwrite = T)

rm(keyword_lead_base, keyword_stage_base, lead_and_stage_base)



# Facebook Campaign Funnel Report ----
CPR_lead <- lead %>%
  filter(IC_ACTIVE_STATUS == 1 & FINAL_CHANNEL == 'Facebook' & (FY_Q == 'FY20 Q3' | FY_Q == 'FY20 Q4'| FY_Q == 'FY21 Q1')) %>%
  select(UTM_CAMPAIGN, UTM_MEDIUM, UTM_CONTENT, COUNTRY_PROPER, COHORT) %>%
  group_by_all() %>%
  tally(name = "LEAD_COUNT")

CPR_stage <- stage %>%
  filter(FINAL_CHANNEL == 'Facebook' & (FY_Q == 'FY20 Q3' | FY_Q == 'FY20 Q4'| FY_Q == 'FY21 Q1')) %>%
  select(UTM_CAMPAIGN, UTM_MEDIUM, UTM_CONTENT, COUNTRY_PROPER, COHORT, APP, PAID_APP, REVENUE) %>%
  group_by(UTM_CAMPAIGN, UTM_MEDIUM, UTM_CONTENT, COUNTRY_PROPER, COHORT) %>%
  summarise(APP = sum(APP), PAID_APP = sum(PAID_APP), REVENUE = sum(REVENUE))

lead_and_stage_base <- createWorkbook()
addWorksheet(lead_and_stage_base, "lead")
addWorksheet(lead_and_stage_base, "stage")
writeData(lead_and_stage_base, sheet = "lead", x = CPR_lead)
writeData(lead_and_stage_base, sheet = "stage", x = CPR_stage)

saveWorkbook(lead_and_stage_base, paste0("D:\\Emeritus\\Reports\\Automation\\Power BI\\Facebook Campaign Funnel Report\\base_file\\lead_and_stage_base.xlsx"), overwrite = T)
rm(CPR_lead, CPR_stage, lead_and_stage_base)

# Removing not required objects ----
rm(funnel_col_order, na_values)

# rm(lead_bk_after_rename, lead_bk_after_bucketing, lead_bk_after_data_correction, lead_bk_after_channel_mapping, stage_bk_after_date_formatting, lead_bk_after_test, 
#    stage_bk_after_test, stage_bk_after_data_correction, stage_bk_after_channel_mapping)

# Saving objects in RData format ----
save(lead, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\lead_object.RData")
save(cost, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\cost_object.RData")
save(stage, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\stage_object.RData")
save(lead_data_for_funnel, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\lead_data_for_funnel_object.RData")
save(cost_data_for_funnel, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\cost_data_for_funnel_object.RData")
save(stage_data_for_funnel, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\stage_data_for_funnel_object.RData")
save(corp_B2C_data_for_funnel, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\corp_B2C_data_for_funnel_object.RData")
save(extract_for_funnel,file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\extract_for_funnel.RData")

# Google raw data to Pivotroot ----
lead_data_Google = sqldf("select IC_CREATED_DATE, COUNTRY_PROPER Country, RATING Rating, UTM_CAMPAIGN Utm_Campaign, 
                         UTM_SOURCE Utm_Source, LEAD_SOURCE Lead_Source, UTM_CONTENT Utm_Content, UTM_TERM Utm_Term,
                         UTM_MEDIUM Utm_Medium, FINAL_CHANNEL Channel, FINAL_SUB_CHANNEL Sub_Channel, PROGRAM Programme,
                         COHORT Cohort
                         from lead
                         where FINAL_CHANNEL == 'Google'
                         and PROGRAM == 'CERT-Digital Market Places'
                         or PROGRAM == 'CERT-Digital Strategies'
                         or PROGRAM == 'CERT-Applied Machine Learning'
                         or PROGRAM == 'CERT-Applied Data Science'
                         or PROGRAM == 'CERT-NUS Digital Marketing'
                         or PROGRAM == 'SO - Value Investing'
                         or PROGRAM == 'SO - HR Management and Analytics'
                         or PROGRAM == 'SO - Kellogg Digital Marketing Strategies'")

lead_data_Google <- lead_data_Google[(lead_data_Google$Channel == 'Google'),]
lead_data_Google <- lead_data_Google %>% rename(Lead_Created_Date = IC_CREATED_DATE)

app_data_Google <- sqldf("select APP_CREATED_DATE, COUNTRY_PROPER Country, UTM_CAMPAIGN Utm_Campaign, UTM_SOURCE Utm_Source,
                         LEAD_SOURCE Lead_Source, UTM_CONTENT Utm_Content, UTM_TERM Utm_Term, UTM_MEDIUM Utm_Medium, FINAL_CHANNEL Channel,
                         FINAL_SUB_CHANNEL Sub_Channel, APP App_Count, PAID_APP Paid_App_Count, COHORT Cohort, PROGRAM Programme
                         from stage
                         where FINAL_CHANNEL == 'Google'
                         and PROGRAM == 'CERT-Digital Market Places'
                         or PROGRAM == 'CERT-Digital Strategies'
                         or PROGRAM == 'CERT-Applied Machine Learning'
                         or PROGRAM == 'CERT-Applied Data Science'
                         or PROGRAM == 'CERT-NUS Digital Marketing'
                         or PROGRAM == 'SO - Value Investing'
                         or PROGRAM == 'SO - HR Management and Analytics'
                         or PROGRAM == 'SO - Kellogg Digital Marketing Strategies'")
app_data_Google <- app_data_Google[(app_data_Google$Channel == 'Google'),]
app_data_Google <- app_data_Google %>% rename(App_Created_Date = APP_CREATED_DATE)

write.csv(lead_data_Google, file = paste0("C:/Users/yogesh.alkari/Erulearning Solutions Pvt Ltd/Mohsin Belim - Google Lead Dump - Pivot Roots/", "lead_data_Google_", Sys.Date(),".csv"), row.names=F)
write.csv(app_data_Google, file = paste0("C:/Users/yogesh.alkari/Erulearning Solutions Pvt Ltd/Mohsin Belim - Google Lead Dump - Pivot Roots/", "app_data_Google_", Sys.Date(),".csv"), row.names=F)
rm(lead_data_Google, app_data_Google)

# Google raw data to Lean SEM ----
lead_data_Google_Lean_SEM <- sqldf("select COHORT, UTM_CAMPAIGN, UTM_TERM, UTM_CONTENT, RATING, FINAL_CHANNEL, sum(LEAD_COUNT) LEAD_COUNT
                              from lead
                              where FINAL_CHANNEL == 'Google'
                              and COHORT in ('LMDM : Jun-20 (B-9495)', 'BDS : May-20 (B-9100)')
                              group by COHORT, UTM_CAMPAIGN, UTM_TERM, UTM_CONTENT, RATING, FINAL_CHANNEL")

app_data_Google_Lean_SEM <- sqldf("select COHORT, UTM_CAMPAIGN, UTM_TERM, UTM_CONTENT, FINAL_CHANNEL, sum(PAID_APP) PAID_APP
                              from stage
                              where FINAL_CHANNEL == 'Google'
                              and COHORT in ('LMDM : Jun-20 (B-9495)', 'BDS : May-20 (B-9100)')
                              group by COHORT, UTM_CAMPAIGN, UTM_TERM, UTM_CONTENT, FINAL_CHANNEL")
write.csv(lead_data_Google_Lean_SEM, "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Mohsin Belim - Google Lead Dump - Leansem\\lead_data_Google_Lean_SEM.csv")
write.csv(app_data_Google_Lean_SEM, "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Mohsin Belim - Google Lead Dump - Leansem\\app_data_Google_Lean_SEM.csv")

rm(lead_data_Google_Lean_SEM, app_data_Google_Lean_SEM)




# Saving objects on share folder ----
cal_master <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
cal_master <- cal_master[, c(1:18)]
save(cal_master, file = "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Analytics Core Team - Shared Folder\\Base Data\\Base files - Emeritus\\daily_cal_master_object.RData")
save(lead, file = "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Analytics Core Team - Shared Folder\\Base Data\\Base files - Emeritus\\lead_object.RData")
save(stage, file = "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Analytics Core Team - Shared Folder\\Base Data\\Base files - Emeritus\\stage_object.RData")
save(cost, file = "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Analytics Core Team - Shared Folder\\Base Data\\Base files - Emeritus\\cost_object.RData")
save(extract_for_funnel, file = "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Analytics Core Team - Shared Folder\\Base Data\\Base files - Emeritus\\extract_for_funnel.RData")

rm(cal_master, lead_data_for_funnel, cost_data_for_funnel, stage_data_for_funnel, corp_B2C_data_for_funnel)


# Coupon Usage Report Power BI Part 1 ----
coupon_base <- read.csv(text=paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\Power BI\\Coupon Usages Report\\CU_base_till_today.csv"), -7), collapse="\n"), stringsAsFactors = F)
master_code_base <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "master_code_base")

coupon_base <- coupon_base %>% rename(
  ONLINE_APP_NAME = Online.Application.Name,
  CODE_START_DATE = Master.Product..Start.Date,
  CODE_END_DATE = Master.Product..End.Date,
  MASTER_CODE = Product.Name,
  CODE_NAME = Tuition.Assistance.Code,
  CODE_TYPE = Master.Product..Tuition.Assistance.Type,
  CODE_VALUE = Master.Product..Amount,
  CODE_ACTIVE_STATUS = Master.Product..Active)

coupon_usages_base <- sqldf("select a.ONLINE_APPLICATION_NAME, a.COHORT, a.COUNTRY_PROPER, a.FINAL_CHANNEL, a.FY_Q, a.FY, a.GENDER, a.INCOME_SLAB, 
                            a.INDUSTRY,a.PROGRAM_TYPE, a.PROGRAM, a.REGION, a.WORK_EX_SLAB, a.PAID_APP, a.PROGRAM_FEE, a.REVENUE,
                            b.MASTER_CODE, b.CODE_NAME, b.CODE_TYPE, b.CODE_VALUE
                            from stage a
                            left join coupon_base b on a.ONLINE_APPLICATION_NAME = b.ONLINE_APP_NAME
                            where a.FY in ('FY18-19', 'FY19-20', 'FY20-21')")
coupon_usages_base$FY = NULL
na_codes <- sqldf("select distinct a.MASTER_CODE, b.MASTER_CODE_BASE from coupon_usages_base a left join master_code_base b on a.MASTER_CODE = b.MASTER_CODE_BASE")
na_codes <- na_codes[is.na(na_codes$MASTER_CODE_BASE),]
view(na_codes) # Update New TA codes in Master File

# Coupon Usage Report Power BI Part 2 ----
coupon_usages_base <- sqldf("select a.*, b.CODE_DESCRIPTION from coupon_usages_base a left join master_code_base b on a.MASTER_CODE = b.MASTER_CODE_BASE")
coupon_usages_base$App <- 1
coupon_usages_base$CODE_APPLIED_APP <- ifelse(!is.na(coupon_usages_base$MASTER_CODE),1,0) 
coupon_usages_base$CODE_APPLIED_PAID_APP <- ifelse((!is.na(coupon_usages_base$MASTER_CODE)) & (coupon_usages_base$PAID_APP == 1),1,0)

coupon_usages_base$REVENUE_BEFORE_DISCOUNT <- ifelse((coupon_usages_base$PAID_APP == 1 & coupon_usages_base$CODE_TYPE == "Flat Discount"), coupon_usages_base$REVENUE + coupon_usages_base$CODE_VALUE,
                                                     ifelse((coupon_usages_base$PAID_APP == 1 & coupon_usages_base$CODE_TYPE == "Percentage Discount"),
                                                            (((coupon_usages_base$CODE_VALUE * coupon_usages_base$PROGRAM_FEE)/100) + coupon_usages_base$REVENUE), 0))
coupon_usages_base$REVENUE_BEFORE_DISCOUNT <- replace(coupon_usages_base$REVENUE_BEFORE_DISCOUNT, is.na(coupon_usages_base$REVENUE_BEFORE_DISCOUNT), 0)

coupon_usages_base[,c("ONLINE_APPLICATION_NAME", "PROGRAM_FEE", "CODE_NAME", "MASTER_CODE", "CODE_VALUE", "CODE_TYPE")] <- NULL

coupon_usages_base <- coupon_usages_base %>% rename(Income = INCOME_SLAB,
                                                    Paid_App = PAID_APP,
                                                    Cohort = COHORT,
                                                    Industry = INDUSTRY,
                                                    Code_Type = CODE_DESCRIPTION,
                                                    Country = COUNTRY_PROPER,
                                                    Prog_Type = PROGRAM_TYPE,
                                                    Revenue = REVENUE,
                                                    Code_Applied_App = CODE_APPLIED_APP,
                                                    Gender = GENDER,
                                                    Work_Experience = WORK_EX_SLAB,
                                                    Region = REGION,
                                                    Revenue_Before_Discount = REVENUE_BEFORE_DISCOUNT,
                                                    Channel = FINAL_CHANNEL,
                                                    Program = PROGRAM,
                                                    Code_Applied_Paid_App = CODE_APPLIED_PAID_APP)

cal_calendar <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
coupon_usages_base <- sqldf("select a.*, b.SR_NO as Sr_No, b.ACTIVE as Batch_Status from coupon_usages_base a left join cal_calendar b on a.Cohort = b.COHORT")
coupon_usages_base$Batch_Status <- ifelse((coupon_usages_base$Batch_Status == 1),"Active", "Closed")

save(coupon_usages_base, file = "D:\\Emeritus\\Reports\\Automation\\Power BI\\Coupon Usages Report\\base_file\\coupon_usages_base.RData")
save(coupon_usages_base, file = "C:\\Users\\yogesh.alkari\\Erulearning Solutions Pvt Ltd\\Analytics Core Team - Shared Folder\\PowerBI_RObjects\\coupon_usages_base.RData")

rm(coupon_base, coupon_usages_base, master_code_base, na_codes, cal_calendar)





# END --1-- =========================================================================================

# Marketing MIS (to Finance) ----
conso_cost <- data.frame(Date=cost$DATE, Channel=cost$CHANNEL, Sub_Channel=cost$SUB_CHANNEL, Country=cost$COUNTRY, Cost=cost$COST, Course=cost$COHORT)
conso_cost_fy19 <- subset(conso_cost, Date > as.Date("2019-06-30"))
conso_cost_fy19$Month <- as.character((conso_cost_fy19$Date), "%b-%y")
prog_code_names = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
prog_code_names = data.frame(COHORT=prog_code_names$COHORT, Course_Code=prog_code_names$PROGRAM, Course_Type=prog_code_names$PROGRAM_TYPE)
conso_cost_fy19 = merge(conso_cost_fy19, prog_code_names, by.x = 'Course', by.y = 'COHORT', all.x = T, all.y = F)
conso_cost_fy19$Course_Code <- as.character(conso_cost_fy19$Course_Code)
conso_cost_fy19$Course_Type <- as.character(conso_cost_fy19$Course_Type)
conso_cost_fy19$Course_Code <- ifelse(is.na(conso_cost_fy19$Course_Code), 'Other', conso_cost_fy19$Course_Code)
conso_cost_fy19$Course_Type <- ifelse(is.na(conso_cost_fy19$Course_Type), 'Other', conso_cost_fy19$Course_Type)

extract_conso_cost_fy19 = sqldf("select Course, Channel, Sub_Channel, Country, Course_Code, Course_Type, Month, sum(Cost) Cost
                                from conso_cost_fy19 group by Course, Channel, Sub_Channel, Country, Course_Code, Course_Type, Month")
write.xlsx(extract_conso_cost_fy19, paste0("D:\\Emeritus\\Reports\\Finance\\Marketing MIS\\extract_conso_cost_fy19_", Sys.Date(),".xlsx"))

rm(conso_cost, conso_cost_fy19, prog_code_names, extract_conso_cost_fy19)

# Business / Management MIS (to Finance) ----

monthly_leads <- data.frame(LEAD_DATE=lead$LEAD_CREATED_DATE, IC_DATE=lead$IC_CREATED_DATE, CHANNEL=lead$FINAL_CHANNEL,
                            PROGRAM_TYPE=lead$PROGRAM_TYPE, IC_STATUS=lead$IC_ACTIVE_STATUS)
monthly_apps <- data.frame(LEAD_DATE=stage$LEAD_CREATED_DATE, IC_DATE=stage$IC_CREATED_DATE, DATE=stage$LAST_STAGE_CHANGE_DATE,
                           CHANNEL=stage$FINAL_CHANNEL, PAID_APPS=stage$PAID_APP, PROGRAM_TYPE=stage$PROGRAM_TYPE, REVENUE=stage$REVENUE)
monthly_cost <- data.frame(DATE=cost$DATE, CHANNEL=cost$CHANNEL, COURSE=cost$COHORT, COST=cost$COST)

monthly_leads <- monthly_leads[!(monthly_leads$IC_STATUS == 0),]
monthly_apps <- monthly_apps[!(monthly_apps$PAID_APPS == 0),]

monthly_leads$IC_YEAR_MONTH <- format(as.Date(monthly_leads$IC_DATE), "%Y-%m")
monthly_apps$YEAR_MONTH <- format(as.Date(monthly_apps$DATE), "%Y-%m")
monthly_cost$YEAR_MONTH <- format(as.Date(monthly_cost$DATE), "%Y-%m")

monthly_leads$New_Existing <- ifelse((monthly_leads$IC_DATE == monthly_leads$LEAD_DATE), "New", "Existing")
monthly_apps$New_Existing <- ifelse((monthly_apps$IC_DATE == monthly_apps$LEAD_DATE), "New", "Existing")

monthly_leads_agg <- aggregate(x = monthly_leads[c("IC_STATUS")], by = monthly_leads[c("IC_YEAR_MONTH", "CHANNEL", "PROGRAM_TYPE", "New_Existing")], FUN = sum)
monthly_apps_agg <- aggregate(x = monthly_apps[c("PAID_APPS", "REVENUE")], by = monthly_apps[c("YEAR_MONTH", "CHANNEL", "PROGRAM_TYPE", "New_Existing")], FUN = sum)
monthly_cost_agg <- aggregate(x = monthly_cost[c("COST")], by = monthly_cost[c("YEAR_MONTH", "CHANNEL", "COURSE")], FUN = sum)

names(monthly_leads_agg)[names(monthly_leads_agg)=="IC_YEAR_MONTH"] = "MONTH"
names(monthly_leads_agg)[names(monthly_leads_agg)=="IC_STATUS"] = "LEAD"
names(monthly_apps_agg)[names(monthly_apps_agg)=="YEAR_MONTH"] = "MONTH"
monthly_leads_agg$COST = 0
monthly_leads_agg$PAID_APPS = 0
monthly_leads_agg$REVENUE = 0
monthly_apps_agg$LEAD = 0
monthly_apps_agg$COST = 0

prog_code_names = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
prog_code_names = data.frame(COHORT=prog_code_names$COHORT, PROGRAM_TYPE=prog_code_names$PROGRAM_TYPE)
monthly_cost_agg = merge(monthly_cost_agg, prog_code_names, by.x = 'COURSE', by.y = 'COHORT', all.x = T, all.y = F)

names(monthly_cost_agg)[names(monthly_cost_agg)=="YEAR_MONTH"] = "MONTH"

monthly_cost_agg$LEAD = 0
monthly_cost_agg$PAID_APPS = 0
monthly_cost_agg$REVENUE = 0
monthly_cost_agg$New_Existing = "New"
monthly_cost_agg$COURSE = NULL

business_mis <- rbind(monthly_leads_agg, monthly_apps_agg, monthly_cost_agg)
business_mis <- business_mis[order(business_mis$MONTH),]
business_mis <- business_mis[!is.na (business_mis$PROGRAM_TYPE),]
business_mis <- business_mis[!is.na (business_mis$REVENUE),]
business_mis$PROGRAM_TYPE <- ifelse((business_mis$PROGRAM_TYPE == "Cert" | business_mis$PROGRAM_TYPE == "Diploma"), "Emeritus", "WL")

write.csv(business_mis, paste0("D:\\Emeritus\\Reports\\Finance\\Management MIS\\","business_mis_base_data_", Sys.Date(),".csv"), row.names=F)

rm(business_mis, monthly_apps, monthly_apps_agg, monthly_cost, monthly_cost_agg, monthly_leads, monthly_leads_agg, prog_code_names)




# END --2-- =========================================================================================

# Funnel Report for Outreach Team ----
extract_for_funnel_PA <- extract_for_funnel[(extract_for_funnel$db_category == "Lead" | extract_for_funnel$db_category == "Stage"),]
extract_for_funnel_PA$db_imp = NULL
extract_for_funnel_PA$db_clicks = NULL
extract_for_funnel_PA$db_cost = NULL
write.csv(extract_for_funnel_PA, "extract_for_funnel_PA_.csv")

rm(extract_for_funnel_PA)

# LSR Excel ----
# Lead
lsr_lead <- data.frame(LEAD_OWNER=lead$LEAD_OWNER, LEAD_RATING=lead$RATING, COURSE=lead$COHORT, COUNTRY=lead$COUNTRY_PROPER,
                       PROGRAM_TYPE=lead$PROGRAM_TYPE, FY=lead$FY, IC_STATUS=lead$IC_ACTIVE_STATUS, REGION=lead$REGION)

lsr_lead <- lsr_lead[!(lsr_lead$IC_STATUS == 0),]
lsr_lead <- lsr_lead[!(lsr_lead$FY == "FY15-16"),]
lsr_lead <- lsr_lead[!(lsr_lead$FY == "FY16-17"),]
lsr_lead <- lsr_lead[!(lsr_lead$FY == "FY17-18"),]
lsr_lead$FY = NULL
lsr_lead$IC_STATUS = NULL

# Lead Rating spliting
lsr_lead$LEAD_RATING_LEVEL <- ifelse(lsr_lead$LEAD_RATING == "Open",1,
                                     ifelse(lsr_lead$LEAD_RATING == "Unreachable 1",2,
                                            ifelse(lsr_lead$LEAD_RATING == "Unreachable 2",3,
                                                   ifelse(lsr_lead$LEAD_RATING == "Dead", 4,
                                                          ifelse(lsr_lead$LEAD_RATING == "Callback",5,
                                                                 ifelse(lsr_lead$LEAD_RATING == "Hot",6,
                                                                        ifelse(lsr_lead$LEAD_RATING == "Warm",7,
                                                                               ifelse(lsr_lead$LEAD_RATING == "Cold",8,
                                                                                      ifelse(lsr_lead$LEAD_RATING == "Working on App",9,
                                                                                             ifelse(lsr_lead$LEAD_RATING == "Applied",10,11))))))))))
levels <- unique(lsr_lead$LEAD_RATING_LEVEL)
levels <-sort(levels)
# Consider last level  as reference category
for( i in 1:(length(levels)) ){
  colName <- paste("Rating",levels[i],sep="_")
  lsr_lead[,colName] <- ifelse(lsr_lead$LEAD_RATING_LEVEL==levels[i],1,0)
}

lsr_lead$LEAD_RATING_LEVEL = NULL
lsr_agg_lead <- aggregate(x = lsr_lead[c("Rating_1","Rating_2","Rating_3","Rating_4","Rating_5","Rating_6","Rating_7","Rating_8","Rating_9","Rating_10")],
                          by = lsr_lead[c("LEAD_OWNER","COURSE","COUNTRY","PROGRAM_TYPE", "REGION")], FUN = sum)

names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_1"]="Open"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_2"]="UR_1"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_3"]="UR_2"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_4"]="Dead"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_5"]="Callback"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_6"]="Hot"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_7"]="Warm"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_8"]="Cold"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_9"]="Working_on_App"
names(lsr_agg_lead)[names(lsr_agg_lead)=="Rating_10"]="Applied"

lsr_agg_lead$App = 0
lsr_agg_lead$Paid_App = 0
lsr_agg_lead$Total_Leads <- rowSums(lsr_agg_lead[, c("Open","UR_1","UR_2","Dead","Callback","Hot","Warm","Cold","Working_on_App","Applied")], na.rm = FALSE)

# Stage
lsr_stage <- data.frame(LEAD_OWNER=stage$LEAD_OWNER, COURSE=stage$COHORT, COUNTRY=stage$COUNTRY_PROPER, PROGRAM_TYPE=stage$PROGRAM_TYPE,
                        App=stage$APP, Paid_App=stage$PAID_APP, FY=stage$FY, REGION=stage$REGION)
lsr_stage <- lsr_stage[!(lsr_stage$FY == "FY15-16"),]
lsr_stage <- lsr_stage[!(lsr_stage$FY == "FY16-17"),]
lsr_stage <- lsr_stage[!(lsr_stage$FY == "FY17-18"),]

lsr_agg_stage <- aggregate(x = lsr_stage[c("App", "Paid_App")],
                           by = lsr_stage[c("LEAD_OWNER","COURSE","COUNTRY","PROGRAM_TYPE","REGION")],
                           FUN = sum)
lsr_agg_stage$Open = 0
lsr_agg_stage$UR_1 = 0
lsr_agg_stage$UR_2 = 0
lsr_agg_stage$Dead = 0
lsr_agg_stage$Callback = 0
lsr_agg_stage$Hot = 0
lsr_agg_stage$Warm = 0
lsr_agg_stage$Cold = 0
lsr_agg_stage$Working_on_App = 0
lsr_agg_stage$Applied = 0
lsr_agg_stage$Total_Leads = 0

lsr_base = rbind(lsr_agg_lead, lsr_agg_stage)
rm(lsr_lead, lsr_agg_lead, lsr_stage, lsr_agg_stage)
calendar = read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
new_columns <- data.frame(batch_id=calendar$COHORT, Batch_Status=calendar$ACTIVE, Programme_Code=calendar$PROGRAM)
lsr_base = merge(lsr_base, new_columns, by.x = 'COURSE', by.y = 'batch_id', all.x = T, all.y = F)
lsr_base$Batch_Status = ifelse(lsr_base$Batch_Status == 1, "Active", "Inactive")
write.csv(lsr_base, file = paste0("C:/Users/yogesh.alkari/Erulearning Solutions Pvt Ltd/Analytics Core Team - Shared Folder/", "lsr_base_", Sys.Date(),".csv"))

rm(calendar, new_columns, lsr_base, i, levels, colName)

# TAR Excel ----

CPPATL_lead_base <- data.frame(DATE_IC=lead$IC_CREATED_DATE, COURSE=lead$COHORT, IC_STATUS=lead$IC_ACTIVE_STATUS) # 1
CPPATL_lead_base <- subset(CPPATL_lead_base, IC_STATUS >0, select = c(DATE_IC, COURSE)) # 1
CPPATL_lead_base$LEAD <- 1
CPPATL_lead_base <- sqldf("select DATE_IC, COURSE, sum(LEAD) LEAD from CPPATL_lead_base group by DATE_IC, COURSE") # Group by 1
CPPATL_stage_base_app <- data.frame(DATE_APP=stage$APP_CREATED_DATE, COURSE=stage$COHORT, APP=stage$APP, DEFERRED=stage$DEFERRED) # 2
CPPATL_stage_base_app = sqldf("select DATE_APP, COURSE, DEFERRED, sum(APP) APP from CPPATL_stage_base_app group by DATE_APP, COURSE, DEFERRED") # Group by 2

CPPATL_stage_base_paid_app <- data.frame(DATE_PY=stage$LAST_STAGE_CHANGE_DATE, COURSE=stage$COHORT, PAID_APP=stage$PAID_APP,
                                         DEFERRED=stage$DEFERRED, REVENUE=stage$REVENUE) # 3
CPPATL_stage_base_paid_app <- sqldf("select DATE_PY, COURSE, DEFERRED, sum(PAID_APP) PAID_APP, sum(REVENUE) REVENUE
                                    from CPPATL_stage_base_paid_app group by DATE_PY, COURSE, DEFERRED") # Group by 3
CPPATL_cost_base = sqldf("select COHORT, sum(COST) COST, DATE from cost group by COHORT, DATE") # Group by 4
CPPATL_cost_base <- CPPATL_cost_base %>% rename(COURSE = COHORT, DATE_IC = DATE)

CPPATL_lead_base$COST = 0
CPPATL_lead_base$DATE_APP = CPPATL_lead_base$DATE_IC
CPPATL_lead_base$DEFERRED = 'New'
CPPATL_lead_base$APP = 0
CPPATL_lead_base$DATE_PY = CPPATL_lead_base$DATE_IC
CPPATL_lead_base$PAID_APP = 0
CPPATL_lead_base$REVENUE = 0
CPPATL_cost_base$LEAD = 0
CPPATL_cost_base$DATE_APP = CPPATL_cost_base$DATE_IC
CPPATL_cost_base$DEFERRED = 'New'
CPPATL_cost_base$APP = 0
CPPATL_cost_base$DATE_PY = CPPATL_cost_base$DATE_IC
CPPATL_cost_base$PAID_APP = 0
CPPATL_cost_base$REVENUE = 0
CPPATL_stage_base_app$DATE_IC = CPPATL_stage_base_app$DATE_APP
CPPATL_stage_base_app$LEAD = 0
CPPATL_stage_base_app$COST = 0
CPPATL_stage_base_app$DATE_PY = CPPATL_stage_base_app$DATE_APP
CPPATL_stage_base_app$PAID_APP = 0
CPPATL_stage_base_app$REVENUE = 0
CPPATL_stage_base_paid_app$DATE_IC = CPPATL_stage_base_paid_app$DATE_PY
CPPATL_stage_base_paid_app$LEAD = 0
CPPATL_stage_base_paid_app$COST = 0
CPPATL_stage_base_paid_app$DATE_APP = CPPATL_stage_base_paid_app$DATE_PY
CPPATL_stage_base_paid_app$APP = 0

CPPA_Trend_base <- rbind(CPPATL_lead_base, CPPATL_cost_base, CPPATL_stage_base_app, CPPATL_stage_base_paid_app)

CPPA_Trend_base_backup = CPPA_Trend_base
CPPA_Trend_base <- aggregate(list(LEAD=CPPA_Trend_base_backup$LEAD, APP=CPPA_Trend_base_backup$APP, PAID_APP=CPPA_Trend_base_backup$PAID_APP,
                                  REVENUE=CPPA_Trend_base_backup$REVENUE, COST=CPPA_Trend_base_backup$COST),
                             by=list(DATE_IC=CPPA_Trend_base_backup$DATE_IC,DATE_APP=CPPA_Trend_base_backup$DATE_APP, DATE_PY=CPPA_Trend_base_backup$DATE_PY,
                                     COURSE=CPPA_Trend_base_backup$COURSE, DEFERRED=CPPA_Trend_base_backup$DEFERRED), FUN=sum)

FY_base_data = data.frame(COURSE=cal_master$COHORT, FY=cal_master$FY)
CPPA_Trend_base <- merge(CPPA_Trend_base, FY_base_data, by.x = 'COURSE', by.y = 'COURSE', all.x = T, all.y = F)
CPPA_Trend_base <- subset(CPPA_Trend_base, FY =='FY18-19' | FY =='FY19-20' , select = c(DATE_IC,DATE_APP, DATE_PY, COURSE, LEAD, APP, PAID_APP, REVENUE, COST, DEFERRED))
names(CPPA_Trend_base)[names(CPPA_Trend_base)=="DATE_IC"]="DATE"
CPPA_Trend_base$DATE_APP = NULL
CPPA_Trend_base$DATE_PY = NULL
CPPA_Trend_base$sum = CPPA_Trend_base$LEAD + CPPA_Trend_base$APP + CPPA_Trend_base$PAID_APP + CPPA_Trend_base$PAID_APP + CPPA_Trend_base$REVENUE + CPPA_Trend_base$COST
CPPA_Trend_base <- CPPA_Trend_base[!(CPPA_Trend_base$sum == 0),]
CPPA_Trend_base$sum = NULL

write.csv(CPPA_Trend_base, "extract_CPPA_Trend_base.csv")

rm(CPPATL_lead_base, CPPATL_cost_base, CPPATL_stage_base_app, CPPATL_stage_base_paid_app, FY_base_data, CPPA_Trend_base, CPPA_Trend_base_backup)

load("D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\cost_data_for_funnel_object.RData")

# PAR Excel ----

# Lead data working for PAR : CPL Calculation
# lead
PAR_lead_cpl = data.frame(CHANNEL=lead$FINAL_CHANNEL, COUNTRY=lead$COUNTRY_PROPER, PROGRAM=lead$COHORT, LEAD_COUNT=lead$IC_ACTIVE_STATUS)
PAR_lead_cpl <- PAR_lead_cpl[(PAR_lead_cpl$LEAD_COUNT == 1),]
PAR_lead_cpl = sqldf("select CHANNEL, COUNTRY, PROGRAM, sum(LEAD_COUNT) LEAD_COUNT from PAR_lead_cpl group by CHANNEL, COUNTRY, PROGRAM")
PAR_lead_cpl$COST = 0

# Cost
PAR_cost_cpl <- sqldf("select CHANNEL, COUNTRY, COHORT PROGRAM, sum(COST) COST FROM cost group by CHANNEL, COUNTRY, COHORT")
PAR_cost_cpl$LEAD_COUNT = 0
PAR_cost_cpl <- PAR_cost_cpl[(PAR_cost_cpl$PROGRAM != "All_Program_B2B_Events_Test"),]

PAR_lead_and_cost = rbind(PAR_lead_cpl, PAR_cost_cpl)
PAR_lead_with_cpl = sqldf("select CHANNEL, COUNTRY, PROGRAM, sum(LEAD_COUNT) LEAD_COUNT, sum(COST) COST
                          from PAR_lead_and_cost group by CHANNEL, COUNTRY, PROGRAM")
PAR_lead_with_cpl$CPL = PAR_lead_with_cpl$COST / PAR_lead_with_cpl$LEAD_COUNT
PAR_lead_with_cpl$TEMP = ifelse((PAR_lead_with_cpl$CPL == "Inf"), NA, 
                                ifelse((PAR_lead_with_cpl$LEAD_COUNT == 0 & PAR_lead_with_cpl$COST == 0), NA, "keep"))
PAR_lead_with_cpl = PAR_lead_with_cpl[!is.na(PAR_lead_with_cpl$TEMP),]
PAR_lead_with_cpl$TEMP = NULL
PAR_lead_with_cpl$conca = paste0(PAR_lead_with_cpl$CHANNEL, PAR_lead_with_cpl$COUNTRY, PAR_lead_with_cpl$PROGRAM)

# Applying CPL alongwith work experience
PAR_lead_base = data.frame(CHANNEL=lead$FINAL_CHANNEL, COUNTRY=lead$COUNTRY_PROPER, PROGRAM=lead$COHORT, LEAD_COUNT=lead$IC_ACTIVE_STATUS,
                           WORK_EXPERIENCE=lead$WORK_EX_SLAB, REGION=lead$REGION)
PAR_lead_base <- PAR_lead_base[(PAR_lead_base$LEAD_COUNT == 1),]
PAR_lead_base = sqldf("select CHANNEL, COUNTRY, REGION, PROGRAM, WORK_EXPERIENCE, sum(LEAD_COUNT) LEAD_COUNT
                      from PAR_lead_base group by CHANNEL, COUNTRY, PROGRAM, WORK_EXPERIENCE, REGION")
PAR_lead_base$conca = paste0(PAR_lead_base$CHANNEL, PAR_lead_base$COUNTRY, PAR_lead_base$PROGRAM)
PAR_lead = merge(PAR_lead_base, PAR_lead_with_cpl[,c("conca", "CPL")], by.x = 'conca', by.y = 'conca', all.x = T, all.y = F)
PAR_lead$COST = PAR_lead$LEAD_COUNT * PAR_lead$CPL
PAR_lead$conca = NULL
names(PAR_lead)[names(PAR_lead)=="LEAD_COUNT"]="LEAD"

# Stage
PAR_stage_base = sqldf("select FINAL_CHANNEL CHANNEL, COUNTRY_PROPER COUNTRY, REGION, COHORT PROGRAM, APP, PAID_APP,
                       GENDER, INCOME_SLAB INCOME, WORK_EX_SLAB WORK_EXPERIENCE, REVENUE from stage")
PAR_lead$APP = 0
PAR_lead$PAID_APP = 0
PAR_lead$REVENUE = 0
PAR_lead$INCOME = NA
PAR_lead$GENDER = NA
PAR_lead$DATA_TYPE = "Lead"
PAR_stage_base$LEAD = 0
PAR_stage_base$CPL = 0
PAR_stage_base$COST = 0
PAR_stage_base$DATA_TYPE = "Stage"
PAR_base_data = rbind(PAR_lead, PAR_stage_base)
prog_type_for_PAR <- daily_cal_master
prog_type_for_PAR = data.frame(prog_unique_name=prog_type_for_PAR$COHORT, PROGRAM_TYPE=prog_type_for_PAR$PROGRAM_TYPE,
                               PROGRAM_CODE=prog_type_for_PAR$PROGRAM, FY=prog_type_for_PAR$FY)
PAR_base_data = merge(PAR_base_data, prog_type_for_PAR, by.x = 'PROGRAM', by.y = 'prog_unique_name', all.x = T, all.y = F)
PAR_base_data <- PAR_base_data[!(PAR_base_data$FY == "FY15-16"),]
PAR_base_data <- PAR_base_data[!(PAR_base_data$FY == "FY16-17"),]
PAR_base_data <- PAR_base_data[!(PAR_base_data$FY == "FY17-18"),]

write.csv(PAR_base_data, "extract_PAR_base_data.csv")

rm(PAR_lead_cpl, PAR_cost_cpl, PAR_lead_and_cost, PAR_lead_with_cpl, PAR_lead_base, PAR_lead, PAR_stage_base,
   PAR_base_data, prog_type_for_PAR, daily_cal_master)




# END --3-- =========================================================================================

# cal_master <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_calendar")
# batch_file <- select(cal_master, BATCH_ID, PROGRAM, LEAD_FLOW_START, LEAD_FLOW_END)
# 
# batch_file <- sqldf("SELECT BATCH_ID, PROGRAM, LEAD_FLOW_START, LEAD_FLOW_END,
#                         LEAD(LEAD_FLOW_END, 1) OVER (PARTITION BY PROGRAM ORDER BY PROGRAM, LEAD_FLOW_END) AS NEXT_BATCH_DATE,
#                         LEAD(BATCH_ID, 1) OVER (PARTITION BY PROGRAM ORDER BY PROGRAM, LEAD_FLOW_END) AS NEXT_BATCH_ID,
#                         ROW_NUMBER() OVER (PARTITION BY PROGRAM ORDER BY PROGRAM, LEAD_FLOW_END) AS ROW_IDX
#                         FROM batch_file")


# DF1 <- data.frame("col1" = rep(c("A","B"), 18),
#                   "col2" = rep(c("C","D","E"), 12),
#                   "value"= (sample(1:100,36)),
#                   "col4" = rep(NA,36),
#                   stringsAsFactors=F)
# 
# DF2 <- data.frame("col1" = rep("A",6),
#                   "col2" = rep(c("C","D"),3),
#                   "data" = rep(c(1,3),3),
#                   "min" = seq(0,59,by=10),
#                   "max" = seq(10,69,by=10),
#                   stringsAsFactors=F)
# 
# left_join(DF1, DF2, by=c("col1","col2")) %>%
#   rowwise() %>%
#   mutate(data = ifelse(between(value,min,max), data, NA)) %>%
#   select(-min, -max)

# Adhoc Activitis ----
# GDPR
emeritus_data = read.csv(text=paste0(head(readLines("C:\\Users\\yogesh.alkari\\Downloads\\emeritus_data.csv"), -7), collapse="\n"), stringsAsFactors = F)
pardot_data = read.csv("C:\\Users\\yogesh.alkari\\Downloads\\gdpr_no_emeritus.csv", stringsAsFactors = F)

emeritus_data_backup <- emeritus_data
emeritus_data <- unique(emeritus_data)

emeritus_data <- merge(emeritus_data, pardot_data)

pardot_data <- pardot_data %>% rename(pardot_mail = ?..Email)
pardot_data$mail_count <- 1
emeritus_data <- emeritus_data %>% rename(emeritus_mail = Email)
emeritus_data$count <- 1
emeritus_data <- merge(emeritus_data, pardot_data, by.x = 'emeritus_mail', by.y = 'pardot_mail', all.x = T, all.y = F)
emeritus_data <- emeritus_data[is.na(emeritus_data$mail_count),]

pardot_data <- merge(pardot_data, emeritus_data, by.x = 'pardot_mail', by.y = 'emeritus_mail', all.x = T, all.y = F)
pardot_data <- pardot_data[is.na(pardot_data$count),]

pardot_data[,c("mail_count.x", "Agree", "Email.Opt.Out", "Do.Not.Call", "mail_count.y", "count")] <- NULL
emeritus_data[,c("mail_count", "count")] <- NULL

emeritus_data <- emeritus_data[(emeritus_data$Agree == "No I Do Not Agree"),]

check_test <- data.frame(emeritus_data$Agree)

check_test <- unique(check_test)

write.csv(emeritus_data, "emeritus_data.csv")
write.csv(pardot_data, "pardot_data.csv")
emeritus_data_backup$count <- 1
emeritus_data_backup_not_agree <- data.frame(emeritus_data_backup$Agree, emeritus_data_backup$count)
emeritus_data_backup_not_agree <- emeritus_data_backup_not_agree[(emeritus_data_backup_not_agree$emeritus_data_backup.Agree == "No I Do Not Agree"),]
write.csv(emeritus_data_backup_not_agree, "emeritus_data_backup_not_agree.csv")
rm(emeritus_data, emeritus_data_backup, emeritus_data_backup_not_agree, pardot_data)

# ic history working ----
ic_history_SO <- read.csv(text = paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\R\\ic_history_from_q3_SO.csv"), -7), collapse = "\n"), stringsAsFactors = F)

ic_history_SO <- ic_history_SO %>% rename( IC_ID_H = Interested.Course..ID, Edit_Dt = Edit.Date, Old_Value = Old.Value, New_Value = New.Value, PROGRAM_H = Programme)

ic_history_SO_LastRecord <- sqldf("select a.IC_ID_H, a.Edit_Dt, a.Old_Value, a.New_Value, a.PROGRAM_H
                                  from ic_history_SO a
                                  inner join( select IC_ID_H, max(Edit_Dt) as Edit_Dt from ic_history_SO group by IC_ID_H) b
                                  on a.IC_ID_H = b.IC_ID_H and a.Edit_Dt = b.Edit_Dt")

lead_ic_history <- select(lead, IC_ID, RATING, COHORT, FY_Q, PROGRAM, COUNTRY_PROPER)
lead_ic_history <- filter(lead_ic_history, str_detect(lead_ic_history$PROGRAM, '^SO'))
lead_ic_history <- filter(lead_ic_history, str_detect(lead_ic_history$FY_Q, '^FY20'))

lead_ic_history <- merge(lead_ic_history, ic_history_SO_LastRecord, by.x = 'IC_ID', by.y = 'IC_ID_H', all.x = T, all.y = F)

stage_ic_history <- data.frame(IC_ID_S = stage$IC_ID, PAID_APP = stage$PAID_APP)
stage_ic_history <- unique(stage_ic_history)
lead_ic_history <- merge(lead_ic_history, stage_ic_history, by.x = 'IC_ID', by.y = 'IC_ID_S', all.x = T, all.y = F)

write.csv(lead_ic_history, "lead_ic_history.csv")

rm(ic_history_SO, ic_history_SO_LastRecord, lead_ic_history, stage_ic_history)

# lead_rating <- lead_rating %>% group_by_all() %>% tally()

# SMS working ----
sms_history = read.csv(text=paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\R\\sms_history_last_12_m.csv"), -7), collapse="\n"), stringsAsFactors = F)

sms_history_backup_og <- sms_history

lead_country_df <- data.frame(LEAD_ID_L=lead$LEAD_ID, COUNTRY_PROPER_L=lead$COUNTRY_PROPER)
lead_country_df <- unique(lead_country_df)

sms_history <- merge(sms_history, lead_country_df, by.x = 'LeadID', by.y = 'LEAD_ID_L', all.x = T, all.y = F)

sms_history_backup_aft_LIDL <- sms_history

country_base <- read.xlsx("D:\\Emeritus\\Reports\\Automation\\R\\cal_master.xlsx", sheet = "cal_country")

country_base$REGION <- NULL
country_base$LATITUDE <- NULL
country_base$LONGITUDE <- NULL
country_base$STANDARD_REGION <- NULL


country_base$COUNTRY_AS_PER_FILE <- tolower(country_base$COUNTRY_AS_PER_FILE)
sms_history$Country <- tolower(sms_history$Country)

sms_history <- merge(sms_history, country_base, by.x = 'Country', by.y = 'COUNTRY_AS_PER_FILE', all.x = T, all.y = F)

sms_history$US_Yes <- ifelse((sms_history$COUNTRY_PROPER_L == "United States" | sms_history$COUNTRY_PROPER == "United States"), "Yes", NA)

sms_history_US <- sms_history[!is.na(sms_history$US_Yes),]

write.csv(sms_history_US, "sms_history_US.csv")

rm(sms_history_backup_aft_LIDL, sms_history_backup_og)


sms_task_and_event = read.csv(text=paste0(head(readLines("D:\\Emeritus\\Reports\\Automation\\R\\sms_task_and_event.csv"), -7), collapse="\n"), stringsAsFactors = F)





# test_lead_email_base <- test_lead_email_base %>% group_by_all() %>% tally()
# save(monster_table, file = "D:\\Emeritus\\Reports\\Automation\\R\\monster_table.RData")
# metadata %>% filter(cit == "plus") %>% select(sample, generation, clade)

stage_check <- stage %>% filter(PAID_APP == 1) %>% select(APP, PAID_APP, LEAD_ID)

# 
# CREATE TEMP TABLE batch_prox AS (
#   SELECT 
#   batch_start_date, 
#   batch_id batch_id_prox,
#   product__c program_prox, 
#   tmp.day ic_date,
#   ROW_NUMBER() OVER (PARTITION BY product__c, tmp.day ORDER BY batch_start_date) AS row_idx
#   FROM (SELECT batch_start_date, batch_id,
#         LEAD(batch_start_date) OVER(PARTITION BY product__c ORDER BY batch_start_date) next_batch,
#         product__c
#         FROM `reporting.batch_comb`)
#   batches
#   CROSS JOIN (SELECT day
#               FROM UNNEST(
#                 GENERATE_DATE_ARRAY(DATE('2015-06-01'), 
#                                     DATE_ADD(CURRENT_DATE(), INTERVAL 2 YEAR), INTERVAL 1 DAY)
#               ) AS day) tmp
#   WHERE day <= batch_start_date AND (tmp.day < next_batch OR next_batch IS NULL)
#   ORDER BY program_prox, batch_start_date, ic_date);

save(monster_table, file = "monster_table.RData")

save(na_batch_id_leads, file = "D:\\Emeritus\\Reports\\Automation\\R\\daily_objects\\2_na_batch_id_leads.RData")
# Facebook Cost backup 5 ----
# c_fb <- sum(cost_fb$AMOUNT)
# c_fb_crsl <- sum(cost_fb_crsl$AMOUNT)
# c_fb_common <- sum(cost_fb_common$AMOUNT)
# c_gg <- sum(cost_gg$AMOUNT_IN_USD)
# c_comm_lp <- sum(cost_data_comm_lp$COST)
# c_fb_total_5 <- matrix(c(c_fb, c_fb_crsl, c_fb_common, c_gg, c_comm_lp), ncol = 5, byrow = T)
# colnames(c_fb_total_5) <- c("c_fb", "c_fb_c", "c_fb_comm", "c_gg", "c_comm_lp")
# rownames(c_fb_total_5) <- c("spent")
# rm(c_fb, c_fb_crsl, c_fb_common, c_gg, c_comm_lp)



# Combine lead & stage (master dataframe) ----

lead_c <- data.frame(Lead_Lead_ID=lead$LEAD_ID, Lead_IC_ID=lead$INTERESTED_COURSE_ID, Lead_Lead_Date=lead$LEAD_CREATED_DATE, Lead_IC_Date=lead$IC_CREATED_DATE, Lead_Email=lead$LEAD_EMAIL, Lead_Country=lead$LEAD_COUNTRY_PROPER, Lead_Work_Ex=lead$WORK_EXPERIENCE_SLAB, Lead_IC_Status=lead$IC_STATUS, Lead_Batch_ID=lead$BATCH_ID, Lead_Programme=lead$LEAD_PROGRAM, Lead_Cohort=lead$PROGRAM_UNIQUE_NAME_AS_PER_LEAD, Lead_Channel=lead$FINAL_CHANNEL, Lead_Sub_Channel=lead$FINAL_SUB_CHANNEL, Lead_Count=lead$LEAD_COUNT)
stage_c <- data.frame(Stage_Lead_ID=stage$S_LEAD_ID, Stage_IC_ID=stage$S_INTERESTED_COURSE_ID, Stage_App_ID=stage$S_ONLINE_APPLICATION_ID, Stage_Lead_Date=stage$S_LEAD_CREATED_DATE, Stage_IC_Date=stage$S_IC_CREATED_DATE, Stage_App_Date=stage$S_APPLICATION_CREATED_DATE, Stage_Payment_Date=stage$S_LAST_STAGE_CHANGE_DATE, Stage_Email=stage$S_EMAIL, Stage_Country=stage$S_COUNTRY_PROPER, Stage_Work_Ex=stage$WORK_EXPERIENCE_SLAB, Stage_Income_Slab=stage$INCOME_SLAB, Stage_Gender=stage$GENDER, Stage_Industry=stage$S_INDUSTRY, Stage_Function=stage$S_FUNCTION, Stage_Job_Title=stage$S_JOB_TITLE, Stage_App_Name=stage$S_ONLINE_APPLICATION_NAME, Stage_Prog_Code=stage$S_PROGRAM_CODE, Stage_Batch_ID=stage$S_BATCH_ID, Stage_Cohort=stage$PROGRAM_UNIQUE_NAME_AS_PER_STAGE, Stage_Channel=stage$S_FINAL_CHANNEL, Stage_Sub_Channel=stage$S_FINAL_SUB_CHANNEL, Stage_App=stage$APP, Stage_Paid_App=stage$PAID_APP)

combine_data = merge(lead_c, stage_c, by.x = 'Lead_IC_ID', by.y = 'Stage_IC_ID', all.x = T, all.y = F)

nrow(combine_data) - sum(is.na(combine_data$Stage_Lead_ID))

stage_combine_data <- combine_data[!is.na(combine_data$Stage_Lead_ID),]

write.csv(stage_combine_data, "stage_combine_data.csv", row.names = F)

sum(is.na(lead$WORK_EXPERIENCE_SLAB))

na_work_ex <- lead[is.na(lead$WORK_EXPERIENCE_SLAB),]
write.csv(na_work_ex, "na_work_ex.csv")

stage$S_UTM_CAMPAIGN_ID <- as.character(stage$S_UTM_CAMPAIGN_ID)
stage$S_UTM_ADSET_ID <- as.character(stage$S_UTM_ADSET_ID)
stage$S_UTM_AD_ID <- as.character(stage$S_UTM_AD_ID)

write.csv(stage, "stage.csv")

str(stage)

check_unique_IC <- data.frame(stage$S_INTERESTED_COURSE_ID)
nrow(check_unique_IC)

rm(check_unique_IC)

check_unique_IC <- unique(check_unique_IC)

str(stage)

write.xlsx(stage, dir_path, sheetName="stage", col.names=TRUE, row.names=TRUE, append=FALSE)

checknos <- data.frame(Cam_Id=lead$UTM_CAMPAIGN_ID, Ad_Id=lead$UTM_AD_ID)

checknos <- unique(checknos)

write.xlsx(checknos,
           Save_As_Path,
           sheetName = "Sheet1",
           col.names = TRUE,
           row.names = TRUE,
           append = FALSE,
           showNA = TRUE,
           password = NULL)


# Kellogg Lead WORKING ----

lead_c <- data.frame(Lead_Lead_ID=lead$LEAD_ID,
         Lead_IC_ID=lead$INTERESTED_COURSE_ID,
         Lead_Lead_Date=lead$LEAD_CREATED_DATE,
         Lead_IC_Date=lead$IC_CREATED_DATE,
         Lead_Email=lead$LEAD_EMAIL,
         Lead_Country=lead$LEAD_COUNTRY_PROPER,
         Lead_Programme=lead$LEAD_PROGRAM,
         Lead_Cohort=lead$PROGRAM_UNIQUE_NAME_AS_PER_LEAD,
         Lead_School=lead$SCHOOL,
         Lead_Status=lead$IC_STATUS)

stage_c <- data.frame(Stage_IC_ID=stage$S_INTERESTED_COURSE_ID,
          Stage_App_ID=stage$S_ONLINE_APPLICATION_ID,
          Stage_Lead_Date=stage$S_LEAD_CREATED_DATE,
          Stage_IC_Date=stage$S_IC_CREATED_DATE,
          Stage_App_Date=stage$S_APPLICATION_CREATED_DATE,
          Stage_Payment_Date=stage$S_LAST_STAGE_CHANGE_DATE,
          Stage_Cohort=stage$PROGRAM_UNIQUE_NAME_AS_PER_STAGE,
          Stage_Paid_App=stage$PAID_APP,
          Stage_School=stage$SCHOOL)

lead_c <- lead_c[(lead_c$Lead_School == "Kellogg"),]
lead_c <- lead_c[(lead_c$Lead_Status == 1),]
stage_c <- stage_c[(stage_c$Stage_School == "Kellogg"),]
lead_c$Lead_School = NULL
lead_c$Lead_Status = NULL
stage_c$Stage_School = NULL

combine_data = merge(lead_c, stage_c, by.x = 'Lead_IC_ID', by.y = 'Stage_IC_ID', all.x = T, all.y = F)
rm(lead_c, stage_c)

call_dump = read.csv(text=paste0(head(readLines("call_dump_2020-04-01.csv"), -7), collapse="\n"), stringsAsFactors = F)
call_dump$Lead_ID_15 <- substr(call_dump$Lead.Id, 1, 15)
call_dump$Created.Date <- as.Date(call_dump$Created.Date,"%m/%d/%Y")
call_dump$Lead.Id = NULL

call_dump <- merge(call_dump, combine_data, by.x = 'Lead_ID_15', by.y = 'Lead_Lead_ID', all.x = T, all.y = F)
call_dump_backup <- call_dump
call_dump <- call_dump[!is.na(call_dump$Lead_IC_Date),]

write.csv(call_dump, "call_dump.csv")

# Masking script ----
dir()
data = read.csv("visitorActivityExport.csv", header=T, stringsAsFactors = F)
dim(data)
head(data,5)
names(data)[names(data)=="ï..Prospect"]="EMAIL_ID"
names(data)[names(data)=="Date...Time"]="DATE_TIME"

names(data) = toupper(names(data))

data$email_char = nchar(data$EMAIL_ID, type = "chars", allowNA = F, keepNA = NA)

data$email_char_right = substr(data$EMAIL_ID, 4, (data$email_char))

data$masked_xxxx ="XXXXXXX"
data$email_id = paste0(data$masked_xxxx, data$email_char_right)

visitorActivityExportV2 = data.frame(data)

visitorActivityExportV2$EMAIL_ID = NULL
visitorActivityExportV2$email_char = NULL
visitorActivityExportV2$email_char_right = NULL
visitorActivityExportV2$masked_xxxx = NULL

write.csv(visitorActivityExportV2, "visitorActivityExportV2.csv")

# SUMMARY ----
# mysummary =
#   function(dataset){
#     var_names = names(dataset)
#     class_var = sapply(dataset,class)
#     missing = sapply(dataset , function(x){sum(is.na(x))})
#     uniques = sapply(dataset ,function(x){length(unique(x))})
#     missing_percentage = sapply(dataset,function(x){(sum(is.na(x))/nrow(dataset))*100})
#     Min = sapply(dataset, function(x){return(toString(if(class(x)!="character"){min(x, na.rm = TRUE)}))})
#     Max = sapply(dataset, function(x){return(toString(if(class(x)!="character"){max(x, na.rm = TRUE)}))})
#     Std.Dev = sapply(dataset, function(x){return(toString(if(class(x)!="character"){sd(x, na.rm = TRUE)}))})
#     Quantiles = sapply(dataset, function(x){return(toString(if(class(x)!="character"){quantile(x, na.rm = TRUE)}))})
#     data_summary = data.frame(names(dataset),class_var, uniques , missing  , missing_percentage , Min ,Max , Std.Dev , Quantiles)
#     return(data_summary)
#   }

# IMPORTANT dplyr ----
  
  
github_issues %>% 
  select(-starts_with("user."), -starts_with("milestone."), 
         -starts_with("pull_"), -ends_with("url")) %>%
  select(starts_with("assignee"))