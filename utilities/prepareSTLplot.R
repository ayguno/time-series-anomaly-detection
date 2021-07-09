# Author: Ozan Aygun
# Purpose: performs Multiple Seasonal Decomposition and returns
# a ggplot for presentation.
# Input: a ts object

prepareSTLplot <- function(x){
    return(
        mstl(x,robust = TRUE) %>%
            autoplot(color = "navy") +
            geom_point(color = "white", size = 0.5) +
            theme_bw()+
            theme(axis.text.x = element_text(size = 7, angle = 45),
                  panel.grid = element_blank(),
                  strip.background = element_rect(fill = '#3d6b66'),
                  strip.text = element_text(size = 15, color = "white"),
                  panel.background = element_rect(fill = "#93bab2"))
    )
}