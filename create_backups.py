import pymysql

host = "localhost"
user = "backupuser"
password = "abc123!@#"
db = "nutrdb"

def createBackup():
    try:
        con = pymysql.connect(host=host, user=user, password=password, autocommit=True, local_infile=1)
        cursor = con.cursor()
        
        cursor.execute("USE " + db + ";")
        print("Connected to DataBase " + db)
        cursor.execute("set SQL_MODE='';")
        print("set sqlmode")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//YearsBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM years;")
        print("years backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//CountriesBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM countries;")
        print("countries backup created"); 
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//child_mortality_0_5_year_olds_dying_per_1000_bornBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM child_mortality;")
        print("child_mortality  backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//food_supply_kilocalories_per_person_and_dayBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM kcal;")
        print("kcal_per_person_day backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//gdp_total_yearly_growthBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM gdp;")
        print("gdp_total_yearly_growth backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//hapiscore_whrBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM hapiscore;")
        print("hapiscore_whr backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//hdi_human_development_indexBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM hdi;")
        print("hdi loaded")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//malnutrition_weight_for_age_percent_of_children_under_5Backup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM malnutrition;")
        print("malnutrition backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//prevalence_anemia_aged_0_4_percentBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM anemia;")
        print("prevalence_anemia backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//prevalence_overweight_aged_0_4_both_sexes_percentBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM overweight;")
        print("overweight loaded")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//prevalence_severe_wasting_aged_0_4_both_sexes_percentBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM severe_wasting;")
        print("severe_wasting backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//prevalence_stunting_aged_0_4_both_sexes_percentBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM stunting;")
        print("HHHH")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//u5stunted_prcBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM stunting;")
        print("stunting backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//sugar_per_person_g_per_dayBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM sugar_consumption;")
        print("sugar backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//prevalence_undernourishment_population_percentBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM undernourishment;")
        print("undernourishment backup created")
        cursor.execute("SELECT * INTO OUTFILE 'C://ProgramData//MySQL//MySQL Server 8.0//Uploads//prevalence_underweight_aged_0_4_both_sexes_percentBackup.ascii' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '|\\n' FROM underweight;")
        print("underweight backup created")
        print()
        print("Evey row backup created!! Bravo!!")
    except:
        print("Sadly, something went wrong...")
        return
    return

createBackup()

