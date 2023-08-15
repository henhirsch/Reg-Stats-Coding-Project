# Cumulative Economically Significant Final Rules by Administration

# clean environment
rm(list = ls())

# load packages
library(ggplot2)
library(tidyr)
library(ggrepel)

# load data
cum_sig <- read.csv("/Users/henryhirsch/Henry/Work/2023/Regulatory Studies Center/projects/project 2 (regstats graphs)/cum_sig_rules/Cumulative_ES_rules_published_months_in_office_071023.csv", skip = 1)

# Create president_names list which can be updated at the top of the code and then referenced later in the code as needed?

# rename columns (will need to manually update with the names of new presidents)
colnames(cum_sig) <- c("month", "months_in_office", "Reagan", "Bush_41", "Clinton", "Bush_43", "Obama", "Trump", "Biden")

# get rid of unnecessary columns (will also need to manually update with new president names here)
cum_sig <- cum_sig[ , c("months_in_office", "Reagan", "Bush_41", "Clinton", "Bush_43", "Obama", "Trump", "Biden")]

# get rid of unnecessary rows (this would need to be altered if a president served more than two terms)
cum_sig <- cum_sig[-c(98:101), ]

# create long data frame (will also need to manually add new president's names here)
cum_sig_long_NA <- pivot_longer(cum_sig, cols = c("Reagan", "Bush_41", "Clinton", "Bush_43", "Obama", "Trump", "Biden"), names_to = "president", values_to = "econ_rules")

# remove NA values from long data frame (these NA values are the potential econ_rules values for presidents who didn't/haven't yet served the maximum number of months)
cum_sig_long <- cum_sig_long_NA[complete.cases(cum_sig_long_NA), ]

pres_colors <- c("Reagan" = "#033C5A", "Bush_41" = "#0190DB","Clinton" = "#FFC72C", "Bush_43" = "#AA9868", "Obama" = "#008364", "Trump" = "#78BE20", "Biden" = "#C9102F"
)

pres_annotations <- data.frame(
  president = c("Reagan", "Bush_41", "Clinton", "Bush_43", "Obama", "Trump", "Biden"),
  x_coords = c(92, 48, 76, 92, 92, 48, 10),
  y_coords = c(120, 125, 275, 280, 475, 250, 70),
  labels = c("Reagan", "Bush 41", "Clinton", "Bush 43", "Obama", "Trump", "Biden")
)

# Matching the colors directly
pres_annotations$name_color <- pres_colors[pres_annotations$president]

line1 <- ggplot(cum_sig_long, aes(x = months_in_office, y = econ_rules, color = president, group = president)) + 
  geom_line(linewidth = 0.75) +
  geom_text(data = pres_annotations, aes(x = x_coords, y = y_coords, label = labels),
            vjust = -0.5, hjust = 0.5, size = 3, color = pres_annotations$name_color) +  # Set color here
  scale_color_manual(values = pres_colors) +
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(color = "lightgray", linetype = "solid"),
        panel.grid.minor = element_blank()) +
  xlab("Months In Office") +
  ylab("Number of Economically Significant Rules Published") +
  ggtitle("Cumulative Economically Significant Final Rules by Administration") +
  labs(color = "President") +
  scale_y_continuous(breaks = seq(0, max(cum_sig_long$econ_rules) + 50, by = 50),
                     expand = c(0, 0), 
                     limits = c(-2, max(cum_sig_long$econ_rules) + 50)) +
  scale_x_continuous(breaks = seq(0, max(cum_sig_long$months_in_office), by = 4),
                     expand = c(0, 0),
                     limits = c(0, max(cum_sig_long$months_in_office)))

line1





