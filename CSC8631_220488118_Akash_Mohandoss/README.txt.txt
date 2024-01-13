CONTENTS OF THIS FILE
--------------------->

 * Introduction
 * Requirements
 * Recommended R library
 * Installation
 * Configuration
 * Troubleshooting

#INTRODUCTION
---------------------------------------------------------------------------------------------------------------------------->

This directory consists of Futurelearn dataset, preprocessing code file, Analysis code file, reports generated using R-Markdown. the entire raw dataset obatined from Futurelearn MOOC has been extracted and loaded into the R project template directory that has been for the purpose of project. the directory that we are currently working is the "Future MOOC data analysis". all the code file are stored inside this directory in their respective locations for execution. Once the .rmd file is knit, the preprocessing file executes and the preprocessing of the dataset will be done as per the code that has been written by the user in the 'Munge' file. the r script for performing the analysis is stored in the 'src' file. the .rmd file for the project report generation is stored in the 'report' file and all the report content and the code to be included in the .rmd file will be present inside it in this folder. once the .rmd file has been knitted the file will be saved and the generated report file will be displayed to the user as per the code and content given inside the .rmd file. for this project the .rmd file name is 'FutureLearn_Analysis'.

#REQUIREMENTS
---------------------------------------------------------------------------------------------------------------------------->

This project requires proper understanding of the CRISP-DM framework and stages which needs to be followed in order to achieve the chosen business objective. the six stages of the CRISP-DM framework are Business Understanding, Data Understanding, Data Preparation, Modelling, Evaluation, Deployment. all the stages have been covered and the chosen business objective has been achieved through the analysis performed on the given dataset. further, proper understanding of the R-Markdown file and its usage are to be known to a user. 

#RECOMMENDED LIBRARIES
---------------------------------------------------------------------------------------------------------------------------->
The libraries which has been added for the project here are as follows:

 * ggplot2 - plotting package needed to plot complex graphs 

 * tidyverse - used to interact with the data to perform subsetting, visualising, and transforming it.

 * dplyr - used to perform data manipulations

 * ggpubr - used for create elegant ggplot graphs visualisation 

 * GGally - it extends ggplot2 which data objects with much complexity 

 * lubridate -  it makes working with dates ands time values easier

 * cowplot - its an add-on to ggplot including some more functions

#INSTALLATION
---------------------------------------------------------------------------------------------------------------------------->
For creating an project template we need to install the 'ProjectTemplate' package in R. once it has been installed then the library has been imported for further creation of the project template for the project. First, the directory for the ProjectTemplate is fixed using Setwd('#DirectoryPath') function. once it has been done then project is created using the Create.Project('#FileName'). then the project is loaded using the load.project().

The required libraries/Packages present above for the project needs to be installed.

#CONFIGURATION
---------------------------------------------------------------------------------------------------------------------------->
 * The configuration part in this project is that initially we have to set the working directory to the file where we need to store the project. 
 * Install 'ProjectTemplate' package using install.packages() function and import it.
 * Use load.project() function to load the project.
 * The entire dataset needs to be copied in to the data folder of the project directory.
 * Then Preprocessing file for the project is scripted in the Munge folder where refining the dataset removing the unwanted data's from the dataset and subsetting the data for proper understanding will be done at the initial stage.
 * the R Script for Exploratory Data Analysis is stored in the src folder where basec analysis is performed on the refinde dataset and plot are produced to achieve business objectives.
 * Create a R-Markdown file in the report folder adn start typing content and code inside the .rmd file to display the plots inside the file as you progress your report. the syntax to include r code in your .rmd file is ```{r}   #Code    ```. this helps to display plots for your report and simutaenously provide comments for it.
 * Finally, once the report is done we knit the rmd file and the report is generated for the project created and the analysis performed.

#TROUBLESHOOTING
---------------------------------------------------------------------------------------------------------------------------->
No Trouble shooting error found.
