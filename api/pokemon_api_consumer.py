import requests

api_url = "https://pokeapi.co/api/v2/pokemon/"

class Pokemon:
    def __init__(self, number, name, sprite, type, hp):
        self.number = number
        self.name = name
        self.sprite = sprite
        self.type = type
        self.hp = hp

def get_pokemon_by_id(id):
    """
    Fetches the Pokémon from the API and returns a Pokemon object.
    """
    try:
        response = requests.get(f'{api_url}{id}', timeout=5)
        if response.status_code != 200:
            return None
        json = response.json()
    except (requests.exceptions.RequestException, requests.exceptions.JSONDecodeError) as e:
        print(f"[ERROR] Failed to get or decode data for ID {id}: {e}")
        return None

    name = json["name"]
    main_type = json["types"][0]["type"]["name"]
    hp = next(stat["base_stat"] for stat in json["stats"] if stat["stat"]["name"] == "hp")
    sprite = json["sprites"]["front_default"]
    return Pokemon(number=id, name=name, sprite=sprite, type=main_type, hp=hp)
