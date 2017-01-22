# BSD_2_clause

shinyServer(function(input, output, session) {


  ## Global variables needed throughout the app
  rv <- reactiveValues(
    login = FALSE,
    the_list = FALSE
  )

  is_in <- reactive({
    rv$login
  })

  ## Authentication
  accessToken <- callModule(gar_auth_js, "auth_demo")

  userDetails <- reactive({
    validate(
      need(accessToken(), "")
    )
    rv$login <- TRUE
    token <- with_shiny(get_user_info, shiny_access_token = accessToken())
    if(whitelist(token, c("jacob.w.malcom@gmail.com",
                          "jakeli81@gmail.com"))) {
      rv$the_list <- TRUE
    }
    return(token)
  })

  ## Display user's Google display name after successful login
  output$display_username <- renderText({
    validate(
      need(userDetails(), "")
    )
    if(!rv$login) return("Hello")
    userDetails()$displayName
  })

  ## Workaround to avoid shinyaps.io URL problems
  observe({
    if (rv$login) {
      shinyjs::onclick("auth_demo-logout",
                       shinyjs::runjs("window.location.href = 'http://127.0.0.1:1221';"))
                       # shinyjs::runjs("window.location.href = 'https://cci-dev.org/shiny/open/test-gauth';"))
    }
  })

  output$the_page <- renderUI({
    if(!rv$login | !rv$the_list) {
      if(!rv$login) {
        pg <- {
          fluidRow(
            style = "padding:20px",
            column(4),
            column(4,
              h1("Restricted app"),
              tags$p("The app you are trying to reach, ESAdocs, has restricted
                     access. Please log in with a Google account (or domain
                     served by Google) to see if you have access.")
            )
          )
        }
        return(pg)
      } else {
        pg <- {
          fluidRow(
            style = "padding:20px",
            column(4),
            column(4,
              h1("Restricted"),
              tags$p("The app you are trying to reach, ESAdocs, has restricted
                     access. Please contact esa@defenders.org to request access.")
            )
          )
        }
        return(pg)
      }
    } else {
      # pg <- esadocs_page
      pg <- fluidRow(
              br(),
              tags$p("help")
            )
      return(pg)
    }
  })

})
