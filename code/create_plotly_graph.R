# Libraries
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("plotly")
# install.packages("hrbrthemes")

#### Load libraries #### 
library(ggplot2)
library(dplyr)
library(plotly)
library(hrbrthemes)

#### Ethos dataset ####

ethos <- read_csv("data/ethos.csv") #file to big to load
ethos_sub <- ethos %>% 
  group_by(date) %>% 
  filter(date>1970 & date<2021) %>% 
  filter(!is.na(subject_discipline)) %>% 
  count(subject_discipline) %>% 
  spread(subject_discipline, n) %>% 
  janitor::clean_names()

f <- list(
  family = "Arial, monospace",
  size = 14,
  color = "#7f7f7f"
)
x <- list(
  title = "Años",
  titlefont = f
)
y <- list(
  title = "Número de tesis",
  titlefont = f
)

# annotations
a <- list(
  text = "Silvia Gutiérrez (silviaegt@uni-leipzig.de)",
  xref = "paper",
  yref = "paper",
  yanchor = "bottom",
  xanchor = "center",
  align = "center",
  x = 0.8,
  y = 0.985,
  showarrow = FALSE
)

b <- list(
  text = "",
  font = f,
  xref = "paper",
  yref = "paper",
  yanchor = "bottom",
  xanchor = "center",
  align = "center",
  x = 0.5,
  y = 0.95,
  showarrow = FALSE
)
names(ethos_sub)

# Area chart with 2 groups
p <- plot_ly(x = ethos_sub$date, 
             y = ethos_sub$language_literature,
             type="scatter", 
             mode="markers", 
             fill = "tozeroy",
             name = "Language & Literature") 

p
p <- p %>% add_trace(y = ethos_sub$history_archaeology, 
                     name = "History & Archeology") 

p <- p %>% add_trace(y = ethos_sub$philosophy_psychology_religious_studies, 
                     name = "Philosophy, psychology & religious studies") 

p <- p %>% add_trace(y = ethos_sub$music, 
                     name = "Music") 
p <- p %>% layout(xaxis = x, 
                  yaxis = y, 
                  title= "Dissertations' subjects in the UK (1970-2020)", 
                  annotations = list(a, b))

p

