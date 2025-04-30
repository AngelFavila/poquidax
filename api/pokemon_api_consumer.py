import requests

api_url = "https://pokeapi.co/api/v2/pokemon/" #pokemon ui
class Pokemon:
    def __init__(self,id,name,sprite,types,weight,hp,attack,speed):
        self.id = id
        self.name = name
        self.sprite = sprite
        self.types = types
        self.weight = weight
        self.hp = hp
        self.attack = attack
        self.speed = speed

def get_pokemon_json_by_id(id):
    """
    Retrieves a Pokemon's Information based on it's number ID.
    """
    response = requests.get(f'{api_url}{id}')
    if response == 'Not Found': 
        return
    return response.json()

def get_pokemon_by_id(id): 
    json = get_pokemon_json_by_id(id)
    if json is None:
        return None

    name = json["name"]
    main_type = json["types"][0]["type"]["name"]  # First type
    hp = next(stat["base_stat"] for stat in json["stats"] if stat["stat"]["name"] == "hp")

    pokemon = Pokemon(id, name, None, main_type, None, hp, None, None)
    return pokemon