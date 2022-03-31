import fnmatch
import os
import xlsxwriter
import collections

texts = {}

for root, dirnames, filenames in os.walk('../'):
    for filename in fnmatch.filter(filenames, '*Localized.strings'):
    	dirs = root.split("/")
    	lang = dirs[len(dirs)-1]
    	if not filename in texts:
    		texts[filename] = {}

    	if not lang in texts[filename]:
    		texts[filename][lang] = {}

    	with open(os.path.join(root, filename)) as f:
    		content = f.readlines()
    		for item in content:
    			parts = item.split("\" = \"")
    			if (len(parts) == 2):
	    			key = parts[0].strip()[1:]
	    			value = parts[1].strip()[:-2]
	    			texts[filename][lang][key] = value

workbook = xlsxwriter.Workbook('lang.xlsx')
cell_format_success = workbook.add_format()
cell_format_wrong = workbook.add_format()
cell_format_warning = workbook.add_format()
cell_format_success.set_bg_color('green')
cell_format_wrong.set_bg_color('red')
cell_format_warning.set_bg_color('orange')

ua_dict = texts["Localized.strings"]["uk.lproj"]

for sheet in texts:
	langKeylist = list(texts[sheet].keys())


	for counter, lang in enumerate(langKeylist):
			#create worksheet_leng
			worksheet_leng = workbook.add_worksheet(lang)
			worksheet_leng.write(0, 0, "KEY", cell_format_success)
			worksheet_leng.write(0, 1, "VALUE", cell_format_success)
			print(lang)

			#create key list
			allTextInLang = []
			allTextInLangDict = {}
			for key in texts[sheet][lang]:
				if not key in allTextInLangDict:
					allTextInLangDict[key] = True
					allTextInLang.append(key)
			allTextInLang.sort()

			#write key list
			for counter, key in enumerate(allTextInLang):
				worksheet_leng.write(counter + 1, 0, key)
				
			#write value list
			for counter, key in enumerate(allTextInLang):
				value = texts[sheet][lang][key]
				if not value:
					worksheet_leng.write(counter + 1, 1, value, cell_format_wrong)
				elif value == ua_dict[key] and lang != "uk.lproj":
					worksheet_leng.write(counter + 1, 1, value, cell_format_warning)
				elif value == "*NOT_TRANSLATED*":
					worksheet_leng.write(counter + 1, 1, value, cell_format_wrong)
				elif value == key and lang != "ua.lproj":
					worksheet_leng.write(counter + 1, 1, value, cell_format_warning)
				else:
					worksheet_leng.write(counter + 1, 1, value, cell_format_success)

workbook.close()

for root, dirnames, filenames in os.walk('../'):
    for filename in fnmatch.filter(filenames, '*Localized.strings'):
    	os.remove(root + "/" + filename)