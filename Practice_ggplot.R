data(iris)
str(iris)
install.packages("ggplot2")
library(ggplot2)

# Next a basic scatter plot is drawn
write.csv(iris, "iris.csv")

kd<-read.csv("irisdubey.csv")

ggplot(data = kd, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point()

#Looking at the scatter plot and thinking about the focus of finding a method to classify the species, 
#two thoughts come to mind. First, the plot might be improved by increasing the size of the points. 
#And second, using different colors for the points corresponding to the three species would help.


ggplot(data = kd, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point(size = 4, aes(color=Species))

#Notice that a legend showing what the colors represent is automatically generated and included in the graphic.
#Next, the size of the points seems a bit big now, and it might be helpful to use different shapes for the different species.

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point(size = 3, aes(color=Species, shape=Species))


#Adding lines to a scatter plot

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point(size=3, aes(color=Species))

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point(size=3, aes(color=Species)) + 
  stat_smooth(method = lm, se=FALSE)


#For the iris data, it probably makes more sense to fit separate lines by species. This can be specified using the aes() function inside stat_smooth().

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point(size=3, aes(color=Species)) + 
  stat_smooth(method = lm, se=FALSE, aes(color=Species))

#In this case we specified the same color aesthetic for the points and the lines. 
#If we know we want this color aesthetic (colors corresponding to species) for all aspects of the graphic, we can specify it in the main ggplot() function:

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
  geom_point(size=3) + stat_smooth(method = lm, se=FALSE)

#Another common use of line segments in a graphic is to connect the points in order, 
#accomplished via the geom_line() function. Although it is not 
#clear why this helps in understanding the iris data, the technique is illustrated next, 
#first doing this for all the points in the graphic, and second doing this separately for the three species.

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point(size = 4, aes(color=Species, shape = Species)) + 
  geom_line()


ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point(size = 4, aes(color=Species)) + 
  geom_line(aes(color=Species))


#Labels, Axes, Text, etc.

u.crime <- "https://www.finley-lab.com/files/data/crimeRatesByState2005.csv"
crime <- read.csv(u.crime, header=TRUE)
str(crime)


ggplot(data <- crime, aes(x = burglary, y = motor_vehicle_theft)) + 
      geom_point()

##Put Labels 

ggplot(data = crime, aes(x = burglary, y = motor_vehicle_theft)) + 
  geom_point() + 
  labs(x = "Burglaries per 100,000 population", 
       y = "Motor vehicle theft per 100,000 population",
       title = "Burglaries vs motor vehicle theft for US states",
       subtitle = "2005 crime rates and 2008 population",
       caption = "Data from Nathan Yau http://flowingdata.com"
  )



#Customizing Axes

ggplot(data = crime, aes(x = burglary, y = motor_vehicle_theft)) + 
  geom_point() + 
  scale_x_continuous(name="Burglaries per 100,000 population", 
                     limits=c(0,max(crime$burglary))) +
  scale_y_continuous(name="Motor vehicle theft per 100,000 population", 
                     limits = c(0, max(crime$motor_vehicle_theft)))



##Text, Point Size, and Color

ggplot(data = crime, aes(x = burglary, y = motor_vehicle_theft, 
                         size=population/100000)) + 
  geom_point(color = "blue") + 
  geom_label(aes(label = state), alpha = 0.5) +
  scale_x_continuous(name="Burglaries per 100,000 population", 
                     limits=c(0,max(crime$burglary))) +
  scale_y_continuous(name="Motor vehicle theft per 100,000 population", 
                     limits = c(0, max(crime$motor_vehicle_theft))) +
  labs(size="Population\n(100,000)")

## Another Good choice 

ggplot(data = crime, aes(x = burglary, y = motor_vehicle_theft, 
                         size=population/100000)) + 
  geom_point(color = "blue") + 
  scale_x_continuous(name="Burglaries per 100,000 population", 
                     limits=c(0,max(crime$burglary))) +
  scale_y_continuous(name="Motor vehicle theft per 100,000 population", 
                     limits = c(0, max(crime$motor_vehicle_theft))) +
  labs(size="Population\n(100,000)") +
  ggrepel::geom_label_repel(aes(label = state), alpha = 0.5)



##Other Types of Graphics
u.newcomb <- "https://www.finley-lab.com/files/data/Newcomb.csv"
Newcomb <- read.csv(u.newcomb, header = TRUE)
head(Newcomb)
ggplot(Newcomb, aes(x = Time)) + geom_histogram()



#The software has an algorithm to calculate bin widths for the histogram. 
#Sometimes the algorithm makes choices that aren’t suitable (hence the R message above), 
#and these can be changed by specifying a binwidth. In addition, the appearance of the bars also can be changed.

ggplot(Newcomb, aes(x = Time)) + 
  geom_histogram(binwidth = 5, color = "black", fill = "blue" )


#Boxplots


library(gapminder)



ggplot(data = subset(gapminder,  year = 2002), 
       aes(x = continent, y = gdpPercap)) + 
  geom_boxplot(color = "black", fill = "lightblue")




#Here’s the same set of boxplots, but with different colors, different axis labels, and the boxes plotted horizontally rather than vertically.

ggplot(data = subset(gapminder,  year == 2002), 
       aes(x = continent, y = gdpPercap)) + 
  geom_boxplot(color = "red", fill = "lightblue") + 
  scale_x_discrete(name = "Continent") + 
  scale_y_continuous(name = "Per Capita GDP") + coord_flip()




# Bar plot

u.goals <- "https://www.finley-lab.com/files/data/StudentGoals.csv"
StudentGoals <- read.csv(u.goals, header = TRUE)
head(StudentGoals)


ggplot(StudentGoals, aes(x = Goals)) + geom_bar()


ggplot(StudentGoals, aes(x = Goals, fill = Gender)) + geom_bar()


ggplot(StudentGoals, aes(x = Goals, fill = Gender)) + 
  geom_bar(position = "dodge")



ggplot(subset(gapminder, country == "India"), aes(x = year, y = gdpPercap)) + 
  geom_bar(stat = "identity", color = "black", fill = "steelblue2") + 
  ggtitle("India's per-capita GDP")


##Happy Practice !



























