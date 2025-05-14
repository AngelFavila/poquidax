import json
import os
import sys
import pokemon
import pymssql
import pokemon_api_consumer as pokeapi

current_dir = os.path.dirname(os.path.abspath(__file__))
entities_dir = os.path.join(current_dir, '..', 'entities')
sys.path.append(entities_dir)

settings_path = os.path.join(current_dir, '..', '..', 'settings.json')


class PokemonService:
    def __init__(self):
        # Connect to the server (without specifying a database)
        server_connection = self.get_server_connection()
        server_connection.autocommit(True)  # Enable autocommit for the CREATE DATABASE statement
        server_cursor = server_connection.cursor()

        # Check if the database exists, and create it if it doesn't
        server_cursor.execute("""
            IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'poquidex_pokemons')
            CREATE DATABASE poquidex_pokemons
        """)
        server_connection.close()

        # Proceed with the usual connection to the database
        con = self.get_connection()
        cur = con.cursor()
        cur.execute("""
            IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='pokemon' AND xtype='U')
            CREATE TABLE pokemon(
                number INT,
                name NVARCHAR(50),
                sprite NVARCHAR(250),
                hp INT,
                type NVARCHAR(50)
            )
        """)
        cur.execute("""
            IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='custom_pokemon' AND xtype='U')
            CREATE TABLE custom_pokemon(
                [user] NVARCHAR(50),
                id INT IDENTITY(1,1) PRIMARY KEY,
                number INT,
                name NVARCHAR(50),
                level INT,
                hp INT
            )
        """)
        con.commit()
        con.close()


    def get_server_connection(self):
        with open(settings_path, 'r') as file:
            settings = json.load(file)
        return pymssql.connect(
            server=settings['server'],
            user=settings['username'],
            password=settings['password']
        )

    
    
    def get_connection(self):
        with open(settings_path, 'r') as file:
            settings = json.load(file)
        return pymssql.connect(
            server=settings['server'],
            user=settings['username'],
            password=settings['password'],
            database=settings['database']
        )
    
    def fetch_and_add_all_pokemons(self):
        """
        Fetches Pokémon from the API and adds them to the DB if not already present.
        """
        id = 1
        while True:
            pokemon = pokeapi.get_pokemon_by_id(id)
            if not pokemon:
                print(f"Finished fetching at ID {id - 1}")
                break

            success = self.add_pokemon(pokemon)
            if success:
                print(f"Added Pokémon ID {id}: {pokemon.name}")
            else:
                print(f"Skipped Pokémon ID {id}: already exists")
            id += 1

    def add_pokemon(self, pokemon: pokemon.Pokemon):
        if self.pokemon_exist(pokemon.number):
            return False
        con = self.get_connection()
        cur = con.cursor()
        cur.execute("""
            INSERT INTO pokemon(number, name, hp,type,sprite)
            VALUES (%s, %s, %s, %s, %s)
        """, (pokemon.number, pokemon.name, pokemon.hp, pokemon.type, pokemon.sprite))
        con.commit()
        rowcount = cur.rowcount
        con.close()
        return rowcount > 0
    
    def pokemon_exist(self, id):
        con = self.get_connection()
        cur = con.cursor()
        cur.execute("SELECT * FROM pokemon WHERE number=%s", (id))
        exists = cur.fetchone() is not None
        con.close()
        return exists
    
    def get_pokemons(self):
        con = self.get_connection()
        cur = con.cursor()
        cur.execute("SELECT * FROM pokemon")
        rows = cur.fetchall()
        columns = [column[0] for column in cur.description]  # Get column names
        con.close()
        return [dict(zip(columns, row)) for row in rows] 
    
    def get_pokemon(self, number):
        con = self.get_connection()
        cur = con.cursor()
        cur.execute("SELECT * FROM pokemon WHERE number=%s", (number,))
        row = cur.fetchone()
        columns = [column[0] for column in cur.description]
        con.close()
        return dict(zip(columns, row)) if row else None

    
    def get_personal_pokemons(self, username):
        con = self.get_connection()
        cur = con.cursor()
        cur.execute("SELECT * FROM custom_pokemon WHERE [user]=%s", username)
        rows = cur.fetchall()
        columns = [column[0] for column in cur.description]  # Get column names
        con.close()
        return [dict(zip(columns, row)) for row in rows]  # Convert rows to JSON-like dictionaries

    def custom_pokemon_exist(self, user, id):
        con = self.get_connection()
        cur = con.cursor()
        cur.execute("SELECT * FROM custom_pokemon WHERE [user]=%s AND id=%s", (user, id))
        exists = cur.fetchone() is not None
        con.close()
        return exists

    def add_custom_pokemon(self, pokemon: pokemon.Pokemon):
        if self.custom_pokemon_exist(pokemon.user, pokemon.id):
            return False
        con = self.get_connection()
        cur = con.cursor()
        cur.execute("""
            INSERT INTO custom_pokemon([user], number, name, level, hp)
            VALUES (%s, %s, %s, %s, %s)
        """, (pokemon.user, pokemon.number, pokemon.name, pokemon.level, pokemon.hp))
        con.commit()
        rowcount = cur.rowcount
        con.close()
        return rowcount > 0

    def modify_custom_pokemon(self, pokemon: pokemon.Pokemon):
        if not self.custom_pokemon_exist(pokemon.user, pokemon.id):
            return False
        con = self.get_connection()
        cur = con.cursor()
        cur.execute("""
            UPDATE custom_pokemon
            SET number = %s, name = %s, level = %s, hp = %s
            WHERE [user] = %s AND id = %s
        """, (pokemon.number, pokemon.name, pokemon.level, pokemon.hp, pokemon.user, pokemon.id))
        con.commit()
        rowcount = cur.rowcount
        con.close()
        return rowcount > 0

    def delete_custom_pokemon(self, id, user):
        if not self.custom_pokemon_exist(user, id):
            return False
        con = self.get_connection()
        cur = con.cursor()
        cur.execute("""
            DELETE FROM custom_pokemon
            WHERE [user] = %s AND id = %s
        """, (user, id))
        con.commit()
        rowcount = cur.rowcount
        con.close()
        return rowcount > 0

    