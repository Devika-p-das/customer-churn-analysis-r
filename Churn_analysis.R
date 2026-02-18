# ===============================
# 1. LIBRARIES
# ===============================
library(dplyr)
library(ggplot2)
library(caret)
library(randomForest)
library(VSURF)
library(pROC)
library(corrplot)

# ===============================
# 2. IMPORT DATA
# ===============================
churn_data <- read.csv("churndata.csv", header = TRUE)

# ===============================
# 3. DATA CLEANING
# ===============================
churn_data <- churn_data %>% select(-c(State, Area.code))

colnames(churn_data) <- c("Acct_len", "Intl_plan", "VM_plan", "VM_msgs",
                          "Day_min", "Day_calls", "Day_charge",
                          "Eve_min", "Eve_calls", "Eve_charge",
                          "Night_min", "Night_calls", "Night_charge",
                          "Intl_min", "Intl_calls", "Intl_charge",
                          "CS_calls", "Churn")

churn_data$Churn <- factor(ifelse(churn_data$Churn == TRUE,
                                  "Churn", "Non_Churn"))

churn_data$Intl_plan <- as.factor(churn_data$Intl_plan)
churn_data$VM_plan   <- as.factor(churn_data$VM_plan)

data <- churn_data

# ===============================
# 4. VISUALIZATION
# ===============================

# 4.1 Churn Distribution
data %>%
  count(Churn) %>%
  mutate(percent = round(n / sum(n) * 100, 2)) %>%
  ggplot(aes(x = Churn, y = n, fill = Churn)) +
  geom_col() +
  geom_text(aes(label = paste0(percent, "%")), vjust = -0.3) +
  theme_minimal() +
  labs(title = "Churn Distribution")

# 4.2 Voice Mail Plan
ggplot(data, aes(x = VM_plan, fill = VM_plan)) +
  geom_bar() +
  theme_minimal() +
  labs(title = "Voice Mail Plan Distribution")

# 4.3 Customer Service Calls
ggplot(data, aes(x = CS_calls)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  theme_minimal() +
  labs(title = "Customer Service Calls Distribution")

# 4.4 International Plan Pie Chart
ggplot(data, aes(x = "", fill = Intl_plan)) +
  geom_bar(width = 1) +
  coord_polar("y") +
  theme_void() +
  labs(title = "International Plan Distribution")

# 4.5 Correlation Matrix
numeric_data <- data %>% select(where(is.numeric))
cor_mat <- cor(numeric_data)

corrplot(cor_mat,
         method = "number",
         type = "lower",
         diag = FALSE)

# ===============================
# 5. TRAIN TEST SPLIT
# ===============================
set.seed(123)
train_index <- createDataPartition(data$Churn, p = 0.7, list = FALSE)

train_data <- data[train_index, ]
test_data  <- data[-train_index, ]

# ===============================
# 6. RANDOM FOREST
# ===============================
rf_model <- randomForest(Churn ~ ., data = train_data,
                         ntree = 500, importance = TRUE)

varImpPlot(rf_model)

# ===============================
# 7. MODEL EVALUATION
# ===============================
predictions <- predict(rf_model, test_data)
confusionMatrix(predictions, test_data$Churn)

prob_predictions <- predict(rf_model, test_data, type = "prob")[,2]
roc_curve <- roc(test_data$Churn, prob_predictions)

plot(roc_curve, col = "blue", main = "ROC Curve")
auc(roc_curve)
