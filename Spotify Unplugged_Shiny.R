library(shiny)
library(dplyr)

spotify_data <- read.csv("C:/Users/91879/OneDrive/Desktop/Spotify Unplugged/qwerty.csv")  

ui <- fluidPage(
  tags$head(
    tags$style(
      HTML("
        body {
          background-color: #f5f5f5; 
          font-family: 'Arial', sans-serif;
          color: #333333; 
        }
        .title {
          text-align: center;
          margin-bottom: 20px;
          font-size: 65px; 
          font-weight: bold; 
          color: #1DB954;
        }
        .subtitle {
          text-align: right; 
          margin-bottom: 10px;
          font-style: italic;
          color: #666666; 
          font-size: 14px; 
        }
        .panel {
          background-color: #ffffff; 
          border-radius: 5px;
          box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
          padding: 20px;
          margin-bottom: 20px;
        }
        .btn-primary {
          background-color: #1DB954; 
          border-color: #1DB954;
          color: #ffffff; 
          margin-top: 40px; 
        }
        .btn-primary:hover {
          background-color: #0E8040; 
          border-color: #0E8040;
        }
        .predictedDanceability {
          font-size: 50px; 
          font-weight: bold;
          margin-bottom: 20px;
          color: #1DB954; 
        }
        .emoji {
          font-size: 40px;
        }
      ")
    )
  ),
  div(
    class = "title",
    HTML("🎵 SPOTIFY UNPLUGGED 🎵 <span class='emoji'>&#x1F3B7;</span>") 
  ),
  div(
    class = "subtitle",
    align = "right", 
    tags$h6(HTML("Aditya Pratap Singh - 21ESKCX005")),
    tags$h6(HTML("Kanak Soni - 21ESKCX030")),
    tags$h6(HTML("Submitted to - Mr. Sumit Kumar Mathur"))
  ),
  div(class = "panel",
      sidebarLayout(
        sidebarPanel(
          sliderInput("liveness", "Liveness:", min = 0, max = 1, value = 0.5),
          sliderInput("energy", "Energy:", min = 0, max = 1, value = 0.5),
          sliderInput("instrumentalness", "Instrumentalness:", min = 0, max = 1, value = 0.5),
          sliderInput("speechiness", "Speechiness:", min = 0, max = 1, value = 0.5),
          actionButton("predictButton", "Predict", class = "btn-primary"),
          br(), 
          actionButton("likeButton", "Like ❤️") 
        ),
        mainPanel(
          div(textOutput("predictedDanceability"), class = "predictedDanceability"),
          verbatimTextOutput("likedPredictions") 
        )
      )
  )
)
likes <- reactiveVal(0)
liked_predictions <- reactiveVal(character(0))

selected_columns <- c("liveness", "danceability", "energy", "instrumentalness", "speechiness")
selected_data <- spotify_data %>% select(selected_columns)
selected_data <- selected_data %>%
  filter(!is.na(danceability) & is.finite(danceability))

lm_model <- lm(danceability ~ ., data = selected_data)

server <- function(input, output) {
  observeEvent(input$predictButton, {
    new_data <- data.frame(
      liveness = input$liveness,
      energy = input$energy,
      instrumentalness = input$instrumentalness,
      speechiness = input$speechiness
    )
    predicted_danceability <- round(predict(lm_model, newdata = new_data), 2)
    output$predictedDanceability <- renderText({
      paste("Predicted Danceability🎶:", predicted_danceability)
    })
  })
  observeEvent(input$likeButton, {
    liked_predictions(paste(liked_predictions(), isolate(input$predictedDanceability)))
    likes(likes() + 1)
    showModal(modalDialog(
      title = "Liked!",
      paste("Added to liked Predicted Danceability:", input$predictedDanceability)
    ))
  })
  
  output$likesCount <- renderText({
    paste("Likes: ", likes())
  })
}

shinyApp(ui = ui, server = server)
