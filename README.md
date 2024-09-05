# ETL Pipeline
This project implement a simple ETL(Extract, Transform, Load) pipeline using bash scripting.The pipeline processes financial data from a CSV file, perform transformation,and stores the processed data in a Gold folder for future use.
# Extract
The script downloads a CSV file containing raw data from a URL and saves it in a folder named `raw`. This ensures the file is available for the next step.
#Transform
During the transformation step, the script renames the column `Variable_code` to `variable_code`, and only selects the columns `year`, `Value`, `Units`, and `variable_code` for further use. The transformed data is saved as `2023_year_finance.csv` in the `Transformed` folder.
#Load
The transformed data is moved into a `Gold` folder, which represents the final stage where the data is ready for use.
