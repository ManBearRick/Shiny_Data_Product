library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict Blood Fat Content with Age"), 
    
    sidebarLayout(  
        
        sidebarPanel( 
            
            sliderInput("sliderAge", "What is the Age of the subject?", 20, 60, value = 35),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            submitButton("Submit") 
        ),
        
        mainPanel(    
            
            plotOutput("plot1"),
            h3("Predicted Blood Fat Content from Model 1:"),
            textOutput("pred1"),
            h3("Predicted Blood Fat Content from Model 2:"),
            textOutput("pred2")
        )
        
    ) 
))  