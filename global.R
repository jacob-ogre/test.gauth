
# library(dplyr)
# library(elastic)
# library(esadocs)
# library(ggplot2)
# library(ggthemes)
library(googleAuthR)
library(googleID)
library(shiny)
# library(shinyBS)
library(shinydashboard)
library(shinyjs)
# library(stringr)

# if(options()$googleAuthR.webapp.client_id != "") {
#   options(httr_oauth_cache = "")
#   options(googleAuthR.scopes.selected = "")
#   options("googleAuthR.webapp.client_id" = "")
#   options("googleAuthR.webapp.client_secret" = "")
# }

options(httr_oauth_cache=F)
options(shiny.port = 1221)
options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/userinfo.email",
                                        "https://www.googleapis.com/auth/userinfo.profile"))
options("googleAuthR.webapp.client_id" = "1080203332657-vcv0o01hrn5ks1am2igt2f0uf15hh0lq.apps.googleusercontent.com")
options("googleAuthR.webapp.client_secret" = "-rbbygwidl32objUNBCVw-Fg")

# print(options())

# # All the code in this file needs to be copied to your Shiny app, and you need
# # to call `withBusyIndicatorUI()` and `withBusyIndicatorServer()` in your app.
# # You can also include the `appCSS` in your UI, as the example app shows.
#
# # =============================================
# # Set up a button to have an animated loading indicator and a checkmark
# # for better user experience
# # Need to use with the corresponding `withBusyIndicator` server function
# withBusyIndicatorUI <- function(button) {
#   id <- button[['attribs']][['id']]
#   div(
#     `data-for-btn` = id,
#     button,
#     span(
#       class = "btn-loading-container",
#       hidden(
#         img(src = "ajax-loader-bar.gif", class = "btn-loading-indicator"),
#         icon("check", class = "btn-done-indicator")
#       )
#     ),
#     hidden(
#       div(class = "btn-err",
#           div(icon("exclamation-circle"),
#               tags$b("Error: "),
#               span(class = "btn-err-msg")
#           )
#       )
#     )
#   )
# }
#
# # Call this function from the server with the button id that is clicked and the
# # expression to run when the button is clicked
# withBusyIndicatorServer <- function(buttonId, expr) {
#   # UX stuff: show the "busy" message, hide the other messages, disable the button
#   loadingEl <- sprintf("[data-for-btn=%s] .btn-loading-indicator", buttonId)
#   doneEl <- sprintf("[data-for-btn=%s] .btn-done-indicator", buttonId)
#   errEl <- sprintf("[data-for-btn=%s] .btn-err", buttonId)
#   disable(buttonId)
#   show(selector = loadingEl)
#   hide(selector = doneEl)
#   hide(selector = errEl)
#   on.exit({
#     enable(buttonId)
#     hide(selector = loadingEl)
#   })
#
#   # Try to run the code when the button is clicked and show an error message if
#   # an error occurs or a success message if it completes
#   tryCatch({
#     value <- expr
#     show(selector = doneEl)
#     delay(2000, hide(selector = doneEl, anim = TRUE, animType = "fade",
#                      time = 0.5))
#     value
#   }, error = function(err) { errorFunc(err, buttonId) })
# }
#
# # When an error happens after a button click, show the error
# errorFunc <- function(err, buttonId) {
#   errEl <- sprintf("[data-for-btn=%s] .btn-err", buttonId)
#   errElMsg <- sprintf("[data-for-btn=%s] .btn-err-msg", buttonId)
#   errMessage <- gsub("^ddpcr: (.*)", "\\1", err$message)
#   html(html = errMessage, selector = errElMsg)
#   show(selector = errEl, anim = TRUE, animType = "fade")
# }
#
# appCSS <- "
# .btn-loading-container {
# margin-left: 10px;
# font-size: 1.2em;
# }
# .btn-done-indicator {
# color: green;
# }
# .btn-err {
# margin-top: 10px;
# color: red;
# }
# "
#