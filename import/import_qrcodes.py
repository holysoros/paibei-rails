import sys
import sqlite3
import json

conn = sqlite3.connect(sys.argv[2])
c = conn.cursor()

# Create table
#c.execute('''CREATE TABLE stocks (date text, trans text, symbol text, qty real, price real)''')

# CREATE TABLE "qrcode_records" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "batch_id" integer, "sn" varchar(255), "left_time" integer, "created_at" datetime, "updated_at" datetime, "index" integer);
qrcodes = json.load(open(sys.argv[1]))
for (i, b) in enumerate(qrcodes):
    c.execute("INSERT INTO qrcode_records VALUES (?, ?, ?, ?, ?, ?, ?)", (i, b['batch_id'], b['sn'], b['left_time'], b['created_at'], b['updated_at'], b['index']))

# Save (commit) the changes
conn.commit()
