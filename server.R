#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
library(randomForest)
library(e1071)
## load data from UCI database
file_url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00451/dataR2.csv"
breast <- data.frame()
if (dim(breast)[1] == 0 )
    breast <- read.csv(file_url)

# change some info into factor
breast$Classification[breast$Classification == 1] <- "Healthy"
breast$Classification[breast$Classification == 2] <- "Patient"
breast$Classification <- factor(breast$Classification)
# creat a subset of confirm death
# split data into training and testing set
in_train <- createDataPartition(y = breast$Classification, p = 0.7, list = FALSE)
training <- breast[in_train, ]
testing <- breast[-in_train,]

# random forest model
t_control <- trainControl(method = "repeatedcv", number = 5, repeats = 15)
# rffit <- train(factor(Classification) ~ .,data = training, method = "rf", ntree = 10, trControl = t_control)
rffit <- train(factor(Classification) ~ Glucose + Resistin + HOMA + Insulin + BMI + Age ,data = training, method = "rf",ntrees = 10,  trControl = t_control)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    prediction <- reactive({
        con1 <- data.frame(Age = input$age,
                       BMI = input$bmi,
                       Glucose = input$glucose,
                       Insulin = input$insulin,
                       HOMA = input$homa, 
#                       Leptin = input$leptin,
#                       Adiponectin = input$adiponectin,
                       Resistin = input$resistin
#                       MCP.1 = input$mcp1
                       )
     pred1 <- predict(rffit, newdata = con1)
    pred1
    })
#    output$test <- renderText({
#        prediction()
#    })
    output$pred <- renderText({
        if (prediction() == "Healthy"){
            "Healthy"
        }else if (prediction() == "Patient")
        {"Patient"}
        else {"No resualt"}
    })
    output$recom <- renderText({
        if (prediction() == "Healthy"){
            paste("Congratulations! ",
            "You are in good condiction, Please take examinations regularly")
        }else if (prediction() == "Patient"){
            paste("Please,",
                  "consult your doctor and run a full test to confirm.")}
        else {"No resualt"} 
    })
    
})
