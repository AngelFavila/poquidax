import os
from flask import Flask, request, jsonify
import sys

base_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(base_dir, "model", "services"))
sys.path.append(os.path.join(base_dir, "model", "entities"))
import pokemon_service
import users_service
import pokemon
import pokemon_api_consumer as p_consumer
import cache_manager as p_cache




app = Flask(__name__)
users_service = users_service.UserService()
pokemon_service = pokemon_service.PokemonService()

@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/refresh_cache')
def refresh_cache():
    found = pokemon_service.fetch_and_add_all_pokemons()
    return f'Found {found}'

@app.route('/get_cache')
def get_cache():
    return pokemon_service.get_pokemons()


## POKEMON OPERATION
@app.route('/pokemons', methods=['GET'])
# Lists of pokemons by user id
def get_pokemons_by_user_id():
    user_id = request.args.get('id')
    return pokemon_service.get_personal_pokemons(user_id)

@app.route('/pokemons/exists')
def pokemon_exists_by_user_and_id():
    user_id = request.args.get('user')
    pokemon_id = request.args.get('id')
    if not user_id:
        return {"error": "Missing 'id' parameter"}, 400
    
    return jsonify({"exists": pokemon_service.pokemon_exist(user_id,pokemon_id)}), 200

@app.route('/pokemon/add_custom', methods=['POST']) 
def add_custom_pokemon():
    try:
        data = request.get_json()  # Get JSON data from request body
        
        user = data.get('user')
        name = data.get('name')
        level = data.get('level')
        hp = data.get('hp')
        number = data.get('number')

        print(f"Received data: {data}")  # Add logging

        success = pokemon_service.add_custom_pokemon(pokemon.Pokemon(user, number, name, level, hp))
        return jsonify({"response": success}), 200
    
    except Exception as e:
        print(f"Error: {e}")  # Log any exceptions
        return jsonify({"error": "Internal server error"}), 500

@app.route('/pokemon/modify_custom', methods=['PUT']) 
def modify_custom_pokemon():
    try:
        data = request.get_json()  # Get JSON data from request body
        id = data.get('id')
        user = data.get('user')
        name = data.get('name')
        level = data.get('level')
        hp = data.get('hp')
        number = data.get('number')

        print(f"Received data: {data}")  # Add logging

        success = pokemon_service.modify_custom_pokemon(pokemon.Pokemon(user, number, name, level, hp, id= id))
        return jsonify({"response": success}), 200
    
    except Exception as e:
        print(f"Error: {e}")  # Log any exceptions
        return jsonify({"error": "Internal server error"}), 500

@app.route('/pokemon/delete_custom', methods=['DELETE']) 
def delete_custom_pokemon():
    try:
        data = request.get_json()  # Get JSON data from request body
        id = data.get('id')
        user = data.get('user')

        print(f"Received data: {data}")  # Add logging

        success = pokemon_service.delete_custom_pokemon(id= id, user=user)
        return jsonify({"response": success}), 200
    
    except Exception as e:
        print(f"Error: {e}")  # Log any exceptions
        return jsonify({"error": "Internal server error"}), 500

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=5000,ssl_context='adhoc')