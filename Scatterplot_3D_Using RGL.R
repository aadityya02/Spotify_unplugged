library(rgl)
library(dplyr) 
spotify_data <- read.csv("C:/Users/91879/OneDrive/Desktop/Spotify Unplugged/qwerty.csv")

spotify_data <- data.frame(
  danceability = runif(100),  
  energy = runif(100),        
  valence = runif(100),       
  instrumentalness = runif(100), 
  speechiness = runif(100),      
  liveness = runif(100)            
)


open3d()

plot3d(
  spotify_data$danceability,
  spotify_data$energy,
  spotify_data$valence,
  col = rainbow(length(spotify_data$danceability)),  
  xlab = "Danceability",
  ylab = "Energy",
  zlab = "Valence",
  type = 's',  
  size = 1.5   
)

points3d(
  spotify_data$instrumentalness,
  spotify_data$speechiness,
  spotify_data$liveness,
  col = rainbow(length(spotify_data$danceability)),  
  size = 1.5  
)

rgl.viewpoint(theta = 120, phi = 30, fov = 60, zoom = 0.8)

rglwidget()


