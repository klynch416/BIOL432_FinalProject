library("dplyr")
library("tidyr")
library("impute")


# Read in the data obtained from the paper
preprocessed_data <- read.csv("Soper_Gorden_Adler_AJB_2018_Flower_Insect_Interactions_Processed_Data.csv")

# Identify character variables
char_vars <- sapply(preprocessed_data, is.character)

# Convert character variables to factors
preprocessed_data[char_vars] <- lapply(preprocessed_data[char_vars], as.factor)

# Calculate the percentage of missing values in each row
missing_pct <- rowMeans(is.na(preprocessed_data))

# Identify rows with 50% or more missing values 
missing_rows <- which(missing_pct >= 0.45)

# Remove rows with 50% or more missing values
preprocessed_data <- preprocessed_data[-missing_rows, ]

# Identify categorical variables
categorical_vars <- sapply(preprocessed_data, is.factor)

# Remove categorical variables
preprocessed_data <- preprocessed_data[, !categorical_vars]
preprocessed_data <- preprocessed_data %>% select(-Plot_Number)

# Set the value of k (number of neighbors)
k <- 3

# Convert the data frame to a matrix
preprocessed_data_matrix <- as.matrix(preprocessed_data)

# Perform kNN imputation
imputed_data_matrix <- impute.knn(preprocessed_data_matrix, k = k)$data

# Convert the imputed matrix back to a data frame
processed_data <- as.data.frame(imputed_data_matrix)

# Write to csv file
write.csv(processed_data, "processed_data.csv")

