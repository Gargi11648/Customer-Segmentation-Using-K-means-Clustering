# Customer Segmentation Dashboard (Shiny)
# Run:  shiny::runApp()   (from the project root folder)

library(shiny); library(tidyverse); library(plotly); library(DT)
library(factoextra); library(cluster)
source("R/helpers.R")

df_all <- load_data()

ui <- fluidPage(
  titlePanel("Customer Segmentation Dashboard (K-Means)"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("k", "Number of clusters (K):", min = 2, max = 8, value = 5),
      checkboxGroupInput("features", "Features used for clustering:",
                         choices = c("Age", "Income", "Spending"),
                         selected = c("Age", "Income", "Spending")),
      checkboxGroupInput("gender", "Gender:", choices = levels(df_all$Gender),
                         selected = levels(df_all$Gender)),
      sliderInput("age", "Age range:", min = min(df_all$Age), max = max(df_all$Age),
                  value = range(df_all$Age)),
      helpText("Clustering is run on the filtered customers.")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Segments", plotlyOutput("scatter", height = "480px")),
        tabPanel("Segment Profile", br(), DTOutput("profile"), br(), plotlyOutput("bar")),
        tabPanel("Choose K", plotOutput("elbow"), plotOutput("sil")),
        tabPanel("Customers", br(), DTOutput("table"),
                 downloadButton("dl", "Download CSV"))
      )
    )
  )
)

server <- function(input, output, session) {
  filtered <- reactive({
    df_all |> filter(Gender %in% input$gender, Age >= input$age[1], Age <= input$age[2])
  })

  result <- reactive({
    req(length(input$features) >= 2, nrow(filtered()) > input$k)
    run_kmeans(filtered(), k = input$k, features = input$features)
  })

  output$scatter <- renderPlotly({
    d <- result()$data
    plot_ly(d, x = ~Income, y = ~Spending, color = ~Segment, symbol = ~Gender,
            type = "scatter", mode = "markers", marker = list(size = 9),
            text = ~paste("ID:", CustomerID, "<br>Age:", Age)) |>
      layout(title = "Annual Income vs Spending Score",
             xaxis = list(title = "Annual Income (k$)"),
             yaxis = list(title = "Spending Score"),
             legend = list(orientation = "h"))
  })

  output$profile <- renderDT(datatable(result()$profile, rownames = FALSE,
                                       options = list(dom = "t")))

  output$bar <- renderPlotly({
    p <- ggplot(result()$profile, aes(Cluster, Customers, fill = Segment)) +
      geom_col() + theme_minimal() + labs(title = "Customers per Cluster")
    ggplotly(p)
  })

  output$elbow <- renderPlot({
    req(length(input$features) >= 2)
    fviz_nbclust(scale(filtered()[, input$features]), kmeans, method = "wss", k.max = 10)
  })
  output$sil <- renderPlot({
    req(length(input$features) >= 2)
    fviz_nbclust(scale(filtered()[, input$features]), kmeans, method = "silhouette", k.max = 10)
  })

  output$table <- renderDT(datatable(result()$data, rownames = FALSE,
                                     options = list(pageLength = 10)))
  output$dl <- downloadHandler(
    filename = function() "customers_with_segments.csv",
    content = function(file) write.csv(result()$data, file, row.names = FALSE)
  )
}

shinyApp(ui, server)
