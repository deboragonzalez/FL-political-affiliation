library(tidyverse)
library(readxl)

data1 <- read_excel("Voter_Registration_By_County_and_Party_Feb_2019.xlsx")
# Data1 is a spreadsheet containing voter registration of FL voters by county and party as of Feb. 2019.
data2 <- read_excel("Voter_Registration_By_Party_Affiliation_Feb_2019.xlsx")
# Data2 is a spreadsheet containing voter registration of FL voters by party as of Feb. 2019 from 1972 to 2019.

data2 %>% 
  #select(County, `Republican Party Of Florida`) %>%
  filter(County != "TOTALS") %>% 
  arrange(desc(`Republican Party Of Florida`)) %>% 
  ggplot(aes(x = County,  y = `Florida Democratic Party`)) +
  geom_bar(stat = "identity") +
  labs(title = "Florida's Most Republican Counties",
       subtitle = "Florida counties with the highest number of registered Republicans as of 2019",
       caption = "Source: Florida Department of State - Division of Elections Voter Registration Data")


sliderTextInput(
  inputId = "range", label = h4(tags$b("Year interval:")), 
  choices = years, selected = range(years), 
  grid = TRUE
)

sliderInput("year", 
            label = h3("Select Years"), 
            min = min(unique(data2$Year)), 
            max = max(unique(data2$Year)),
            value = c(2000, 2005),
            step = steps)
)