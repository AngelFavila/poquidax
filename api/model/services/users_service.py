import sqlite3
con = sqlite3.connect("poquidex_users.db")

class UserService():
    def __init__(self):
        con = sqlite3.connect("poquidex_users.db")
        cur = con.cursor()
        cur.execute("CREATE TABLE IF NOT EXISTS user(user TEXT PRIMARY KEY, password TEXT NOT NULL)")
        con.close()

    def get_users(self):
        con = sqlite3.connect("poquidex_users.db")
        cur = con.cursor()
        cur.execute('select * from user')
        rows = cur.fetchall()
        con.close()
        return rows
    
    def user_exist(self,id):
        con = sqlite3.connect("poquidex_users.db")
        cur = con.cursor()
        cur.execute(f"SELECT * FROM user WHERE user='{id}'")
        return cur.fetchone() is not None
    
    def add_user(self,id,password):
        if self.user_exist(id):
            return False
        con = sqlite3.connect("poquidex_users.db")
        cur = con.cursor()
        cur.execute(f"INSERT INTO user VALUES('{id}','{password}')")
        con.commit() 
        
        return cur.rowcount > 0