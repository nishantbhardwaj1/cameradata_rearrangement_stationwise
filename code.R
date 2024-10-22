install.packages("camtrapR")
install.packages("tidyverse")



#code for creating species folders inside camera trap stations
#Inside D80 there will be folders created with name sambar deer and Bay cat
#will be done inside all camera trap stations 
species <- c("Sambar Deer", "Bay Cat")
SpeciesFolderCreate1 <- createSpeciesFolders (inDir               = "E:/Camera Trap Data-2023/Sanctuary-2023/Block 2/Danda/D80/A",
                                              species             = species,
                                              hasCameraFolders    = FALSE,
                                              removeFolders       = FALSE)
renaming.table2 <- imageRename(inDir               =  "E:/Camera Trap Data-2023/Sanctuary-2023/Block 2/Danda/D80",
                               outDir              = "E:/Camera Trap Data-2023",       
                               hasCameraFolders    = FALSE,
                               copyImages          = TRUE
)

      





########





#addditional work  as alwaaays
#renaming all folders from R1 to T1
parent_dir <- "H:/NWLS_data_2023/Tiger2023/Right"
folders <- list.dirs(parent_dir, full.names = TRUE, recursive = FALSE)
# Loop through each folder
for (folder in folders) {
  # Extract the base name of the folder
  folder_name <- basename(folder)
  
  # Create the new folder name by replacing 'R' with 'T'
  new_folder_name <- gsub("^R", "T", folder_name)
  
  # Create the new path for the renamed folder
  new_folder_path <- file.path(parent_dir, new_folder_name)
  
  # Rename the folder
  if (folder != new_folder_path) {
    file.rename(folder, new_folder_path)
  }
}








####################merging T1 of left and right folders which
# has left and right flank of tiger
# Define the paths to the parent directories
left_dir <- "H:/NWLS_data_2024/Tiger2024/Left"
right_dir <- "H:/NWLS_data_2024/Tiger2024/Right"
target_base_dir <- "H:/NWLS_data_2024/Tiger2024/tiger_individuals_2024"

# List all subdirectories in the left directory
left_folders <- list.dirs(left_dir, full.names = TRUE, recursive = FALSE)
left_folder_names <- basename(left_folders)

# Function to copy files from a source directory to a target directory
copy_files <- function(source_dir, target_dir) {
  # List all files in the source directory
  files <- list.files(source_dir, full.names = TRUE)
  
  # Copy each file to the target directory
  file.copy(files, target_dir, overwrite = TRUE)
}

# Loop through each folder and merge files
for (folder_name in left_folder_names) {
  # Define source paths
  left_folder_path <- file.path(left_dir, folder_name)
  right_folder_path <- file.path(right_dir, folder_name)
  
  # Define target path
  target_folder_path <- file.path(target_base_dir, folder_name)
  # Create the target directory if it doesn't exist
  if (!dir.exists(target_folder_path)) {
    dir.create(target_folder_path, recursive = TRUE)
  }
  
  # Copy files from left folder to target folder
  copy_files(left_folder_path, target_folder_path)
  
  # Check if the right folder exists before copying files
  if (dir.exists(right_folder_path)) {
    copy_files(right_folder_path, target_folder_path)
  } else {
    cat("Right folder", right_folder_path, "does not exist. Only files from left folder", left_folder_path, "were copied.\n")
  }
  
  # Print progress
  cat("Merged files from", left_folder_path, "and", if (dir.exists(right_folder_path)) right_folder_path else "no corresponding right folder", "into", target_folder_path, "\n")
}

# Print a completion message
cat("All folders have been successfully merged.\n")


  
  
  
  
  
  
######arranging the images of individuals tigers which are identified into
#station format i.e D80 camera station will have all folders of all tigers it 
#captured and then inside those folders will be images D80-T1, T2 folders where 
#T1 and T2 are different tigers captured by D80 camera trap
  # Define the paths
  source_dir <- "H:/NWLS_data_2024/Tiger2024/density_2024"
  target_base_dir <- "H:/NWLS_data_2024/Tiger2024/experiment"
  
  # List all subdirectories in the source directory
  all_folders <- list.dirs(source_dir, full.names = TRUE, recursive = FALSE)
  
  # Extract the names of all folders
  folder_names <- basename(all_folders)
  
  # Create a vector to map image prefixes to original folder names
  prefix_to_folders <- setNames(folder_names, folder_names)
  
  # Function to extract the prefix from the filename
  extract_prefix <- function(filename) {
    sub("_.*", "", basename(filename))
  }
  
  # Loop through each original folder
  for (folder_name in folder_names) {
    # Define the folder path
    folder_path <- file.path(source_dir, folder_name)
    
    # List all files in the current folder
    files <- list.files(folder_path, full.names = TRUE)
    
    # Loop through each file in the current folder
    for (file in files) {
      # Extract the prefix from the file name
      prefix <- extract_prefix(file)
      
      # Define the target folder for the prefix
      prefix_folder_path <- file.path(target_base_dir, prefix)
      
      # Create the prefix folder if it doesn't exist
      if (!dir.exists(prefix_folder_path)) {
        dir.create(prefix_folder_path, recursive = TRUE)
      }
      
      # Define the subfolder path for the current original folder
      subfolder_path <- file.path(prefix_folder_path, folder_name)
      
      # Create the subfolder if it doesn't exist
      if (!dir.exists(subfolder_path)) {
        dir.create(subfolder_path, recursive = TRUE)
      }
      
      # Define the target file path
      target_file_path <- file.path(subfolder_path, basename(file))
      
      # Move the file to the target subfolder
      file.copy(file, target_file_path, overwrite = TRUE)
      
      # Optionally, delete the original file after copying (uncomment if needed)
      # file.remove(file)
      
      # Print progress
      cat("Moved file", file, "to", target_file_path, "\n")
    }
  }
  
  # Print a completion message
  cat("All images have been successfully organized.\n")
  
  #############################################################################################
  
  
 