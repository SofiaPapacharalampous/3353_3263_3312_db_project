import pymysql

host = "localhost"
user = "manageruser"
password = "abc123!@#"
db = "nutrdb"

def loadDataToMysql():
    try:
        con = pymysql.connect(host=host, user=user, password=password, autocommit=True, local_infile=1)
        cursor = con.cursor()
        
        cursor.execute("USE " + db + ";")
        print("Connected to DataBase " + db)
        cursor.execute("set SQL_MODE='';")
        print("set sqlmode")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/Years.ascii' INTO TABLE years FIELDS TERMINATED BY '|'")
        print("years loaded")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/Countries.ascii' INTO TABLE countries FIELDS TERMINATED BY '|'")
        print("countries loaded")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/child_mortality_0_5_year_olds_dying_per_1000_born.ascii' INTO TABLE child_mortality FIELDS TERMINATED BY '|'")
        print("child_mortality loaded")
        #//statement.executeUpdate("set SQL_MODE='';");
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/food_supply_kilocalories_per_person_and_day.ascii' INTO TABLE kcal FIELDS TERMINATED BY '|'")
        print("kcal_per_person_day loaded")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/gdp_total_yearly_growth.ascii' INTO TABLE gdp FIELDS TERMINATED BY '|'")
        print("gdp_total_yearly_growth loaded")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/hapiscore_whr.ascii' INTO TABLE hapiscore FIELDS TERMINATED BY '|'")
        print("hapiscore_whr loaded")
        cursor.execute( "LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/hdi_human_development_index.ascii' INTO TABLE hdi FIELDS TERMINATED BY '|'")
        print("hdi loaded")
        cursor.execute( "LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/malnutrition_weight_for_age_percent_of_children_under_5.ascii' INTO TABLE malnutrition FIELDS TERMINATED BY '|'")
        print("malnutrition loaded")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/prevalence_anemia_aged_0_4_percent.ascii' INTO TABLE anemia FIELDS TERMINATED BY '|'")
        print("prevalence_anemia loaded")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/prevalence_overweight_aged_0_4_both_sexes_percent.ascii' INTO TABLE overweight FIELDS TERMINATED BY '|'")
        print("overweight loaded")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/prevalence_severe_wasting_aged_0_4_both_sexes_percent.ascii' INTO TABLE severe_wasting FIELDS TERMINATED BY '|'")
        print("severe_wasting loaded")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/prevalence_stunting_aged_0_4_both_sexes_percent.ascii' INTO TABLE stunting FIELDS TERMINATED BY '|'")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/u5stunted_prc.ascii' IGNORE INTO TABLE stunting FIELDS TERMINATED BY '|'")
        print("stunting loaded")
        cursor.execute( "LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/sugar_per_person_g_per_day.ascii' INTO TABLE sugar_consumption FIELDS TERMINATED BY '|'")
        print("sugar loaded")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/prevalence_undernourishment_population_percent.ascii' INTO TABLE undernourishment FIELDS TERMINATED BY '|'")
        print("undernourishment loaded")
        cursor.execute("LOAD DATA INFILE 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/prevalence_underweight_aged_0_4_both_sexes_percent.ascii' INTO TABLE underweight FIELDS TERMINATED BY '|'")
        print("underweight loaded")
        print()
        print("Evey row loaded!! Bravo!!")
    except:
        print("Sadly, something went wrong...")
        return
    return

loadDataToMysql()

