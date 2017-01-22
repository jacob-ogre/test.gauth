
library(dplyr)
library(elastic)
library(esadocs)
library(ggplot2)
library(ggthemes)
library(googleAuthR)
library(googleID)
library(shiny)
library(shinyBS)
library(shinydashboard)
library(shinyjs)
library(shinythemes)
library(stringr)

options(httr_oauth_cache=T)
options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/userinfo.email",
                                        "https://www.googleapis.com/auth/userinfo.profile"))
options("googleAuthR.webapp.client_id" = "1080203332657-vcv0o01hrn5ks1am2igt2f0uf15hh0lq.apps.googleusercontent.com")
options("googleAuthR.webapp.client_secret" = "-rbbygwidl32objUNBCVw-Fg")

source("support.R")
source("esadocs_page.R")

# print(options())

