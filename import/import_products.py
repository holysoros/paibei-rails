# -*- coding: utf-8 -*-
import sys
from datetime import datetime
import sqlite3

conn = sqlite3.connect(sys.argv[1])
c = conn.cursor()

# Create table
#c.execute('''CREATE TABLE stocks (date text, trans text, symbol text, qty real, price real)''')
# CREATE TABLE "products" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "place" varchar(255), "elements" text, "price" integer, "created_at" datetime, "updated_at" datetime, "image_file_name" varchar(255), "image_content_type" varchar(255), "image_file_size" integer, "image_updated_at" datetime);

products = [
    { "name" : u"酵素", "place" : u"台湾", "elements" : u"麦芽糊精、葡萄糖、柳橙果汁、糙米、发酵菠萝粉、发酵木瓜粉、植脂末、苹果香精、盐藻、柠檬酸、库拉索芦荟粉、大麦粉。", "price" : 580, "index" : 1 },
    { "name" : u"牛樟菇", "place" : u"台湾", "elements" : u"牛樟菇萃取物95%，明胶", "price" : 6800, "index" : 2 },
    { "name" : u"乳酸菌", "place" : u"台湾", "elements" : u"玉米淀粉，果葡糖浆，乳糖，脱脂奶粉，葡萄糖酸钙，柠檬酸，麦芽糊精，葡萄糖，ABE-乳酸菌，二氧化硅，LN-300乳酸菌，食用香精，叶绿素铜钠盐。", "price" : 380, "index" : 3 }
]

now = datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')

for p in products:
    c.execute("INSERT INTO products VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", (p['index'], p['name'], p['place'], p['elements'], p['price'], now, now, 0, 0, 0, 0))

# Save (commit) the changes
conn.commit()
