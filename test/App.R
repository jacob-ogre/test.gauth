
library(shiny)
library(googleAuthR)
library(googleID)

options(shiny.port = 1221)
options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/userinfo.email",
                                        "https://www.googleapis.com/auth/userinfo.profile"))
options("googleAuthR.webapp.client_id" = "1080203332657-vcv0o01hrn5ks1am2igt2f0uf15hh0lq.apps.googleusercontent.com")
options("googleAuthR.webapp.client_secret" = "-rbbygwidl32objUNBCVw-Fg")

ui <- shinyUI(fluidPage(
  # googleAuthUI("example1"),
  gar_auth_jsUI("auth_demo",
                login_class = "btn btn-default",
                logout_class = "btn btn-warning",
                login_text = "Log In",
                logout_text = "Log Out"),
  p("Logged in as: ", textOutput("user_name"))
))

server <- shinyServer(function(input, output, session) {
  # access_token <- callModule(googleAuth, "example1")
  access_token <- callModule(gar_auth_js, "auth_demo")

  ## to use in a shiny app:
  user_details <- reactive({
    validate(
      need(access_token(), "Authenticate")
    )
    with_shiny(get_user_info, shiny_access_token = access_token())
  })

  output$user_name <- renderText({
    validate(
      need(user_details(), "getting user details")
    )
    user_details()$displayName
  })
})

shinyApp(ui = ui, server = server)

# library(shiny)
# library(googleAuthR)
# library(googleID)
#
# if(options()$googleAuthR.webapp.client_id != "") {
#   options(httr_oauth_cache = FALSE)
#   options(googleAuthR.scopes.selected = "")
#   options("googleAuthR.webapp.client_id" = "")
#   options("googleAuthR.webapp.client_secret" = "")
# }
#
# options(httr_oauth_cache = FALSE)
# options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/userinfo.email",
#                                         "https://www.googleapis.com/auth/userinfo.profile"))
# options("googleAuthR.webapp.client_id" = "1080203332657-vcv0o01hrn5ks1am2igt2f0uf15hh0lq.apps.googleusercontent.com")
# options("googleAuthR.webapp.client_secret" = "-rbbygwidl32objUNBCVw-Fg")
#
# print(options())
#
#
# ui <- shinyUI(fluidPage(
#
#   gar_auth_jsUI("auth_demo",
#                 login_class = "btn btn-default",
#                 logout_class = "btn btn-warning",
#                 login_text = "Log In",
#                 logout_text = "Log Out"),
#   p("Logged in as: ", textOutput("user_name"))
#
# ))
#
#
# server <- shinyServer(function(input, output, session) {
#
#   access_token <- callModule(gar_auth_js, "auth_demo")
#
#   ## to use in a shiny app:
#   user_details <- reactive({
#     validate(
#       need(access_token(), "Authenticate")
#     )
#
#     with_shiny(get_user_info, shiny_access_token = access_token())
#
#   })
#
#   output$user_name <- renderText({
#     validate(
#       need(user_details(), "getting user details")
#     )
#
#     user_details()$displayName
#
#   })
#
#
# })
#
# # Run the application
# shinyApp(ui = ui, server = server)
