#loading library
library(tidyverse)
msleep

#view data
glimpse(msleep)
view(msleep)

#rename variable

msleep %>% 
  #      what we naming to = the existing name
  rename("conserv" = "conservation")

msleep

# reordering variables

msleep %>% 
  select(vore, name, everything())

#change variable type

class(msleep$vore)
msleep$vore <- as.factor(msleep$vore)
class(msleep$vore)
#change vore back to char using pipeline
msleep %>% 
  mutate(vore  = as.character(vore)) %>% 
  glimpse()

#checking the variable names 
names(msleep)
#any variable between 2,3,4 + awake
#starts with sleep and contains weight
msleep %>% 
  select(2:4,
         awake,
         starts_with("sleep"),
         contains("wt")) %>% 
  names()

#filter and arranhe data
unique(msleep$order)

msleep %>% 
  filter((order == "Carnivora" | #order %in% c("Carnivorav","Primates")
            order == "Primates") &
          sleep_total > 8) %>% 
  select(name, order, sleep_total) %>% 
  arrange(-sleep_total) %>% 
  view
#change obs mutate
msleep %>% 
  mutate(brainwt = brainwt * 1000) %>% 
  view

msleep %>% #creates a new column
  mutate(brainwt_in_grams = brainwt * 1000) %>% 
  view
# creating a new dataset called size_of_brain
#stores if the brain size bigger than 0.01 as large
#otherwise small
size_of_brain <- msleep %>% 
  select(name, brainwt) %>% 
  drop_na(brainwt) %>% 
  mutate(brain_size = if_else(brainwt > 0.01,
                              "Large","Small"))
#recoding data and renaming

size_of_brain %>% 
  mutate(brain_size = recode(brain_size,
                             "Large" = 1,
                             "Small" = 2))