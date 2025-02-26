# Figure S1 
# Check UMAP parameter effects

library(tidyverse)
library(umap)
library(patchwork)

# Load data
df <- read_csv("data/embeddings.csv")


# Set parameters
min_dist_params <- c(0.2, 0.5, 0.8)
n_neighbors_params <- c(30, 100, 200, 500)


# Plot
plot_list <- list()
for(md in min_dist_params){
  for(nn in n_neighbors_params){
    # Compute UMAP
    umap_out <- df |> 
      select(1:1024) |> 
      umap(n_neighbors=nn, min_dist=md, random_state=123)
    
    umap_df <- data.frame(
      UMAP1 = umap_out$layout[,1],
      UMAP2 = umap_out$layout[,2],
      labels = df$labels,
      Soundtype = ifelse(str_detect(df$file, "playback"), "playback", "wild")
    )
    
    # Plot
    g <- ggplot(umap_df, aes(UMAP1, UMAP2, shape=Soundtype))+
      geom_point(color="grey80")+
      geom_point(data=filter(umap_df, str_detect(labels, "POLLEU")), color="orange2", alpha=1)+
      geom_point(data=filter(umap_df, str_detect(labels, "RHIMAR")), color="grey10", alpha=0.5)+
      scale_shape_manual(values = c("plus", "circle"))+
      labs(title = str_c("min_dist", md, "/ n_neighbors", nn, sep=" "))+
      theme(
        panel.border = element_rect(colour = "gray10", fill = NA),
        panel.background = element_rect(fill = "white"),
        panel.grid = element_blank()
      )
    
    # Add resulting plot to the plot_list
    plot_list <- append(plot_list, list(g))
  }
}

# Display the results
plot_list[[1]]+plot_list[[2]]+plot_list[[3]]+plot_list[[4]]+plot_list[[5]]+plot_list[[6]]+
  plot_list[[7]]+plot_list[[8]]+plot_list[[9]]+plot_list[[10]]+plot_list[[11]]+plot_list[[12]]+
  plot_layout(guides = "collect", ncol=3, byrow=FALSE)

ggsave("figs/FigS1.png", w=17, h=23)

