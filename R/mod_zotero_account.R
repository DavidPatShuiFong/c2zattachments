#' zotero_account UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList tags h2 h4 numericInput passwordInput
mod_zotero_account_ui <- function(id) {
  ns <- NS(id)
  tagList(
    # remove 'step' arrows from numericInput
    # code from
    # https://stackoverflow.com/questions/70974838/removing-up-down-arrows-from-numericinput-r-shiny
    tags$head(
      tags$style(HTML("
        input[type=number] {
              -moz-appearance:textfield;
        }
        input[type=number]::{
              -moz-appearance:textfield;
        }
        input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
              -webkit-appearance: none;
              margin: 0;
        }"
      ))
    ),
    h2("Zotero API credentials"),
    numericInput(
      inputId = ns("UserID"),
      label = "User ID",
      value = NULL,
      min = 0
    ),
    passwordInput(
      inputId = ns("UserPassword"),
      label = "User Password",
      placeholder = "Enter here..."
    ),
    hr(
      .noWS = "after-begin"
    ),
    em(
      "These are Zotero API credentials, not Zotero username/e-mail and password!",
      "For more details, see documentation in Øystein Olav Skaar's",
      tags$a(
        "c2z 'Create a Zotero API key'",
        href = "https://oeysan.github.io/c2z/articles/zotero_api.html",
        target = "_blank",
        .noWS = "after"
      ),
      "."
    ),
    em(
      "Zotero API keys can be stored, and will be read, from environment variables",
      "'ZOTERO_USER' and 'ZOTERO_API'."
    )
  )
}

#' zotero_account Server Functions
#'
#' @noRd
#'
#' @importFrom shiny observeEvent
mod_zotero_account_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    observeEvent(
      input$UserID,
      # initialize UserID if environment variable ZOTERO_USER is defined
      ignoreNULL = FALSE,
      ignoreInit = FALSE,
      once = TRUE,
      {
        UserID <- Sys.getenv("ZOTERO_USER")
        if (nchar(UserID) > 0) {
          # if not an empty string
          # no check if UserID is valid
          updateNumericInput(
            inputId = "UserID",
            value = UserID
          )
        }
      }
    )

    # a dataframe containing the two user inputs from this module
    dataframe <- reactive({
      data.frame(
        UserID = input$UserID,
        UserPassword = input$UserPassword,
      )
    })

    return(dataframe)
  })
}

## To be copied in the UI
# mod_zotero_account_ui("zotero_account_1")

## To be copied in the server
# mod_zotero_account_server("zotero_account_1")
