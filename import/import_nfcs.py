import sys
import sqlite3
import json

conn = sqlite3.connect(sys.argv[2])
c = conn.cursor()

# Create table
#c.execute('''CREATE TABLE stocks (date text, trans text, symbol text, qty real, price real)''')

# CREATE TABLE "nfc_records" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "nfc_id" varchar(255), "batch_id" integer, "created_at" datetime, "updated_at" datetime);
nfcs = json.load(open(sys.argv[1]))
for (i, b) in enumerate(nfcs):
    c.execute("INSERT INTO nfc_records VALUES (?, ?, ?, ?, ?)", (i, b['nfc_id'], b['batch_id'], b['created_at'], b['updated_at']))

# Save (commit) the changes
conn.commit()
