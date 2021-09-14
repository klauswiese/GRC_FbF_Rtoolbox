##Layer=vector
##Stat_file=Output file html
##Fecha_inicio=string
##Fecha_final=string
##VariableClimatica=selection  pp;temp;etp;esco
library(rgee)
use_python("C:/Users/logis/AppData/Local/Microsoft/WindowsApps/python3")
library(htmlwidgets)
library(cptcity)

ee_Initialize()


data <- Layer
roi <- sf_as_ee(data)
inicio= Fecha_inicio
final = Fecha_final

if(VariableClimatica==0){
dem <- ee$ImageCollection("IDAHO_EPSCOR/TERRACLIMATE")$select("pr")$filterDate(inicio,final)$mean()$clip(roi)
} else if(VariableClimatica==1){
dem <- ee$ImageCollection("IDAHO_EPSCOR/TERRACLIMATE")$select("tmmx")$filterDate(inicio,final)$mean()$clip(roi)
}else if (VariableClimatica==2){
dem <- ee$ImageCollection("IDAHO_EPSCOR/TERRACLIMATE")$select("pet")$filterDate(inicio,final)$mean()$clip(roi)
} else{
dem <- ee$ImageCollection("IDAHO_EPSCOR/TERRACLIMATE")$select("ro")$filterDate(inicio,final)$mean()$clip(roi)

}

Map$centerObject(roi)
a <- Map$addLayer(dem)
a <- Map$addLayer(dem)
a + Map$addLegend(
  list(
    min = 10,
    max = 25,
    palette=cpt(pal = "grass_bcyr")),
  name = "tmmax",
  position ="bottomright",
  bins = 4)
saveWidget(a,Stat_file)



