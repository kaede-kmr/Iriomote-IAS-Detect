# Figure 3a 
# Visualization of embeddings with UMAP

library(tidyverse)
library(umap)
library(plotly)
library(patchwork)

# Load data 
df <- read_csv("data/embeddings.csv")


# Compute UMAP (it takes some time)
umap_out <- df |> 
  select(1:1024) |>  # Extract embeddings
  umap(n_neighbors=200, min_dist=0.5, random_state=123)  # compute UMAP


# Prepare data.frame
umap_df <- data.frame(
  UMAP1 = umap_out$layout[,1],
  UMAP2 = umap_out$layout[,2],
  file = df$file,
  site = df$site,
  labels = df$labels,
  Soundtype = ifelse(str_detect(df$file, "playback"), "playback", "wild")
)


#Plot
umap_df |>
  ggplot(aes(UMAP1, UMAP2, shape=Soundtype, text=file))+
  geom_point(color="grey80", size=0.4)+
  geom_point(data=filter(umap_df, str_detect(labels, "POLLEU")), color="orange2", alpha=0.8, size=0.4)+
  geom_point(data=filter(umap_df, str_detect(labels, "RHIMAR")), color="grey10", alpha=0.5, size=0.4)+
  scale_shape_manual(values=c("plus", "circle"))+
  theme(
    panel.border = element_rect(colour = "gray10", fill = NA),
    panel.background = element_rect(fill = "white"),
    panel.grid = element_blank(),
    text = element_text(size=11),
    legend.title = element_text(size=9)
  )

ggsave("figs/Fig3a.png", w=110, h=80, units="mm", dpi=600)
