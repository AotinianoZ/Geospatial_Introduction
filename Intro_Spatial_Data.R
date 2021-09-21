---
title: "Introduction to Geological Spatial Data - Peru in R"
author: "A.Otiniano (Modify from Edzer Pebesma)"
date: "`r Sys.Date()`"
output:
  html_document:
    df_print: paged
    code_folding: show
    toc: yes
    toc_float:
      collapsed: yes
      smooth_scroll: yes
    theme: flatly
    highlight: espresso
  pdf_document:
    toc: yes
---

# Making Maps Programming

Basic libraries to start:

```{r, eval=FALSE}
#install.packages(c("cowplot", "googleway", "ggplot2", "ggrepel", 
#"ggspatial", "libwgeom", "sf", "rnaturalearth", "rnaturalearthdata"))
```

Preparing information:

```{r}
library("ggplot2")
theme_set(theme_bw()) #best for maps
library("sf")
library("plotly")
```

```{r}
library("rnaturalearth")  #country world maps
library("rnaturalearthdata") # necesarie to scale = "large" 

mundo <- ne_countries(scale = "medium", returnclass = "sf")
# Check some structure
class(mundo)
str(mundo)
colnames(mundo)
head(mundo, 6)
tail(mundo, 6)
```

## Data and Basic Plots (*coord_sf* y *geom_sf*)

```{r, warning=FALSE, message=FALSE, fig.align='center'}
ggplot(data = mundo)+
  geom_sf()
```

## Title, subtitle and axes labels (*ggtitle*, *xlab*, *ylab*)

```{r, warning=FALSE, message=FALSE, fig.align='center'}
ggplot(data = mundo)+
  geom_sf()+
  xlab("Longitud")+ylab("Latitude")+
  ggtitle("World Maps", subtitle = paste0("(",length(unique(mundo$name)), "country)"))
```

## Color Map (*geom_sf*)

A first simple map:

```{r, warning=FALSE, message=FALSE, fig.align='center'}
ggplot(data = mundo)+
  geom_sf(color = "black", fill = "blue")
```

Generating a best map:

```{r, warning=FALSE, message=FALSE, fig.align='center'}
a <- ggplot(data = mundo) +
    geom_sf(aes(fill = pop_est)) +
    scale_fill_viridis_c(option = "plasma", trans = "sqrt")
a
```

## Projection and Extension (*coord_sf*)

**coord_sf** allow work with coordenate system including both projections and extensions of map. The argument `crs` is possible overwrite the configuration and project wherever. This can be use with all kind of validation of  **PROJ4 string**.

```{r, warning=FALSE, message=FALSE, fig.align='center'}
ggplot(data = mundo) +
    geom_sf() +
    coord_sf(crs = "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs ")
```

If we want to use Spatial Reference System Identifier (SRID) or European Petroleum Survey Group (EPSG) code available for Peru:

```{r, warning=FALSE, message=FALSE, fig.align='center'}
ggplot(data = mundo) +
    geom_sf() +
    coord_sf(crs = "+init=epsg:3035")
ggplot(data = mundo) +
    geom_sf() +
    coord_sf(crs = st_crs(3035))
```

We generate `zoom` in Peru to add the map of  **South America**. *Let´s go (Vamos)!*

```{r, warning=FALSE, message=FALSE, fig.align='center'}
ggplot(data = mundo) +
    geom_sf() +
    coord_sf(xlim = c(-90.00, -30.5), ylim = c(-57.00, 14.00), expand = FALSE)
```

## Arrow and Scale (**ggspatial**)

Exist a variety of packages like `prettymapr, vsd, ggsn, legendMap`. We are going to use `ggspatial`. 

```{r, warning=FALSE, message=FALSE, fig.align='center'}
library(ggspatial)
```

```{r, warning=FALSE, message=FALSE, fig.align='center'}
ggplot(data = mundo) +
    geom_sf() +
    annotation_scale(location = "bl", width_hint = 0.4) +
    annotation_north_arrow(location = "bl", which_north = "true", 
        pad_x = unit(2.70, "in"), pad_y = unit(3.80, "in"),
        style = north_arrow_fancy_orienteering) +
    coord_sf(xlim = c(-90.00, -30.5), ylim = c(-57.00, 14.00))

## Scale on map varies by more than 10%, scale bar may be inaccurate
```

## Comentarios Finales:

Pronto explicaremos la potencialidad geoespacial de *leaflet()*, *sf()* y *mapbox()* unidos a *plotly()* y *crosstalk()* entre otros para generar `mapas interactivos geoespaciales`. Para el análisis multiscience que considero filtros dinámicos en mapas, gráficos, tabla y cálclos estaísticos y geoestadístico interactuando simultáneamente se necesitarán algunas herramientas más que pronto veremos :D!!!.


# Referencias Bibliográficas:

* Basic Reference from [r-spatial](https://r-spatial.org/r/2018/10/25/ggplot2-sf.html).

* Revisando Sistemas de Coordenadas en R [CRS](https://www.nceas.ucsb.edu/sites/default/files/2020-04/OverviewCoordinateReferenceSystems.pdf).

* Working with Spatial Data [Ecolog, Statistics, and Data Science with R](https://cmerow.github.io/RDataScience/04_Spatial.html)

* [Simple Feture in R](https://r-spatial.github.io/sf/).

* [Geocomputation with R](https://geocompr.robinlovelace.net/adv-map.html).

* [Spatial Data Science](https://keen-swartz-3146c4.netlify.app/intro.html).

* [Leaflet for R](https://bookdown.org/nicohahn/making_maps_with_r5/docs/leaflet.html) y [Leaflet for R 2](https://rstudio.github.io/leaflet/).

* [tmap](https://tlorusso.github.io/geodata_workshop/tmap_package) y [tmap2](https://bookdown.org/nicohahn/making_maps_with_r5/docs/tmap.html). 

* [Spatial Cheatsheet](https://www.maths.lancs.ac.uk/~rowlings/Teaching/UseR2012/cheatsheet.html).

* [stats into R](https://github.com/Pakillo/stats-intro).

* [Raster Data in R - The Basics](https://www.neonscience.org/resources/learning-hub/tutorials/raster-data-r).

* [Intro to Raster Data](https://datacarpentry.org/r-raster-vector-geospatial/01-raster-structure/index.html).

* [Earth Analytics Course: Learn Data Science](https://www.earthdatascience.org/courses/earth-analytics/)

* Mapview [popup functions](https://environmentalinformatics-marburg.github.io/mapview/popups/html/popups.html).





























