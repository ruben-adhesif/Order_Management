# Order Management Model
ESILV A4-S7 2023-2024  
Advance Database Management  
Teacher : Fatima Zahra KAGHAT

Students
- Ruben LEON DIA1 CDOF4 @ruben_adhesif  
- Ntsoa RANDRIA DIA6 CDOF4 @RandriaNtsoa28  

[GitHub link of the repos](https://github.com/ruben-adhesif/Order_Management.git)

# Data cleaning

Project done on Oracle SQL\*Plus 
File .csv are download on DVL and store in `/data/raw`
Run `data/clean.py` to creat a clean version of this file store in `/data`
This clean data will be use for the reast of the project

During the cleaning, the python file will
- read the raw file in `/data/raw`
- remove the blank space at the end of each cells of some of the columns
- convert some float in int to have coherent foreign key
- convert True/False in T/F to easy SQL\*Loader
- impose the standard '.' for the decimal delimitation
- store the clean .csv file on the `/data` folder

## Database Initialisation

For initialisation, go on the main folder and run `call init.bat`  
This file is a series of instructions for Command Prompt (don't work with PowerShell)
This file will :
- create a user `owner/root@xepdb1`
- create all the tables
- insert all the csv file with SQL\*Loader
- connect to the user `owner`

For SQL\*Loader (sqlldr), all the file are store in `/sqlldr`
The .ctl file are the ones with the instruction. We skip the first line of the csv because won't be understood by sqlldr.
After the loader, a log file will be create or update in `/sqlldr/log`. 
If any line is misunderstood, a bad file (very similar to a csv file) will be generate in `/sqlldr/bad`

# Work on Database 

A `schema.plantuml` file has been created to understand the relations between the tables. A picture of it result have been store in `schema.png`

The `query.sql` have all the request of the part 2 about SQL queries.

The `order_management.pbix` have the dashboard on PowerBI. PowerBI has directly connected to the Oracle Database with the Data Connectivity Mode 'Import'.
The personalize schema have been about the Average Price of each Vendor to guess the selling position (luxury or affordable) of each company.
