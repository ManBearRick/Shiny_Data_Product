
library(shiny)
shinyServer(function(input, output) {
    
    url <- "http://people.sc.fsu.edu/~jburkardt/datasets/regression/x09.txt"
    df <- read.table(url, skip = 36)
    names(df) <- c("Index", "Set", "Weight_Kg", "Age", "Blood_Fat_Content")
    
    model1 <- lm(Blood_Fat_Content ~ Age, data = df)

    model2 <- loess(Blood_Fat_Content ~ Age, data = df)

    
    model1pred <- reactive({
        AgeInput <- input$sliderAge
        predict(model1, newdata = data.frame(Age = AgeInput))
    })
    
    model2pred <- reactive({
        AgeInput <- input$sliderAge
        predict(model2, newdata = data.frame(Age = AgeInput))
        
    })
    
    output$plot1 <- renderPlot({
        AgeInput <- input$sliderAge
        plot(df$Age, df$Blood_Fat_Content, pch = 16, col = "black", cex = 0.75,
             main = "Blood Fat Content vs. Age", ylab = "Blood Fat Content",
             xlab = "Age")
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        if(input$showModel2){
            model2lines <- lines(df$Age[order(df$Age)], 
                                 loess(Blood_Fat_Content ~ Age, data = df)$fitted[order(df$Age)],
                                 col = "blue", lwd = 3)
        }
        legend(180, 460, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
               col = c("red", "blue"), bty = "n", cex = 1.2)
        points(AgeInput, model1pred(), col = "red", pch = "O", cex = 2)
        points(AgeInput, model2pred(), col = "blue", pch = "O", cex = 2)
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
})