# Compile Pamlab annotations into a csv, for multi-species csvs

# G. Macklin 2022 (based on script by P. Emery)


# Download and install packages if not already installed: data.table, tidyverse, here
if (!require("pacman")) install.packages("pacman")

# Then open the packages
library(pacman)
p_load(data.table, tidyverse)

### EDIT THESE:
file_path <- r"(F:\BW Aud files for characterization\MUPPET runs\MUPPET_OUTPUT_INPUT_A1_standardized annotation boxes\annotations)" #copy file path to annotations folder within recording folder, paste inside r"( )"

deployment_code <- "A1_standardized_annotation_boxes" #input deployment code here STN_YYYY_MM


### RUN THESE:

AnalysisCode <- "DPA" #input analysis code here
SpeciesCode <- "MB" # input species code here

file_list <- list.files(file_path, pattern = ".log", full.names = TRUE)


# Then merge them together into a single dataframe

annomerge <- rbindlist(sapply(file_list, fread, simplify = FALSE, USE.NAMES = TRUE, fill=TRUE), fill= TRUE)%>%
  mutate(filename = str_extract(Soundfile, "[^\\\\]*$"), .after=Soundfile) %>% 
  mutate(Deployment= deployment_code,
         Station= str_extract(Deployment, "^[^_]+")) 
  


# Export csv file
output_file = paste0(deployment_code,"_",AnalysisCode,"_",SpeciesCode, "_Annotations_",Sys.Date(),".csv")
write_csv(annomerge, paste0(r"(F:\BW Aud files for characterization\MUPPET runs\MUPPET_OUTPUT_INPUT_A1_standardized annotation boxes\annotations)",output_file))

#modified for working off the desktop in the same folder as the scripts
#write_csv(annomerge, output_file)
