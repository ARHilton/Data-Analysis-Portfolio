## LSE Data Analytics Online Career Accelerator 

# DA301:  Advanced Analytics for Organisational Impact

###############################################################################

# Assignment template

## Scenario
## You are a data analyst working for Turtle Games, a game manufacturer and 
## retailer. They manufacture and sell their own products, along with sourcing
## and selling products manufactured by other companies. Their product range 
## includes books, board games, video games and toys. They have a global 
## customer base and have a business objective of improving overall sales 
##performance by utilising customer trends. 

## In particular, Turtle Games wants to understand:
## - how customers accumulate loyalty points
## - how useful are remuneration and spending scores data
## - can social data (e.g. customer reviews) be used in marketing 
##     campaigns
## - what is the impact on sales per product
## - the reliability of the data (e.g. normal distribution, Skewness, Kurtosis)
## - if there is any possible relationship(s) in sales between North America,
##     Europe, and global sales.

################################################################################

# EDA using R.

###############################################################################

# 1. Load and explore the data

# First we will change the working directory.
# (If working in a common work area this may not be required but if working locally, 
# it is best to be sure.)

# Check the current working directory.
getwd()
# Add the desired working directory below.
setwd(dir='')

# Install and import Tidyverse.
#install.packages('tidyverse')
library(tidyverse)

# Import the data set.
# Let's keep the naming convention simple:
turtle_sales <- read.csv('turtle_sales.csv', header = TRUE)
#turtle_sales <- read.csv(file.choose(), header=T)

# Print the data frame.
head(turtle_sales)
View(turtle_sales)


# Create a new data frame from a subset of the sales data frame.
# Remove unnecessary columns. 
# We will remove Ranking, Year, Genre and Publisher. 
# For now we will rename the data frame to 'turtle_sales2'.
turtle_sales2 <- select(turtle_sales, 
                        -Ranking, 
                        -Year,
                        -Genre,
                        -Publisher)

# View the data frame.
head(turtle_sales2, 10)

# View the descriptive statistics.

summary(turtle_sales2)
str(turtle_sales2)
glimpse(turtle_sales2)
as.tibble(turtle_sales2)

# Comments:
# Product is a unique code, and should not be an integer with statistical value.

turtle_sales2 <- mutate(turtle_sales2, Product = as.factor(Product))
head(turtle_sales2, 10)

# We should just sense check the sales to make sure NA+EU is never > Global.

# Let's just check the counts of platforms and product:
table(turtle_sales2$Platform)
table(turtle_sales2$Product)


# I am guessing that the '2600' Platform is the 'Atari 2600', based on cursory research.
# Lot's of products with multiple entries, warrants further investigation. Let's look at 9080.

filter(turtle_sales2,
       Product == 9080)

# Okay, seems to be a multi-platform game.

################################################################################

# 2. Review plots to determine insights into the data set.

## 2a) Scatterplots
# Create scatterplots.
qplot(NA_Sales, EU_Sales, 
      data = turtle_sales2,
      colour=Platform)

qplot(NA_Sales, Global_Sales, data = turtle_sales2)

qplot(EU_Sales, Global_Sales, data = turtle_sales2)

## 2b) Histograms
# Create histograms.
plot(hist(turtle_sales2$NA_Sales))

plot(hist(turtle_sales2$EU_Sales))

plot(hist(turtle_sales2$Global_Sales))

## 2c) Boxplots
# Create boxplots.
qplot(Platform, 
      NA_Sales,
      data=turtle_sales2,
      geom='boxplot')

qplot(Platform, 
      EU_Sales,
      data=turtle_sales2,
      geom='boxplot')

qplot(Platform, 
      Global_Sales,
      data=turtle_sales2,
      geom='boxplot')

# These three graphs are not very pretty and contain a lot of noise but they are good for 
# showing outliers.
# The fact that the outliers are in the same place across NA, EU and globe is of note.

# It would be useful to the business to have a high level boxplot of sales overall comparing 
# the regions.
# We can pivot the data into a new data frame for this purpose, which we will just call sales.

sales <- pivot_longer(turtle_sales2, cols = c(NA_Sales, EU_Sales, Global_Sales),
                      names_to = 'Region', values_to = 'Sales')

# We can just examine the head if we want to.
# head(sales, 10)

qplot(Region,
      Sales,
      data=sales,
      geom='boxplot')

# Okay, clearly the sales are skewed by well performing outliers.

###############################################################################

# 3. Observations and insights

# Across all regions the sales are skewed by a few high performing titles.
# Average sales across all regions are generally quite 'low' in comparison to well 
# performing titles.


###############################################################################
###############################################################################


# Cleaning and maniulating data using R

################################################################################

# 1. Load and explore the data

# Import the below library in order to use the skim function.
library(skimr)

# View data frame created in Week 4.
View(turtle_sales2)

# Check output: Determine the min, max, and mean values.

min(turtle_sales2$NA_Sales)
max(turtle_sales2$NA_Sales)
mean(turtle_sales2$NA_Sales)

min(turtle_sales2$EU_Sales)
max(turtle_sales2$EU_Sales)
mean(turtle_sales2$EU_Sales)

min(turtle_sales2$Global_Sales)
max(turtle_sales2$Global_Sales)
mean(turtle_sales2$Global_Sales)

# View the descriptive statistics.

summary(turtle_sales2)
skim(turtle_sales2)
DataExplorer::create_report(turtle_sales2)

###############################################################################

# 2. Determine the impact on sales per product_id.

## 2a) Use the group_by and aggregate functions.
# Group data based on Product and determine the sum per Product.

Product_Sales <- turtle_sales2 %>% group_by(Product) %>%
  summarise(Total_NA=sum(NA_Sales),
            Total_EU=sum(EU_Sales),
            Total_Global=sum(Global_Sales),
            .groups='drop')

# View the data frame.
View(Product_Sales)

# Explore the data frame.
dim(Product_Sales)
str(Product_Sales)
summary(Product_Sales)


## 2b) Determine which plot is the best to compare game sales.
# We will generate simple & standard plots for now as we are still in the explorative phase.


# Create scatterplots.

ggplot(data = Product_Sales,
       mapping = aes(x=Total_NA, y=Total_EU)) + 
  geom_point(colour = 'Red') +
  geom_smooth(method = lm)


ggplot(data = Product_Sales,
       mapping = aes(x=Product, y=Total_Global)) + 
  geom_point(colour = 'Blue') +
  geom_smooth()



# Create histograms.

hist(Product_Sales$Total_NA)

hist(Product_Sales$Total_EU)

hist(Product_Sales$Total_Global)

# Create boxplots.

boxplot(Product_Sales$Total_NA)

boxplot(Product_Sales$Total_EU)

boxplot(Product_Sales$Total_Global)

###############################################################################


# 3. Determine the normality of the data set.

## 3a) Create Q-Q Plots
# Create Q-Q Plots.
qqnorm(Product_Sales$Total_NA)
qqline(Product_Sales$Total_NA, col='red')

qqnorm(Product_Sales$Total_EU)
qqline(Product_Sales$Total_EU, col='blue')

qqnorm(Product_Sales$Total_Global)
qqline(Product_Sales$Total_Global, col='green')


## 3b) Perform Shapiro-Wilk test
# Install and import Moments.
#install.packages('moments')
library(moments)

# Perform Shapiro-Wilk test.
# If the output P-Value < 0.05, then we can conclude data is not normally distributed.

shapiro.test((Product_Sales$Total_NA))
# P-value < so NA sales are not normally distributed.

shapiro.test((Product_Sales$Total_EU))
# P-value < so EU sales are not normally distributed.

shapiro.test((Product_Sales$Total_Global))
# P-value < so Global sales are not normally distributed.


## 3c) Determine Skewness and Kurtosis
# Skewness and Kurtosis.

# North America:
skewness(Product_Sales$Total_NA)
kurtosis(Product_Sales$Total_NA)

# Europe:
skewness(Product_Sales$Total_EU)
kurtosis(Product_Sales$Total_EU)

# Global:
skewness(Product_Sales$Total_Global)
kurtosis(Product_Sales$Total_Global)


## 3d) Determine correlation
# Determine correlation.

# We would at least expect both NA and EU sales to correlate with Global,
# so let's check this first. Then we will check correlation between NA and EU.


cor(Product_Sales$Total_NA, Product_Sales$Total_Global)

cor(Product_Sales$Total_EU, Product_Sales$Total_Global)

cor(Product_Sales$Total_NA, Product_Sales$Total_EU)


###############################################################################

# 4. Plot the data
# Create plots to gain insights into data.

# It is clear that we are not able to effectively visualise the data in its current form.
# We need to pivot it such that geographical location is a field we can play with.
# I will also add an extra column for Rest Of World (ROW).

# Add a new column for ROW.
Product_Sales$Total_ROW = Product_Sales$Total_Global - 
  (Product_Sales$Total_NA + Product_Sales$Total_EU)

# Examine the data frame in the view field. We need to reduce Total_ROW to 2.d.p.
# We may also need to format it too, so do both:

Product_Sales$Total_ROW <- as.numeric(Product_Sales$Total_ROW)
Product_Sales$Total_ROW <- round(Product_Sales$Total_ROW, 2)


# Verify new column.
View(Product_Sales)   # Re run this if you don't already have the window open.
head(Product_Sales)

# Pivot data.
Product_Sales2 <- pivot_longer(Product_Sales,
                               cols = c(Total_NA, Total_EU, Total_ROW,
                                        Total_Global),
                               names_to = 'Location',
                               values_to = 'Sales')

# View this data frame.
View(Product_Sales2)

# Create a scatterplot:


ggplot(Product_Sales2,
       mapping=aes(x=Product, y=Sales, colour=Location)) +
  geom_point(data = subset(Product_Sales2, Location !='Total_Global'),
             alpha=1.5,
             size=2) + 
  labs(title = "Product Sales By Region",
       subtitle = "Comparing North America, Europe and The Rest Of The World") +
  theme_dark()+
  theme(axis.text.x = element_blank())


# Create a bar chart.

ggplot(Product_Sales2, aes(x = Location, y = Sales, fill = Location)) +
  geom_bar(stat = "identity", 
           data = subset(Product_Sales2, Location !='Total_Global')) +
  labs(x = "Region", y = "Total Sales", 
       title = "Total Sales by Region", 
       subtitle = "Proportional Sales Globally")+
  theme_dark()

# Creating a boxplot:

ggplot(Product_Sales2, aes(x=Location, y = Sales, fill = Location))+
  geom_boxplot(data = subset(Product_Sales2, Location !='Total_Global'),
               notch = TRUE, outlier.colour = 'white')+
  labs(x = "Region", y = "Sales", 
       title = "Regional Sales Profiles", 
       subtitle = "Key Performance Indicators")+
  theme_dark()



###############################################################################

# 5. Observations and insights

# We can confidently say that the sales data is not normally distributed.
# We examined the data for each region, looking at North America, Europe and the Global totals.
# We arrived at this conclusion by applying various techniques to each region.
# Namely:
# Each QQ Plot indicated a positive skew with a long tail, by virtue of it's shape.
# The Shapiro tests repeatedly indicated the data was not normally distributed, 
# with P-Values far below the 0.05 threshold.
# Skewness was around 3 which indicates a high degree of positive skewing.
# Kurtosis was between 15-17, indicating a very peaked distribution with long tails.
# NOTE: Kurtosis of 3 indicates normal distribution, so it is important not to mistake the 
# Skewness recorded here as the Kurtosis value.
# There is a strong positive correlation between sales in North America and those globally.
# There is an almost as strong positive correlation between European and global sales.
# However, sales between the EU and North America do not correlate anywhere nearly as strongly, 
# suggesting different forces underly these events.
# The visualisations show the dominance of North America as a proportion of global sales. 
# Our scatter graph confirms this but also makes clear there is a degree of regionality at play,
# whereby some games are much more popular in Europe than NA.

# Given the incredibly high Kurtosis and skewness, the data is not fit for modelling
# without further treatment. Considering many statistical techniques assume normal distribution.
# If we were to proceed with the data in its current form it could lead to biased 
# or inaccurate predictions. Normalising the data and removing outliers would be a 
# good place to start if we were to consider transforming the data in some fashion. 


###############################################################################
###############################################################################

# Making recommendations to the business using R

## The sales department wants to better understand if there is any relationship
## between North America, Europe, and global sales. Therefore, we need to
## investigate any possible relationship(s) in the sales data by creating a 
## simple and multiple linear regression model.

###############################################################################

# 1. Load and explore the data
# View data frame created in Week 5.

# We want the non-pivoted data. So we want the Product_Sales. I also want to 
# re-arrange some of the columns which I will do now:

Product_Sales <- Product_Sales[, c('Product', 'Total_NA', 'Total_EU',
                                   'Total_ROW', 'Total_Global')]


View(Product_Sales)

# Determine a summary of the data frame.

summary(Product_Sales)
str(Product_Sales)


###############################################################################

# 2. Create a simple linear regression model
## 2a) Determine the correlation between columns

cor(Product_Sales[, c('Total_NA', 'Total_EU', 'Total_ROW',
                      'Total_Global')])

# Total_ROW has a low correlation with Total_Gloabl (by comparisson) so 
# I will exclude it from the regression model (for now).

# Create a linear regression model on the original data.



## 2b) Create a plot (simple linear regression)
# We will start with North American sales as the independent variable.

# Basic visualisation.
plot(Product_Sales$Total_NA, Product_Sales$Total_Global)

# Fit the linear regression model.
modelNA <- lm(Total_Global ~ Total_NA, data = Product_Sales)

# Let's examine the model.
modelNA

summary(modelNA)

# T value of 30.079 and small P value indicate Total_NA is a highly significant variable.
# Multiple R squared value is also quite high.

# Plot model residuals.
plot(modelNA$residuals)

# Residuals generally balanced around zero with no observable patttern. 
# Suggests data is fit for linear modelling and we can proceed without further
# treatment of the data.

# Let's replot the data with the line of best fit.
plot(Product_Sales$Total_NA, Product_Sales$Total_Global)
abline(coefficients(modelNA))

# The model fits a line that seems to match the data. Let's pause this for now
# and repeat the above process, instead using EU sales as the independent variable.
# I will not explain each step individually.

plot(Product_Sales$Total_EU, Product_Sales$Total_Global)

modelEU <- lm(Total_Global ~ Total_EU, data = Product_Sales)

modelEU

summary(modelEU)
# The t value is still very high and P value low, suggesting EU sales are an 
# important variable to consider.

plot(modelEU$residuals)
# It seems we have some extreme outliers at the start, potentially offsetting 
# the model a bit. But generally we can see this is suitable fit for linear regression.

plot(Product_Sales$Total_EU, Product_Sales$Total_Global)
abline(coefficients(modelEU))


#### SUMMARY:
# In summary, both the NA and EU sales data correlate with Global sales.
# However, the NA model is a noticably better fit, with a t value of 30.079
# compared to 21.099 in the case of the EU model, suggesting the NA coefficient 
# is larger relative to its standard error. A likely contributing factor to this 
# difference is the presence of higher residuals in the EU model, which themselves
# are a consequence of outliers: games that performed well globally but not in the EU. 
# This can all be summarised in the Multiple R-squared values of 0.8395 for the NA model
# compared to 0.7201 for the EU model.

# (I will run the same process for ROW to see how 'un-fit' the fit is.)

plot(Product_Sales$Total_ROW, Product_Sales$Total_Global)

modelROW <- lm(Total_Global ~ Total_ROW, data = Product_Sales)

modelROW

summary(modelROW)

plot(modelROW$residuals)

plot(Product_Sales$Total_ROW, Product_Sales$Total_Global)
abline(coefficients(modelROW))

# The t value is still quite high, and the p-value low, suggesting this is 
# still a significant variable. A multiple R-squared value of 0.5289 is not
# awful but it is significantly lower then the NA and EU models, leading me to 
# believe this variable should be excluded from an MLR model on this topic.

###############################################################################

# 3. Create a multiple linear regression model
# Select only numeric columns from the original data frame.

# We will remove the Index column, which is index 1.
Product_Sales3 <- Product_Sales[, -1]

head(Product_Sales3)
str(Product_Sales3)
as.tibble(Product_Sales3)


# Multiple linear regression model.

# We already have some insight above that Total_ROW does not significantly correlate
# with Global sales.Therefore, we will proceed with the first MLR model without it.

# Let's create the first model, with a simple name.

modela <- lm(Total_Global~Total_NA+Total_EU, data=Product_Sales3)

# Print the summary statistics.
summary(modela)

# We can see from the P values and the *** that both NA and EU sales are 
# highly statistically significant in predicting Global sales. The adjusted 
# R-squared value is very high, indicating this model is a good fit.

#  For the sake of demonstration, let's create another model and add ROW just 
# to get a gauge on the fit.

modelb <- lm(Total_Global~Total_NA+Total_EU+Total_ROW, data=Product_Sales3)

summary(modelb)

# We get an error message. Notice the adjusted R-squared value is a perfect 1.
# This is evidence that the model has been overfit and would likely not predict well
# on unseen data. In fact, this is a consequence of perfect multicolinearity.
# Unsurprising since Global = ROW + NA + EU.


##### As a final note we can also get an overview of the correlations between 
# variables using the corPlot function.

# Install the psych package if it isn't already.
# install.packages('psych')

# Import the psych package.
library(psych)

# Use the corPlot() function.
# Specify the data frame (wine) and set 
# character size (cex=2).
corPlot(Product_Sales3, cex=2)

# This serves as another re-assurance that NA and EU are the best two to include 
# in the model, as they have the highest correlation with Global sales.

# Let us just run a VIF test specifically for multicollinearity.
library(dplyr)
library(car)   # Required to call the vif function.
vif(modela)

# The values, around 1.6, indicate little multicollinearity and we can proceed
# with relative confidence that this does not effect the model. 


###############################################################################

# 4. Predictions based on given values
# Compare with observed values for a number of records.

# Let's compile some hypothetical sales data for NA and EU into a new data frame.

hypSales <- data.frame(
  Total_NA = c(34.02, 3.93, 2.73, 2.26, 22.08),
  Total_EU = c(23.80, 1.56, 0.65, 0.97, 0.52)
)

# Sense check the new data frame.
as.tibble(hypSales)
str(hypSales)


# Create a new object and specify the predict function.
predictTest = predict(modela, newdata=hypSales,
                      interval='confidence')

# Print the object.
predictTest

# The output values appear reasonable. A few of the below hypothetical variable
# combinations existed in the original data set. Namely:

# NA: 34.02, EU: 23.80, Actual Global: 67.85, Predicted Global: 68.056
# NA: 2.73, EU: 0.65, Actual Global: 4.32, Predicted Global: 7.35
# NA: 22.08, EU: 0.52, Actual Global: 23.21, Predicted Global: 26.62

# Our predictions seem more reliable at higher levels.

###### Verifying the fit with some plots:

# Let's plot the original data alongside the predicted values for modela in order
# to evaluate goodness of fit.


# Let's first run some predictions for modela.
pred_modela <- predict(modela)

# View the predictions.
pred_modela

# Plot the scatterplots. We will use par(mfrow) to arrange them above one another.
# The base R plots will suffice for this as we are not making anything too 
# complicated.


# Arrange plot with the par(mfrow) function. We will reduce the margins a bit.
par(mfrow=c(2, 1), mar=c(4, 4, 2, 1))

plot(Product_Sales$Total_NA, Product_Sales$Total_Global,
     xlab = "North American Sales", ylab = "Global Sales",
     main = "MLR Predicted Sales")

points(Product_Sales$Total_NA, pred_modela, col = "red")

# Add a legend
legend(x = 0, y = 65, legend = c("Recorded Sales", "Predicted Sales"), 
       col = c("black", "red"), pch = 1, cex = 1.2)



plot(Product_Sales$Total_EU, Product_Sales$Total_Global,
     xlab = "European Sales", ylab = "Global Sales")

points(Product_Sales$Total_EU, pred_modela, col = "blue")

# Add a legend
legend(x = 0, y = 65, legend = c("Recorded Sales", "Predicted Sales"), 
       col = c("black", "blue"), pch = 1, cex = 1.2)




###############################################################################

# 5. Observations and insights

# We have built a multi linear regression model to predict Global Sales.
# Our independent variables of choice were NA and EU sales which both showed
# high statistical significance in the model, bolstered by low levels of 
# multicollinearity with each other.
# The model has an adjusted R-Squared value of 0.9664, which indicates a better
# fit than either of the simple linear regression models, with multiple R-Squared values
# of 0.8395 (NA) and 0.7201 (EU).
# We plotted the model predictions over the observed data in order to visualise the 
# level of accuracy, which confirmed the goodness of fit. 



###############################################################################
###############################################################################

######## ADDITIONAL WORKINGS TO BUILD INSIGHT SPECIFIC PLOTS:

#### LOOKING AT SALES OVER TIME:

# Construct a new data frame.
sales_time <- turtle_sales

# Restrict the data to beyond 1992, as sales exist reliably boyond this point.
# NOTE: the assumption here is that sales belong to the year in which the title
#       first came out. This is clearly not the case, but we will proceed on the
#       axiom that sales 'derive' from a game released in the given year and hence
#       can be attributed to that year.


sales_time <- filter(sales_time, Year >= 1992)

sales_time

sales_time <- sales_time %>% group_by(Year) %>%
  summarise(Total_NA=sum(NA_Sales),
            Total_EU=sum(EU_Sales),
            Total_Global=sum(Global_Sales),
            .groups='drop')

sales_time

ggplot(sales_time, aes(x = Year, y = Total_Global)) +
  geom_bar(stat = "identity") + theme_dark()

# Okay, so sales are on the decline, but we can build on this.

# Define a new data frame including platforms. Restrict it to 1992 and beyond.
sales_time_plat <- turtle_sales
sales_time_plat <- filter(sales_time_plat, Year >= 1992)

# Group the data.
sales_time_plat <- sales_time_plat %>% group_by(Year, Platform) %>%
  summarise(Total_NA=sum(NA_Sales),
            Total_EU=sum(EU_Sales),
            Total_Global=sum(Global_Sales),
            .groups='drop')

# Plot the data.
ggplot(sales_time_plat, aes(x = Year, y = Total_Global, fill = Platform)) +
  geom_bar(stat = "identity") + theme_dark() +
  labs(title = "Global Sales by Platform Over Time",
       x = "Year",
       y = "Global Sales")+
  
  # Adjusting the size of the axis labels
  theme(axis.title = element_text(size = 14),
        plot.title = element_text(size = 20))

# So it seems like the portfolio is not very diversified and somewhat at the 
# whim of the gaming industry releasing a new console and the popularity
# of new games on said console.


# Let's look at Genre as well. We will follow the same process.

sales_time_Genre <- turtle_sales
sales_time_Genre <- filter(sales_time_Genre, Year >= 1992)

sales_time_Genre <- sales_time_Genre %>% group_by(Year, Genre) %>%
  summarise(Total_NA=sum(NA_Sales),
            Total_EU=sum(EU_Sales),
            Total_Global=sum(Global_Sales),
            .groups='drop')


ggplot(sales_time_Genre, aes(x = Year, y = Total_Global, fill = Genre)) +
  geom_bar(stat = "identity") + theme_dark()

# I won't save this. I think it conveys the same core message as the previous graphic:
# that game sales are declining.


############### VALIDATING THIS:

# We should check whether these declines in sales are a TurtleGames problem
# or a wider industry problem. We will seek to validate this performance profile
# by comparing it to the market cap of GameStop GME. Sales and market cap are 
# of course not directly comparable, however GameStop was/is an industry leader
# in console game sales, and were even more so during the period in question. 
# We can therefore regard the fluctuations in market cap as an expression of the overall 
# 'health' of the industry.

# Read in the 'GME_Market_Cap.csv' data.

GME_MC <- read.csv(file.choose(), header=T)


# Explore the data.
as.tibble(GME_MC)
as.tibble(sales_time_Genre)
str(sales_time_Genre)
str(GME_MC)

# Clean the data in the market cap column.
GME_MC$Market_Cap <- as.numeric(sub("\\$", "", sub(" B", "000000000", GME_MC$Market_Cap)))

# Set 'Year' to numeric.
GME_MC$Year <- as.numeric(GME_MC$Year)

# Restrict to 2016 and before.
GME_MC <- filter(GME_MC, Year <= 2016)

# Plot the data.
ggplot(GME_MC, aes(x = Year, y = Market_Cap)) +
  geom_bar(stat = "identity") + theme_dark()

# While the data does not align particularly well, the overall industry trend is still clear
# and validates the trend indicated by TurtleGames sales data.

######################### Check regional trends.

# Finally, we will just repeat the above process, this time accounting for region.

sales_time_region <- turtle_sales
sales_time_region <- filter(sales_time_region, Year >= 1992)

sales_time_region <- sales_time_region %>% group_by(Year) %>%
  summarise(Total_NA=sum(NA_Sales),
            Total_EU=sum(EU_Sales),
            Total_Global=sum(Global_Sales),
            .groups='drop')

as.tibble(sales_time_region)

sales_time_region$Total_ROW = sales_time_region$Total_Global - 
  (sales_time_region$Total_NA + sales_time_region$Total_EU)

sales_time_region <- pivot_longer(sales_time_region, 
                                  cols = c(Total_NA, 
                                           Total_EU, 
                                           Total_Global,
                                           Total_ROW),
                                  names_to = 'Region', values_to = 'Sales')

sales_time_region <- sales_time_region[sales_time_region$Region != "Total_Global", ]

# Creating the plot.

ggplot(sales_time_region, aes(x = Year, y = Sales, fill = Region)) +
  geom_bar(stat = "identity") + 
  theme_dark() +
  
  # Adding title and axis labels
  labs(title = "Regional Sales Performance Per Year",
       x = "Year",
       y = "Sales") +
  
  # Adjusting the size of the axis labels and title
  theme(axis.title = element_text(size = 14),
        plot.title = element_text(size = 20)) 

