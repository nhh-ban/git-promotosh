# Step 1: Read the entire data file into memory using the readLines()-function.
url <- "http://www.sao.ru/lv/lvgdb/article/suites_dw_Table1.txt"
lines <- readLines(url, warn = FALSE)

# Step 2: Identify the line number L of the separator line between the column names and
# the rest of the data table.
L <- which(grepl("^-+", lines))

# Step 3: Save the variable descriptions (i.e. the information in lines 1:(L-2)) in a
# text-file for future reference using the cat()-function
desc_file <- "variable_descriptions.txt"
cat(lines[1:(L-2)], file = desc_file, sep = "\n")

# Step 4: Extract the variable names (i.e. line (L-1)), store the names in a vector.
column_names <- unlist(strsplit(gsub("\\s+", " ", lines[L-1]), " "))

# Step 5 & 6: Rewrite the data to a new .csv-file with comma-separators using cat() 
# and then read the finished .csv back into R in the normal way.

# Create a temporary csv file
temp_csv <- tempfile(fileext = ".csv")

# Write the column names and the data to the csv
cat(paste(column_names, collapse = ","), file = temp_csv, sep = "\n")
data_lines <- lines[(L+1):length(lines)]
cleaned_data <- gsub("\\s+", ",", data_lines)
cat(cleaned_data, file = temp_csv, sep = "\n", append = TRUE)

# Read the csv file into a dataframe
df <- read.csv(temp_csv)

# Display the dataframe
print(df)


