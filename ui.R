
header <- dashboardHeader(disable = TRUE)

sidebar <- dashboardSidebar(disable = TRUE)

body <- dashboardBody(
  fluidPage(style="padding:0px",
    title = "test.gauth",
    windowTitle = "nil page",
    fluidRow(style="background-color: #8a8a5c;
                    color: white;
                    font-weight: bold;
                    padding: 5px;
                    margin-top: -15px",
      column(2,
        h4(style="color:white",
           textOutput("display_username"))
      ),
      column(8),
      column(2,
        div(
          style="color:red; float:right",
          gar_auth_jsUI("auth_demo",
                        login_class = "btn btn-default",
                        logout_class = "btn btn-warning",
                        login_text = "Log In",
                        logout_text = "Log Out")
        )
      )
    ),
    fluidRow(
      htmlOutput("the_page")
    )
  )
)

dashboardPage(header, sidebar, body)
