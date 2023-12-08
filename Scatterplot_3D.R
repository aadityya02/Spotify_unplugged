library(scatterplot3d)
library(dplyr)

spotify_data <- read.csv("C:/Users/91879/OneDrive/Desktop/Spotify Unplugged/qwerty.csv")
selected_columns <- c("danceability", "energy", "valence", "instrumentalness", "speechiness", "liveness")

selected_data <- spotify_data %>% select(selected_columns)

selected_data <- na.omit(selected_data)

scatterplot3d(
  selected_data$danceability,
  selected_data$energy,
  selected_data$valence,
  color = selected_data$danceability,  
  pch = 16, 
  main = "3D Scatter Plot",
  xlab = "Danceability",
  ylab = "Energy",
  zlab = "Valence"
)
