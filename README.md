Overview
This model aims to predict the danceability of songs based on selected features using linear regression. It utilizes Spotify dataset 'qwerty.csv' and employs the following libraries: dplyr, caTools, and caret in R.

File Structure
spotify_data.csv: Dataset used for training and testing.
model.R: R script implementing the model.
README.md: Instructions and information about the model.
Usage
Requirements
R environment with installed libraries: dplyr, caTools, caret.
Instructions
Data Preparation:

Ensure the Spotify dataset ('qwerty.csv') is available in the specified path.
Run the Script:

Open model.R in an R environment.
Update the file path in read.csv() to match the location of your 'qwerty.csv' dataset.
Training and Testing:

The script reads the dataset, selects specific columns, handles missing values, and splits the data into training and testing sets.
Linear regression (lm()) is used to train the model on the training data.
Predictions are made on the test set, and accuracy (RMSE) is computed.
Results
The accuracy of the model on the test set is calculated using RMSE (Root Mean Square Error).

Notes
Ensure R and required libraries are installed.
Consider exploring other algorithms or feature engineering for potential model improvement.
# Spotify_unplugged
