#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Breast Cancer Prediction"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput("age",
                         label = "Patient's Age:",
                         min = 1,
                         max = 120,
                         step = 1,
                         value = 85),
            numericInput("bmi",
                         label = "BMI(Body mass index, body mass divided by the square of the body height,kg/m2)",
                         min = 1,
                         max = 50,
                         step = .1,
                         value = 26),     
            numericInput("glucose",
                         label = "Glucose(mg/dL)",
                         min = 1,
                         max = 300,
                         step = 0.1,
                         value = 138), 
            numericInput("insulin",
                         label = "Insulin(µU/mL)",
                         min = 1,
                         max = 80,
                         step = .001,
                         value = 19.9), 
            numericInput("homa",
                         label = "HOMA(homeostatic model assessment)",
                         min = .1,
                         max = 50,
                         step = .1,
                         value = 6.7), 
#            numericInput("leptin",
#                         label = "Leptin(ng/mL)",
#                         min = 1,
#                         max = 100,
#                         step = .1,
#                         value = 90), 
#            numericInput("adiponectin",
#                         label = "Adiponectin (µg/mL)",
#                         min = 1,
#                         max = 100,
#                         step = .01,
#                         value = 14.11), 
            numericInput("resistin",
                         label = "Resistin (ng/mL)",
                         min = 1,
                         max = 100,
                         step = .01,
                         value = 4.3), 
#            numericInput("mcp1",
#                         label = "MCP-1(pg/dL)",
#                         min = 1,
#                         max = 2000,
#                         step = .1,
#                         value = 90), 
            submitButton("Submit!")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h1("Overview"),
            h3("Breast cancer is quite common, but if diagnosis early, the prognosis of five-year survival rate if 85% (US, UK)"),
            h3("We use Breast Cancer Coimbra Data Set from UC Irvine Machine Learning Repository"),
            tags$a(href="https://archive.ics.uci.edu/ml/index.php", "UC Irvine Machine Learning Repository"),
            h1("Prediction:"),
            htmlOutput("pred"),
            h1("Recommendations:"),
            htmlOutput("recom")#,
#            htmlOutput("test")
        )
    )
))
