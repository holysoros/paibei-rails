import sys
import sqlite3
import json

conn = sqlite3.connect(sys.argv[2])
c = conn.cursor()

# Create table
#c.execute('''CREATE TABLE stocks (date text, trans text, symbol text, qty real, price real)''')
# CREATE TABLE "batches" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "product_id" integer, "dist_place" integer, "count" integer, "verify_time" integer, "bid" varchar(255), "created_at" datetime, "updated_at" datetime);
batches = json.load(open(sys.argv[1]))
for b in batches:
    c.execute("INSERT INTO batches VALUES (?, ?, ?, ?, ?, ?, ?, ?)", (b['id'], b['product_id'], b['dist_place'], b['count'], b['verify_time'], b['bid'], b['created_at'], b['updated_at']))

# Save (commit) the changes
conn.commit()
