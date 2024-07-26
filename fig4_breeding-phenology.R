# Figure 4
# Breeding phenology of Polypedates leucomystax and Rhinella marina

library(tidyverse)

# Load and clean data
df <- read_csv("data/call-segments_threshold0.5.csv")

df2 <- df |> 
  filter(species %in% c("POLLEU", "RHIMAR") & site != "4") |> 
  mutate(
    species = case_when(
      species=="POLLEU" ~ "Polypedates leucomystax",
      species=="RHIMAR" ~ "Rhinella marina"
    )
  )


# Plot
ggplot(df2, aes(date, as.character(site), fill=num_call_segments))+
  geom_tile()+
  scale_fill_distiller(palette = "Blues", direction = 1)+
  facet_wrap("species", ncol=1)+
  scale_x_date(date_breaks="2 months", date_labels = "%b %d", expand=c(0,0))+
  scale_y_discrete(limits = c("3", "2", "1"))+
  labs(x=NULL, y="Site", fill="Detection")+
  theme(
    panel.border = element_rect(colour = "gray10", fill = NA),
    panel.background = element_rect(fill = "grey90"),
    panel.grid = element_line(color="white"),
    panel.grid.major.y = element_blank(),
    text = element_text(size=11),
    legend.title = element_text(size=9, hjust=0, margin=margin(b=5, r=0)),
    strip.background = element_rect(fill="white", color=NA),
    strip.text = element_text(size=10, face="italic", margin=margin(t=4, b=4)),
  )

ggsave("figs/Fig4.png", w=174, h=85, units = "mm", dpi=600) 

