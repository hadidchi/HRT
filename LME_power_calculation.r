# Load libraries
install.packages("lme4")
install.packages("simr")
library(lme4)
library(simr)

propmatchecomplete <- read_csv("path/to/your/dataset")

# Fit your actual model with the full dataset
model <- lmer(outcome ~ HRT * Age + HRT * AgeAbove60 + HRT * AgeAbove70 + HRT * AgeAbove80 + (1 | idno), data = propmatchecomplete, REML = TRUE)

# Pick effect size
desired_effect <- 70  # <-- Change this to the effect size (in slope units) you want to test

# Create a new model with the adjusted effect size
model_ext <- model
fixef(model_ext)["HRT:Age"] <- desired_effect

# Run power simulation
set.seed(123)
power_result <- powerSim(model_ext, test = fixed("HRT:Age", method = "lr"), nsim = 100)

# Show results
print(power_result)