# Query engine for data visualization

This repository contains a simple query engine for the optical visualization of health and nutrition data for children under five years old.


# Dependencies
* MySQL Server 8.0
* MySQL Shell 8.0
* MySQL Workbench 8.0
* Python 3

## How to run

### STEP 1

Connect to sql shell.

### STEP 2

Run this line at the MySQL Shell:

mysql> SHOW VARIABLES LIKE "secure_file_priv";

You will get a path like: C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\ 

You will need this path to load the data.

### STEP 3

Load the database schema with this command: mysql> source \your\path\to\createTestDB.sql;

### STEP 4

Run transformation_script.py in a terminal (e.g., cmd). After that drop the .ascii files you will get in the secure_file_priv-folder.

### STEP 5

Run the load_data_script.py in a terminal (e.g., cmd). With that, your new database is full of data!

### STEP 6

From the command line in your project's folder, run this line "npm start" to start the server.

Lastly, connect to http://localhost:3000/ with a browser.



