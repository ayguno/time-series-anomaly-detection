library(shiny)
library(shinyjs)
library(shinymaterial)

ui <- material_page(
    
    useShinyjs(),
    
    title = " Univariate Time-series Anomaly Detective",
    
    nav_bar_color = 'black',
    
    
    tags$head(
        tags$style(HTML("h6 {color: whitesmoke; font-weight: bold;
                            }.shiny-notification {
                                              background-color:#6a1b9a;
                                              color: #fff;
                                              font-size: 15pt;
                                              height: 100px;
                                              width: 700px;
                                              position:fixed;
                                              top: calc(50% - 50px);;
                                              left: calc(60% - 400px);;
                         }
                                            
                         .grey.lighten-4{

                            background-color:black !important
                         }                   
                         .card-content{
                            background-color:#704899 !important;
                            color: whitesmoke;
                            border:none;
                            box-shadow: 0px 0px 16px 0px  whitesmoke;
                         }
                         .card {
                            padding: 0px;
                            border-radius: 0px 0px 5px 5px;
                            box-shadow: 0px 0px 16px 0px  whitesmoke;
                         }
                         .card-title {
                            font-size: 20px !important;
                            font-weight: 300;
                         }
                        
                         .datepicker-table{
                            background-color: whitesmoke;
                         } 
                         
                         .datepicker-day-button{
                            color: #343151;
                         }
                         
                         .datepicker-date-display{
                            background-color:#0668d1 !important;
                         }
                         
                         .is-selected{
                            background-color:#0668d1 !important;
                         }
                         
                         .tab{
                            
                            background-color:#343151 !important;
                         }
                         
                         .purple-text{
                         
                            font-size: 20pt !important;
                            border-radius: 10px 10px 10px 10px;
                             
                         }
                        
                         .purple-text.active {
                            
                            background-color: #704899  !important;
                            color: whitesmoke !important;
                            
                             
                         }
                        .purple-text:hover {
                            background-color: #64b5f6  !important;

                            
                        }
                        
                        .btn{
                            background-color: #311b92  !important;
                            border-radius: 10px 10px 10px 10px;
                        } 
                        
                        .btn:hover{
                            background-color: #64b5f6  !important;
                            box-shadow: 0px 0px 16px 0px  whitesmoke !important;
                        } 
                        
                        .select-dropdown.dropdown-trigger{
                            color: whitesmoke !important;
                            font-size: 20px !important;
                            font-weight: 300;
                        }
                        
                        .datepicker.shiny-material-date-picker.shiny-bound-input{
                            color: whitesmoke !important;
                            font-size: 20px !important;
                            font-weight: 300;
                        }
                        
                        "))
    ),
    
    material_row(
    
        material_row(
            
            material_column(width = 12,
            
                           
                                          HTML('<center><img src="analytics1.jpg", width = "100%", height = "80px"></center>')
                                          
                                         
            )
            
        ),
        
        # Column to keep inputs
        material_column(width = 3,
            
           # tags$br(),            
            
            
            material_card(title = "Provide information about your time-series:",
                          depth = 5,
                          
                    material_row(
                      
                            material_column(width = 12,
                              material_card(depth = 5,
                                tags$h6("Provide your series a csv file:"),
                                
                                uiOutput("file_input_ui")
                                
                               
                               
                              )
                        
                           )
                    
                    ),
                    
                    material_row(
                        
                        material_column(width = 12,
                                        material_card(depth = 5,
                                                      tags$h6("What is the frequency of your series?"),
                                                      material_dropdown(input_id = "series_frequency", label = "Frequency", color = "INDIGO", 
                                                                        choices = c(Monthly = 12, Quarterly = 4, Yearly = 1))
                                                      
                                                      
                                        )
                                        
                        )
                        
                    ),
                    
                    material_row(
                        
                        material_column(width = 12,
                                        material_card(depth = 5,
                                                      tags$h6("What is the starting date of your series?"),
                                                      material_date_picker(input_id = "series_startdate", 
                                                                           label = "Start date", 
                                                                            value = "Jul 4, 2020")
                                                      
                                                      
                                        )
                                        
                        )
                        
                    ),
                    
                    material_row(
                        
                        material_column(width = 4,
                                        material_button(input_id = "anomaly_search", label = "Monitor anomalies", color = "INDIGO", depth = 5)
                                        
                        ),
                        material_column(width = 4,
                                        material_button(input_id = "download_report", label = "Download report", color = "INDIGO",depth = 5)
                                        
                        ),
                        
                        material_column(width = 4,
                                        material_button(input_id = "start_over", label = "Start over again", color = "INDIGO",depth = 5)
                                        
                        )
                        
                    )
                    
                      
            ),
           
            
           
            material_card(depth = 5,
                        tags$br(),
                        material_row(
                              material_column(width = 3,{}),
                              material_column(width = 7,
                                              material_modal(
                                                  modal_id = "example_modal",
                                                  floating_button = FALSE,
                                                  button_depth = 5,
                                                  button_color = "purple accent-3",
                                                  button_text = "How does it work?",
                                                  button_icon = "open_in_browser",
                                                  title = "510(k) Timeline Predictor App",
                                                  tags$p("This application is built on a unique principle that
                                                                integrates Python and R computing languages into an R shiny 
                                                                web app framework. "),
                                                  HTML('<center><img src="analytics.jpg", width = "700px", height = "400px"></center>')
                                                  #tags$img(src = "principle.jpg", width = "500px", height = "400px")
                                              )
                                              
                              ),
                              material_column(width = 2,{})
                        )
                
            )
                          
        ),
        
        # Column to present plots
        material_column(width = 9,
            
                        material_row(),
                        material_tabs(color = "purple",
                            tabs = c(
                                "Normalized Anomaly Score" = "first_tab",
                                "Z-score from STL remainder" = "second_tab"
                            )
                        ),
                        
                        tags$br(),
                        
                        material_tab_content(
                            tab_id = "first_tab",
                            
                            material_row(
                                
                                material_card(title = "Normalized Anomaly Score",
                                              depth = 5,
                                              plotlyOutput(outputId = "norm_anom_plot",height = 350),
                                              tags$br()
                                              
                                ),
                            ),
                            
                            
                            
                            material_row(
                                
                                material_card(title = "STL decomposition of your series", depth = 5,
                                              plotlyOutput(outputId = "mstl_plot1", height = 800, width = "92%")
                                )
                                
                            )   
                        ),
                        
                        material_tab_content(
                            tab_id = "second_tab",
                            
                            material_row(
                            
                                material_card(title = "Z-score from STL remainder",
                                              depth = 5,
                                              plotlyOutput(outputId = "z_score_plot",height = 350),
                                              tags$br()
                                              
                                ),
                            ),    
                                
                            material_row(
                                
                                material_card(title = "STL decomposition of your series", depth = 5,
                                              plotlyOutput(outputId = "mstl_plot2", height = 800, width = "92%")
                                )
                                
                            )   
                        )
                        
    
                                 
                        
                        
                        
        )
        
    )
    
)


