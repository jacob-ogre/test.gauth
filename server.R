
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

shinyServer(function(input, output, session) {

  ## Global variables needed throughout the app
  rv <- reactiveValues(
    login = FALSE
  )

  ## Authentication
  accessToken <- callModule(gar_auth_js, "auth_demo")

  userDetails <- reactive({
    validate(
      need(accessToken(), "not logged in")
    )
    rv$login <- TRUE
    with_shiny(get_user_info, shiny_access_token = accessToken())
  })

  ## Display user's Google display name after successful login
  output$display_username <- renderText({
    validate(
      need(userDetails(), "getting user details")
    )
    userDetails()$displayName
  })

  ## Workaround to avoid shinyaps.io URL problems
  observe({
    if (rv$login) {
      shinyjs::onclick("gauth_login-googleAuthUi",
                       shinyjs::runjs("window.location.href = 'https://yourdomain.shinyapps.io/appName';"))
    }
  })

  output$messageMenu <- renderMenu({
    if(rv$login) {
      dropdownMenu(
        type = "messages",
        badgeStatus = NULL,
        icon = icon("check"),
        messageItem(
          from = "test.gauth",
          message = paste("Logged in as", userDetails()$displayName)
        )
      )
    } else {
      dropdownMenu(
        type = "messages",
        badgeStatus = NULL,
        icon = icon("sign-in", "fa-1x"),
        messageItem(
          from = "test.gauth",
          message = "Please log in with Google"
        )
      )
    }
  })

  output$the_page <- renderUI({
    if(rv$login) {
      pg <- {
        fluidRow(
          style = "padding:20px",
          column(2),
          column(10,
                 p("I'm in!")
          )
        )
      }
      return(pg)
    } else {
      pg <- {
        fluidRow(
          style = "padding:20px",
          column(12,
            h1("Restricted app"),
            tags$p("Please log in to view the app.")
          )
        )
      }
      return(pg)
    }
  })

})
