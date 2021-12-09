import os
import xlrd

global directory

# directory to find data files for normalization
directory = "C:\\Users\\Rodoula\\Desktop\\Vassileiadhs\\data"

def get_list_of_files(directory_name):
    # create a list of file and sub directories
    # names in the given directory
    list_of_file = os.listdir(directory_name)
    all_file = list()
    # Iterate over all the entries
    for entry in list_of_file:
        # Create full path
        full_path = os.path.join(directory_name, entry)
        # If entry is a directory then get the list of files in this directory
        if os.path.isdir(full_path):
            all_file = all_file + get_list_of_files(full_path)
        elif(full_path[-5:] == ".xlsx"):
            all_file.append(full_path)

    return all_file

def get_years_countries(filenames):
    years = set()
    countries = set()
    for file in filenames:
        wb = xlrd.open_workbook(file)
        sheet = wb.sheet_by_index(0)
     
        for i in range(1,sheet.ncols):
            years.add(int(sheet.cell_value(0, i)))
        for i in range(1,sheet.nrows):
            countries.add(sheet.cell_value(i, 0))
    countries = sorted(countries)
    years = sorted(years)
    countries_dict = {countries[k]:k  for k in range(len(countries))}
    years_dict = {years[k]:k  for k in range(len(years))}
    with open(('Years.ascii'), 'w') as f:
        for year in years_dict:
            f.write(str(years_dict[year])+"|"+str(year)+"|"+str((year//10)*10)+"|"+'\n')
    f.close()
    with open(('Countries.ascii'), 'w') as f:
        for country in countries_dict:
            codename = country.replace(" ", "").replace(".", "").replace(",", "").replace("'", "")
            f.write(str(countries_dict[country])+"|"+str(codename)+"|"+str(country)+"|"+'\n')
    f.close()
    return [countries_dict, years_dict]
    
def transform_xlsx_files(lookup_data, filenames):
    [countries_dict, years_dict] = lookup_data
    for file in filenames:
        wb = xlrd.open_workbook(file)
        sheet = wb.sheet_by_index(0)
        index = [] # [[index, Y_ID, C_ID], ...]
        for i in range(1,sheet.nrows):
            for j in range(1,sheet.ncols):
                y = int(sheet.cell_value(0,j))
                c = sheet.cell_value(i, 0)
                if(str(sheet.cell_value(i,j))):
                    if(file.split('\\')[-1] == "u5stunted_prc.xlsx"):
                        #print("hi")
                        index.append([round((sheet.cell_value(i,j)*100),1), years_dict[y], countries_dict[c]])
                    elif(file.split('\\')[-1] == "hdi_human_development_index.xlsx"):
                        index.append([round((sheet.cell_value(i,j)*100),1), years_dict[y], countries_dict[c]])
                    elif(file.split('\\')[-1] == "child_mortality_0_5_year_olds_dying_per_1000_born.xlsx"):
                        index.append([round((sheet.cell_value(i,j)/10),2), years_dict[y], countries_dict[c]])
                    elif(file.split('\\')[-1] == "hapiscore_whr.xlsx"):
                        index.append([round((sheet.cell_value(i,j)*100),1), years_dict[y], countries_dict[c]])
                    elif(file.split('\\')[-1] == "sugar_per_person_g_per_day.xlsx"):
                        index.append([round((sheet.cell_value(i,j)/30)*100, 1), years_dict[y], countries_dict[c]])
                    elif(file.split('\\')[-1] == "food_supply_kilocalories_per_person_and_day.xlsx"):
                        index.append([round((sheet.cell_value(i,j)/2225)*100, 1), years_dict[y], countries_dict[c]])
                    elif(file.split('\\')[-1] == "malnutrition_weight_for_age_percent_of_children_under_5.xlsx"):
                        index.append([round(sheet.cell_value(i,j)*100, 1), years_dict[y], countries_dict[c]])
                    else:
                        index.append([sheet.cell_value(i,j), years_dict[y], countries_dict[c]])
        fn = file.split('\\')[-1].split('.')[0]
        with open((fn + '.ascii'), 'w') as f:
            for tpl in index:        
                f.write(str(tpl[0])+"|"+str(tpl[1])+"|"+str(tpl[2])+"|"+'\n')
        f.close()
        

all_files = get_list_of_files(directory)
#print(all_files)
lookup_data = get_years_countries(all_files)
transform_xlsx_files(lookup_data, all_files)