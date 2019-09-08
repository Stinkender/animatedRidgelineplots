library(gganimate)
library(ggridges)
library(wesanderson) #For the colour palette
library(av)

#create colour palette
pal <- wes_palette("Zissou1", 100, type = "continuous")

#Set working directory
setwd("D:/fmi_hki")

#Read temperature data. Original data downloaded from https://ilmatieteenlaitos.fi/havaintojen-lataus#!/. I made some changes to column names with Notepad++
tempsKaisis <- read.csv(file="t1980_2018Kaisaniemi_.csv", header=TRUE, sep=",")

#Replace numeric months with text (these are in Finnish)
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 1, "Tammikuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 2, "Helmikuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 3, "Maaliskuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 4, "Huhtikuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 5, "Toukokuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 6, "Kesäkuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 7, "Heinäkuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 8, "Elokuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 9, "Syyskuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 10, "Lokakuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 11, "Marraskuu")
tempsKaisis$Kk <-  replace(tempsKaisis$Kk, tempsKaisis$Kk == 12, "Joulukuu")

#Sort by month, not sure if this is needed
tempsKaisis$Kk <- factor(tempsKaisis$Kk, levels = c("Joulukuu", "Marraskuu", "Lokakuu", "Syyskuu", "Elokuu", "Heinäkuu", "Kesäkuu", "Toukokuu", "Huhtikuu","Maaliskuu", "Helmikuu", "Tammikuu"))

#Make the plot  
p <- ggplot(tempsKaisis, aes(x = `degC`, y = `Kk`, fill = ..x..)) +
    geom_density_ridges_gradient(scale = 1, rel_min_height = 0.0001, color = "#FEFEDF00", size = 0.1) +
    scale_fill_gradientn(name = "Lämpötila (Celsius)",colours = pal) +
    xlab("Lämpötila (Celsius)") +
    ylab("") +
    scale_x_continuous(breaks = c(-35,-30,-25,-20,-15,-10,-5,0,5,10,15,20,25,30,35), limits = c(-35,35)) +
    theme(
      plot.title = element_text(colour = "#D9CB9E"),
      legend.background = element_rect(fill = "#374140"),
      legend.title = element_text(color = "#D9CB9E", size = 10),
      legend.text = element_text(color = "#D9CB9E"),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "#374140"),
      panel.grid.major = element_line(colour = "#797d7d"),
      plot.background = element_rect(fill = "#374140"),
      axis.ticks.x=element_blank(),
      axis.text.x=element_text(colour="#D9CB9E"),
      axis.text.y=element_text(colour="#D9CB9E"),
      axis.ticks.y=element_blank(),
      axis.title.x = element_text(colour = '#D9CB9E', size = 10)
    )+
    labs(title = 'Ilman lämpötila Helsingissä (Kaisaniemi), {frame_time}', x = 'Lähde: Ilmatieteen laitos', y = '') +
    transition_time(Vuosi)+
    ease_aes('cubic-in-out')

#For this, you need to have FFMPEG installed. You can find instructions here: https://github.com/adaptlearning/adapt_authoring/wiki/Installing-FFmpeg
 animate(p, renderer = av_renderer('tempsKaisaniemi1980_2018.mp4'), width = 750, height = 750, fps = 30, duration = 38)