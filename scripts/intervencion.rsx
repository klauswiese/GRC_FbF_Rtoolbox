##FbF-Gráficos=group
##showplots   
##Layer=vector
##Tipodegrafico=selection barras;polar
##Eje_x=Field Layer
##Eje_y=Field Layer
##TipodeColor=selection viridis;infierno;plasma;magma

library(tidyverse)
library(ggplot2)

titulo = "Índice de riesgo"
subtitulo = "FbF - LAC"
fuente = "Elaboración propia con datos de INEI"

df = Layer %>% st_set_geometry(NULL)
topdf = df %>% 
  arrange(df[[Eje_y]]) %>%
  head(10) 


if (Tipodegrafico==0){
  plot_top = topdf %>% 
    ggplot(
      aes(
        x = reorder(topdf[[Eje_x]],topdf[[Eje_y]]),
        y = topdf[[Eje_y]])) + 
    geom_bar(stat = "identity",aes(fill =topdf[[Eje_y]])) +
    coord_flip() + 
    labs(
      title = titulo,
      subtitle = subtitulo,
      caption = fuente,
      x = '',
      y = '') 
  
}else{
  plot_top = topdf %>% 
    ggplot(
      aes(
        x = reorder(topdf[[Eje_x]],topdf[[Eje_y]]),
        y = topdf[[Eje_y]])) + 
    geom_bar(stat = "identity",aes(fill =topdf[[Eje_y]]))+
    coord_polar() +
    labs(
      title = titulo,
      subtitle = subtitulo,
      caption = fuente,
      x = '',
      y = '')
  
}
 
if(TipodeColor==0){
  final = plot_top + 
  scale_fill_viridis_c(option = "viridis") %>% 
    suppressMessages()
}else if(TipodeColor==1){
  final = plot_top + 
    scale_fill_viridis_c(option = "inferno") %>% 
    suppressMessages()
}else if(TipodeColor==2){
  final = plot_top + 
    scale_fill_viridis_c(option = "plasma") %>% 
    suppressMessages()
}else{
  final = plot_top + 
    scale_fill_viridis_c(option = "magma") %>% 
    suppressMessages()
}

  
PLOT= final +
  theme(
    legend.position = "none",
    axis.text.x = element_text(size=12),
    axis.text.y = element_text(size=12),
    axis.title.x = element_text(size=12),
    axis.title.y = element_text(size=12)
    )
PLOT
  
PLOT= final +
  theme(
    legend.position="none")
PLOT

