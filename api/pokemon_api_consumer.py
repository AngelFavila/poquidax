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
    json = get_pokemon_by_id(id)
    name = json["name"]
    sprite = json[""]
    types = json[""]
    weight = json[""]
    hp = json[""]
    attack = json[""]
    speed = json[""]
    pokemon = Pokemon(id,name,sprite,types,weight,hp,attack,speed)

    return pokemon