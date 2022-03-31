import fnmatch
import os
from xlrd import open_workbook
import codecs

changes = {}

wb = open_workbook('lang.xlsx')
for s in wb.sheets():
    doc = s.name
    for row in range(1, s.nrows):
        key = s.cell(row,0).value
        value = s.cell(row,1).value
        if not doc in changes:
            changes[doc] = {}
        changes[doc][key] = value

root_dir = "../shell/Localized"
for filepath in changes:
    path = root_dir + "/" + filepath + "/" + "Localizable.strings"
    print(path)
    content = []
    for key in changes[filepath]:
        out = "\"" + key + "\" = \"" + changes[filepath][key] + "\";\n\n"
        content.append(out)
    output = ''.join([x for x in content])
    with codecs.open(path, 'w', 'utf-8') as f2: f2.write(output)
