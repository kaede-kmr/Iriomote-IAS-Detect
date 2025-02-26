# Figure 2: playback detection

# Figure 2
# playback detection

library(tidyverse)
library(patchwork)


# Load data

df5 <- read_csv("data/call-segments_threshold0.5.csv") |> 
  filter(species %in% c("POLLEU", "RHIMAR") & site == 4)
df9 <- read_csv("data/call-segments_threshold0.9.csv") |> 
  filter(species %in% c("POLLEU", "RHIMAR") & site == 4)

# Get ground-truth number of call segments
polleu_preds_vs_labels <- read.csv("data/preds-vs-labels-in-playback/POLLEU.csv") |> 
  mutate(date = str_extract(path, "\\d{8}") |> ymd())

rhimar_preds_vs_labels <- read.csv("data/preds-vs-labels-in-playback/RHIMAR.csv") |> 
  mutate(date = str_extract(path, "\\d{8}") |> ymd())

polleu_calling_segments <- polleu_preds_vs_labels |> 
  group_by(date) |> 
  summarise(correct_num_call_segments = sum(label == "POLLEU")) |> 
  mutate(species = "POLLEU")

rhimar_calling_segments <- rhimar_preds_vs_labels |> 
  group_by(date) |> 
  summarise(correct_num_call_segments = sum(label == "RHIMAR")) |> 
  mutate(species = "RHIMAR")

# Prepara dataframe for the plot. Threshold = 0.5
df <- df5 |> 
  left_join(polleu_calling_segments, by=c("date", "species")) |> 
  left_join(rhimar_calling_segments, by=c("date", "species")) |> 
  mutate(
    species = case_when(
      species=="POLLEU" ~ "Polypedates leucomystax",
      species=="RHIMAR" ~ "Rhinella marina"
    ))


# Plot
playback_date <- c("20230418", "20230525", "20230622", "20230729", "20230816", "20230928", "20231023", "20231129", "20231228", "20240129", "20240227") |> 
  lubridate::ymd()

ggplot(df, aes(date, num_call_segments))+
  geom_vline(xintercept = playback_date, col="#C6DBEF" , linewidth=1.5)+
  geom_line(linewidth=0.3)+
  geom_point(aes(y = correct_num_call_segments.x), col="black", fill="white", size=1.5, shape="circle filled")+
  geom_point(aes(y = correct_num_call_segments.y), col="black", fill="white", size=1.5, shape="circle filled")+
  facet_wrap(vars(species), ncol = 1, scales = "free_y")+
  scale_x_date(breaks = playback_date,
               date_labels = "%b %d", limits=c(ymd(20230320), ymd(20240229)), expand=c(0.02, 0.02))+
  labs(x="", y="Detection", title = "Treshold 0.5")+
  theme(
    panel.border = element_rect(colour = "gray10", fill = NA),
    panel.background = element_rect(fill = "white"),
    panel.grid = element_blank(),
    text = element_text(size=10),
    title = element_text(size=9),
    strip.background = element_rect(fill="white", color=NA),
    strip.text = element_text(size=10, face="italic", margin=margin(t=4, b=4)),
    axis.text.x = element_text(angle = 30, hjust = 1, vjust = 1)
  ) -> g1


# Threshold = 0.9
df2 <- df9 |> 
  left_join(polleu_calling_segments, by=c("date", "species")) |> 
  left_join(rhimar_calling_segments, by=c("date", "species")) |> 
  mutate(
    species = case_when(
      species=="POLLEU" ~ "Polypedates leucomystax",
      species=="RHIMAR" ~ "Rhinella marina"
    ))

ggplot(df2, aes(date, num_call_segments))+
  geom_vline(xintercept = playback_date, col="#C6DBEF" , linewidth=1.5)+
  geom_line(linewidth=0.3)+
  geom_point(aes(y = correct_num_call_segments.x), col="black", fill="white", size=1.5, shape="circle filled")+
  geom_point(aes(y = correct_num_call_segments.y), col="black", fill="white", size=1.5, shape="circle filled")+
  facet_wrap(vars(species), ncol = 1, scales = "fixed")+
  scale_x_date(breaks = playback_date,
               date_labels = "%b %d", limits=c(ymd(20230320), ymd(20240229)), expand=c(0.02, 0.02))+
  labs(x="", y="Detection", title = "Treshold 0.9")+
  theme(
    panel.border = element_rect(colour = "gray10", fill = NA),
    panel.background = element_rect(fill = "white"),
    panel.grid = element_blank(),
    text = element_text(size=10),
    title = element_text(size=9),
    strip.background = element_rect(fill="white", color=NA),
    strip.text = element_text(size=10, face="italic", margin=margin(t=4, b=4)),
    axis.text.x = element_text(angle = 30, hjust = 1, vjust = 1)
  ) -> g2

g1 / g2

ggsave("figs/Fig2.png", w=174, h=150, units = "mm", dpi=600)