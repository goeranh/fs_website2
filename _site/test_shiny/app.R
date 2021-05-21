# Load packages ----
library(shiny)
library(tidyverse)
library(readxl)


# data --------------------------------------------------------------------

### Kommunid
komid <- read_excel("data/kommunblad/kommunkoder.xlsx") %>% 
  mutate(komkombi = paste(komNr, komnamn))

tmp <- read_excel("data/kommunblad/nyfodda.xlsx") %>% 
  left_join(komid %>% select(komNr, komnamn), by = c("region" = "komNr")) %>% 
  mutate(year = as.numeric(year))  

# varlist <- unique(df_newborn$var_name)
munics <- unique(tmp$komnamn)



shinyApp(
  ui = fluidPage(
    
    sidebarLayout(
      
      sidebarPanel(
        
        selectInput("munic",
                    label = "Kommun",
                    choices = munics,
                    selected = "Härryda"
        ),
        
    # sliderInput("slider", "Slider", 1, 100, 50),
    downloadButton("report", "Generate report")
  ),
  
  mainPanel(
    
    # textOutput("text1"),
    # 
    # plotOutput("plot1")
    
  ))),
  
  
  server = function(input, output) {
    output$report <- downloadHandler(
      # For PDF output, change this to "report.pdf"
      filename = "report.html",
      content = function(file) {
        # Copy the report file to a temporary directory before processing it, in
        # case we don't have write permissions to the current working dir (which
        # can happen when deployed).
        tempReport <- "test_shiny/kommunblad_manus.Rmd"
        file.copy("report.Rmd", tempReport, overwrite = TRUE)
        
        # Set up parameters to pass to Rmd document
        params <- list(studkom = input$munic)
        
        # Knit the document, passing in the `params` list, and eval it in a
        # child of the global environment (this isolates the code in the document
        # from the code in this app).
        rmarkdown::render(tempReport, output_file = file,
                          params = params,
                          envir = new.env(parent = globalenv())
        )
      }
    )
  }
)

# # Run the app
# shinyApp(ui, server)
