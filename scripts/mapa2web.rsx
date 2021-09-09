##FbF-Gráficos=group
##Layer=vector
##Columna=Field Layer
##Nivel=Field Layer
##Salida=Output file html

#Librerias
library(htmlwidgets)
library(leaflet)
library(leaflet.extras)
# Parametros
input = Layer
columna = Columna
nombre = Nivel
#MapaWeb
pal <- colorBin(
  palette = "viridis",
  domain = c(min(input[[columna]]),max(input[[columna]])),
  n = 5)

mapaweb = input %>%
  leaflet() %>%
  addProviderTiles(
    provider ="OpenStreetMap",
    group = "OSM") %>%
  addProviderTiles(
    provider = "Esri.WorldImagery",
    group = "Satelital") %>%
  addLayersControl(baseGroups = c("OSM","Satelital"),) %>%
  addPolygons(
    fillColor =~pal(input[[columna]]),
    color = "black",
    weight = 1,
    fillOpacity = 0.9,
    popup = paste0(
      "<b>El valor de: </b>",
      input[[nombre]],"<br>",
      input[[columna]])
    ) %>%
  addLegend("bottomright",
            pal = pal,
            values = input[[columna]],
            title = columna,
            opacity = 1
            ) %>%
  addResetMapButton() %>%
  addControlGPS()
saveWidget(mapaweb,Salida)

