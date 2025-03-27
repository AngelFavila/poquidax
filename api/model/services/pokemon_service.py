import sqlite3
import os
import sys
import pokemon

current_dir = os.path.dirname(os.path.abspath(__file__))
entities_dir = os.path.join(current_dir, '..', 'entities')
sys.path.append(entities_dir)



class PokemonService:
    def __init__(self):
        con = sqlite3.connect("poquidex_pokemons.db")
        cur = con.cursor()
        cur.execute("CREATE TABLE IF NOT EXISTS pokemon(number,name,species,hp,type)")
        cur.execute("""
            CREATE TABLE IF NOT EXISTS custom_pokemon(
                user TEXT,
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                number INTEGER,
                name TEXT,
                level INTEGER,
                hp INTEGER
            )
        """)

        con.close()

    def get_personal_pokemons(self, username):
        con = sqlite3.connect("poquidex_pokemons.db")
        cur = con.cursor()
        cur.execute(f"select * from custom_pokemon WHERE user='{username}'")
        rows = cur.fetchall()
        con.close()
        return rows

    def pokemon_exist(self, user,id):
        con = sqlite3.connect("poquidex_pokemons.db")
        cur = con.cursor()
        cur.execute(f"SELECT * FROM custom_pokemon WHERE user='{user}' and id='{id}'")
        return cur.fetchone() is not None

    def add_custom_pokemon(self, pokemon : pokemon.Pokemon):
        if self.pokemon_exist(pokemon.user,pokemon.id):
            return False
        con = sqlite3.connect("poquidex_pokemons.db")
        cur = con.cursor()
        cur.execute(f"""
                    INSERT INTO custom_pokemon(user,number,name,level,hp) VALUES('{pokemon.user}',
                        '{pokemon.number}',
                        '{pokemon.name}',
                        '{pokemon.level}',
                        '{pokemon.hp}'
                        )""")
        con.commit()

        return cur.rowcount > 0
    
    def modify_custom_pokemon(self, pokemon : pokemon.Pokemon):
        if not self.pokemon_exist(pokemon.user,pokemon.id):
            return False
        con = sqlite3.connect("poquidex_pokemons.db")
        cur = con.cursor()
        query = f"""
                    UPDATE custom_pokemon 
                        set number = '{pokemon.number}',
                        name ='{pokemon.name}',
                        level = '{pokemon.level}',
                        hp ='{pokemon.hp}' 
                        WHERE user='{pokemon.user}' and id={pokemon.id}"""
        cur.execute(query)
        con.commit()

        return cur.rowcount > 0
    
    def delete_custom_pokemon(self, id, user):
        if not self.pokemon_exist(user,id):
            return False
        con = sqlite3.connect("poquidex_pokemons.db")
        cur = con.cursor()
        query = f"""
                    DELETE FROM custom_pokemon 
                        WHERE user='{pokemon.user}' and id={pokemon.id}"""
        cur.execute(query)
        con.commit()

        return cur.rowcount > 0

