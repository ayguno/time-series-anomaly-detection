library(shiny)
library(shinymaterial)

shinyServer(function(input, output,session) { 
    
    # this would increase the upload limit to 30MB  
    options(shiny.maxRequestSize=30*1024^2) 
    
    reactive.values <- reactiveValues()
    reactive.values$tsx <- sample.data
    reactive.values$file_upload_status <- NULL
    
    
    # Default tsx observer
    observe({
        
        tsx <- reactive.values$tsx
        
        
        output$z_score_plot <- renderPlotly({
            
            ggplotly(prepareZscoreplot(tsx) )
            
            })
        
        output$norm_anom_plot <- renderPlotly({
            
            ggplotly(prepareNormAnomalyScoreplot(tsx))    
            
            })
        
        output$mstl_plot1 <- renderPlotly(
            
            ggplotly(prepareSTLplot(tsx))
        )
        
        output$mstl_plot2 <- renderPlotly(
            
            ggplotly(prepareSTLplot(tsx))
        )
        
       # shinyjs::reset("csv_file")
        
    })
    
    # when user clicks start over button (id = "start_over")
    observeEvent(input$start_over,{
        
        reactive.values$control.panel.key <- FALSE
        shinyjs::reset("csv_file")
        reactive.values$tsx <- sample.data
        reactive.values$file_upload_status <- NULL
        
        
    },ignoreInit = T, ignoreNULL = F)
    
    
    output$file_input_ui <-  renderUI({
        input$start_over # Creates a dependency with the "start_over" button
        material_file_input(input_id = "csv_file", label = "Upload your series", color = "INDIGO")
        
    })
    
    
    observeEvent(input$csv_file,{
        reactive.values$file_upload_status <- 1
    },ignoreNULL = TRUE, ignoreInit = FALSE)
    
    
    # User clicks monitor button (id = "anomaly_search" ) 
    observeEvent(input$anomaly_search,{
        
        cat("Executed 1\n")
        
        file_upload_status<- reactive.values$file_upload_status
        
        if(is.null(input$csv_file$datapath) | is.null(file_upload_status)){
            sendSweetAlert(
                session = session,
                title =" Please first upload a file !",
                type = "error",
                btn_colors = '#6a1b9a'
            )
            
        } else {
            # Collect user inputs
            x <- read.csv(input$csv_file$datapath)[,1]
            
            #################################################################
            # Handle :
            # If user clicks to monitor button without uploading a file
            # If user provided data is meaningful, convert to time-series
            #################################################################
            
            s.date.test <- input$series_startdate
            cat(paste0(s.date.test,"\n"))
            
            if(s.date.test == ""){
                
                sendSweetAlert(
                    session = session,
                    title =" Please choose a valid start date !",
                    type = "error",
                    btn_colors = '#6a1b9a'
                )
                
            } else {
                
                # Prepare new series to be analyzed
                freq <- as.numeric(input$series_frequency)
                
                cat("Here 1\n")
                
                s.date <- mdy(s.date.test)    
                
                cat("Here 2\n")

                
                if (freq == 1){
                    start.point <- year(s.date)
                } else if (freq == 4) {
                    start.point <- c(year(s.date), quarter(s.date))
                } else {
                    start.point <- c(year(s.date), month(s.date))
                }
                 
                                      
                
                reactive.values$tsx <- ts(x, start = start.point, frequency = freq)
                
                 
                
            }
            
           
            
        }
        
        
        
    
        
        
    },ignoreInit = T, ignoreNULL = F)
    
                    
    
})
    