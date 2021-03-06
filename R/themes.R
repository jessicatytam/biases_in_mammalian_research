library(ggplot2)
library(sysfonts)
font_add_google("Roboto")

themebyjess_light_point <- function() {
  theme(axis.title = element_blank(),
        axis.text = element_text(family = "Lato",
                                 size = 12,
                                 colour = "grey30"),
        axis.line = element_line(size = 1.05,
                                 colour = "grey20"),
        legend.background = element_rect(fill = "white"),
        legend.title = element_blank(),
        legend.text = element_text(family = "Roboto",
                                   size = 20,
                                   colour = "black"),
        legend.key = element_rect(fill = "white"),
        legend.position = "top",
        legend.justification = "centre",
        plot.title = element_text(family = "Lato",
                                  face = "bold",
                                  size = 20,
                                  colour = "black"),
        plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey90"),
        panel.grid.minor = element_line(colour = "grey90",
                                        linetype = "longdash"))
}

themebyjess_light_boxplot <- function() {
  theme(axis.title.x = element_text(family = "Lato",
                                    face = "bold",
                                    size = 20,
                                    colour = "black"),
        axis.title.y = element_blank(),
        axis.text.x = element_text(family = "Lato",
                                   size = 12,
                                   colour = "grey30"),
        axis.text.y = element_text(family = "Lato",
                                   size = 20,
                                   colour = "black"),
        axis.line = element_line(size = 1.05,
                                 colour = "grey20"),
        legend.background = element_rect(fill = "white"),
        legend.title = element_blank(),
        legend.text = element_text(family = "Roboto",
                                   size = 20,
                                   colour = "black"),
        legend.key = element_rect(fill = "white"),
        legend.position = "top",
        legend.justification = "centre",
        plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major.x = element_line(colour = "grey90"),
        panel.grid.minor.x = element_line(colour = "grey90",
                                          linetype = "longdash"),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank())
}

themebyjess_light_col <- function() {
  theme(axis.title.x = element_text(family = "Lato",
                                    face = "bold",
                                    size = 20,
                                    colour = "black"),
        axis.title.y = element_blank(),
        axis.text.x = element_text(family = "Lato",
                                   size = 12,
                                   colour = "grey30"),
        axis.text.y = element_text(family = "Lato",
                                   size = 12,
                                   colour = "black"),
        axis.line = element_line(size = 1.05,
                                 colour = "grey20"),
        legend.background = element_rect(fill = "white"),
        legend.title = element_blank(),
        legend.text = element_text(family = "Roboto",
                                   size = 20,
                                   colour = "black"),
        legend.key = element_rect(fill = "white"),
        legend.position = "top",
        legend.justification = "centre",
        plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major.x = element_line(colour = "grey90"),
        panel.grid.minor.x = element_line(colour = "grey90",
                                          linetype = "longdash"),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank())
}

themebyjess_light_quasirandom <- function() {
  theme(axis.title = element_blank(),
        axis.text.x = element_text(family = "Lato",
                                   size = 14,
                                   colour = "black"),
        axis.text.y = element_text(family = "Lato",
                                   size = 12,
                                   colour = "grey30"),
        axis.line = element_line(size = 1.05,
                                 colour = "grey20"),
        legend.background = element_rect(fill = "white"),
        legend.title = element_blank(),
        legend.text = element_text(family = "Roboto",
                                   size = 20,
                                   colour = "black"),
        legend.key = element_rect(fill = "white"),
        legend.position = "top",
        legend.justification = "centre",
        plot.title = element_text(family = "Lato",
                                  face = "bold",
                                  size = 20,
                                  colour = "black"),
        plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey90"),
        panel.grid.minor.y = element_line(colour = "grey90",
                                          linetype = "longdash"))
}

themebyjess_light_map <- function() {
  theme(title = element_text(family = "Lato",
                             face = "bold",
                             size = 16,
                             colour = "black"),
        axis.title = element_text(family = "Lato",
                                  face = "bold",
                                  size = 20,
                                  colour = "black"),
        axis.text = element_text(family = "Lato",
                                 size = 12,
                                 colour = "grey30"),
        axis.line = element_line(size = 1.05,
                                 colour = "grey20"),
        legend.background = element_rect(fill = "white"),
        legend.title = element_text(family = "Roboto",
                                    face = "bold",
                                    size = 16,
                                    colour = "black"),
        legend.text = element_text(family = "Roboto",
                                   size = 11,
                                   colour = "black"),
        legend.key = element_rect(fill = "white"),
        legend.position = "right",
        legend.justification = "centre",
        plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey90"),
        panel.grid.minor = element_line(colour = "grey90",
                                        linetype = "longdash"))
}

themebyjess_light_stream <- function() {
  theme(title = element_text(family = "Lato",
                             face = "bold",
                             size = 16,
                             colour = "black"),
        axis.title.x = element_text(family = "Lato",
                                    face = "bold",
                                    size = 20,
                                    colour = "black"),
        axis.title.y = element_text(family = "Lato",
                                    face = "bold",
                                    size = 20,
                                    colour = "black",
                                    margin = margin(r = 6)),
        axis.text = element_text(family = "Lato",
                                 size = 12,
                                 colour = "grey30"),
        axis.line = element_line(size = 1.05,
                                 colour = "grey20"),
        legend.background = element_rect(fill = "white"),
        legend.title = element_blank(),
        legend.text = element_text(family = "Roboto",
                                   size = 18,
                                   colour = "black"),
        legend.key = element_rect(fill = "white"),
        legend.position = "right",
        legend.justification = "centre",
        plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey90"),
        panel.grid.minor = element_line(colour = "grey90",
                                        linetype = "longdash"))
}

themebyjess_light_facet <- function() {
  theme(axis.title = element_text(family = "Lato",
                                  face = "bold",
                                  size = 20,
                                  colour = "black"),
        axis.title.x = element_blank(),
        axis.text.y = element_text(family = "Lato",
                                   size = 12,
                                   colour = "grey30"),
        axis.line = element_line(size = 1.05,
                                 colour = "grey20"),
        legend.background = element_rect(fill = "white"),
        legend.title = element_blank(),
        legend.text = element_text(family = "Roboto",
                                   size = 20,
                                   colour = "black"),
        legend.key = element_rect(fill = "white"),
        legend.position = "top",
        legend.justification = "centre",
        plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey90"),
        panel.grid.minor = element_line(colour = "grey90",
                                        linetype = "longdash"),
        strip.background = element_rect(fill = "black"),
        strip.text = element_text(family = "Lato",
                                  size = 16,
                                  colour = "white"))
}

themebyjess_dark_point <- function() {
  theme(axis.title = element_text(family = "Lato",
                                  face = "bold",
                                  size = 20,
                                  colour = "white"),
        axis.text = element_text(family = "Lato",
                                 size = 12,
                                 colour = "grey80"),
        axis.line = element_line(size = 1.05,
                                 colour = "grey80"),
        legend.background = element_rect(fill = "#163548"),
        legend.title = element_blank(),
        legend.text = element_text(family = "Roboto",
                                   size = 20,
                                   colour = "white"),
        legend.key = element_rect(fill = "#163548"),
        legend.position = "top",
        legend.justification = "centre",
        plot.background = element_rect(fill = "#163548"),
        panel.background = element_rect(fill = "#163548"),
        panel.grid.major = element_line(colour = "grey50"),
        panel.grid.minor = element_line(colour = "grey50",
                                        linetype = "longdash"))
}

themebyjess_dark_boxplot <- function() {
  theme(axis.title.x = element_text(family = "Lato",
                                    face = "bold",
                                    size = 20,
                                    colour = "white"),
        axis.title.y = element_blank(),
        axis.text.x = element_text(family = "Lato",
                                   size = 12,
                                   colour = "grey80"),
        axis.text.y = element_text(family = "Lato",
                                   size = 20,
                                   colour = "white"),
        axis.line = element_line(size = 1.05,
                                 colour = "grey80"),
        legend.background = element_rect(fill = "#163548"),
        legend.title = element_blank(),
        legend.text = element_text(family = "Roboto",
                                   size = 20,
                                   colour = "white"),
        legend.key = element_rect(fill = "#163548"),
        legend.position = "top",
        legend.justification = "centre",
        plot.background = element_rect(fill = "#163548"),
        panel.background = element_rect(fill = "#163548"),
        panel.grid.major.x = element_line(colour = "grey50"),
        panel.grid.minor.x = element_line(colour = "grey50",
                                          linetype = "longdash"),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank())
}

themebyjess_dark_map <- function() {
  theme(axis.title = element_text(family = "Lato",
                                  face = "bold",
                                  size = 20,
                                  colour = "white"),
        axis.text = element_text(family = "Lato",
                                 size = 12,
                                 colour = "grey80"),
        axis.line = element_line(size = 1.05,
                                 colour = "grey80"),
        legend.background = element_rect(fill = "#163548"),
        legend.title = element_text(family = "Roboto",
                                    face = "bold",
                                    size = 20,
                                    colour = "white"),
        legend.text = element_text(family = "Roboto",
                                   size = 11,
                                   colour = "white"),
        legend.key = element_rect(fill = "#163548"),
        legend.position = "right",
        legend.justification = "centre",
        plot.background = element_rect(fill = "#163548"),
        panel.background = element_rect(fill = "#163548"),
        panel.grid.major = element_line(colour = "grey50"),
        panel.grid.minor = element_line(colour = "grey50",
                                        linetype = "longdash"))
}