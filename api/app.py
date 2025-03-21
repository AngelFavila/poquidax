import os
from flask import Flask, request, jsonify
import sys

sys.path.append(f"{os.path.dirname(os.path.abspath(__file__))}\\model\\services")
sys.path.append(f"{os.path.dirname(os.path.abspath(__file__))}\\model\\entities")
import pokemon_service
import users_service
import pokemon
import pokemon_api_consumer as p_consumer

app = Flask(__name__)
users_service = users_service.UserService()
pokemon_service = pokemon_service.PokemonService()

@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/refresh_cache')
def refresh_cache():
    found = p_consumer.refresh_cache()
    return f'Found {found}'

@app.route('/get_cache')
def get_cache():
    return p_consumer.get_all_cache_items()


## USER OPERATIONS
@app.route('/users')
def get_users():
    return users_service.get_users()

@app.route('/users/exists')
def verify_user():
    user_id = request.args.get('id')
    if not user_id:
        return {"error": "Missing 'id' parameter"}, 400
    
    return jsonify({"exists": users_service.user_exist(user_id)})

@app.route('/users/add', methods=['POST'])
def add_user():
    data = request.get_json()  # Get JSON data from request body
    
    user_id = data.get('id')
    user_password = data.get('password')

    if not user_id:
        return jsonify({"error": "Missing 'id' parameter"}), 400
    if not user_password:
        return jsonify({"error": "Missing 'password' parameter"}), 400

    success = users_service.add_user(user_id, user_password)
    return jsonify({"response": success})


## POKEMON OPERATION
@app.route('/pokemons', methods=['GET'])
def get_pokemons():
    user_id = request.args.get('id')
    return pokemon_service.get_personal_pokemons(user_id)

@app.route('/pokemons/exists')
def pokemon_exists():
    user_id = request.args.get('user')
    pokemon_id = request.args.get('id')
    if not user_id:
        return {"error": "Missing 'id' parameter"}, 400
    
    return jsonify({"exists": pokemon_service.pokemon_exist(user_id,pokemon_id)})

@app.route('/pokemon/add_custom', methods=['POST'])
def add_custom_pokemon():
    data = request.get_json()  # Get JSON data from request body
    
    user = data.get('user')
    name = data.get('name')
    level = data.get('level')
    hp = data.get('hp')
    number = data.get('number')

    success = pokemon_service.add_custom_pokemon(pokemon.Pokemon(user,number,name,level,hp))
    return jsonify({"response": success})

if __name__ == '__main__':
    app.run(debug=True,ssl_context='adhoc')