# Load necessary libraries
library(dplyr)
library(caTools)
library(caret)

# Load the dataset (replace 'path_to_file' with the actual path)
spotify_data <- read.csv(file.choose("C:/Users/91879/OneDrive/Desktop/qwerty.csv"))

# Selecting relevant columns
selected_columns <- c("liveness", "danceability", "energy", "instrumentalness", "speechiness")

# Creating a new dataframe with selected columns
selected_data <- spotify_data %>% select(selected_columns)

# Check for missing or infinite values in 'danceability' column
selected_data <- selected_data %>%
  filter(!is.na(danceability) & is.finite(danceability))

# Splitting the data into training and testing sets (80% training, 20% testing)
set.seed(123)
split <- createDataPartition(seq_len(nrow(selected_data)), p = 0.8, list = FALSE)
train_data <- selected_data[split, ]
test_data <- selected_data[-split, ]

# Building the linear regression model
lm_model <- lm(danceability ~ ., data = train_data)

# Make predictions on the test set
predictions <- predict(lm_model, newdata = test_data)

# Calculate accuracy (use appropriate evaluation metrics for regression)
accuracy <- sqrt(mean((test_data$danceability - predictions)^2, na.rm = TRUE))
accuracy