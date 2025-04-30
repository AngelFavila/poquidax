import pokemon_api_consumer as pokeapi
from diskcache import Cache

cache_path = './poke_cache'

def refresh_cache():
    """
    Refreshes the Cache of IDs and Names on the server for quicker access
    """
    found = True
    id = 1
    while found:
        pokemon_json = pokeapi.get_pokemon_json_by_id(id)
        if not pokemon_json: 
            found = False
            return id-1 # Returns the id of the last found Pokémo
        id = id+1
        cache = Cache(cache_path) # Gets the cache/starts if it doesn't exist
        cache[str(id)] = pokemon_json["name"] # Replaces/Creates the value for the key based on the ID number
        cache.close()
        print(f'Updated cache for Pokemon with ID {id} with name: {pokemon_json["name"]}')

def get_all_cache_items():
    """
    Returns a list of dicts {number: <id>, name: <Name>} from the server's cache.
    """
    cache = Cache(cache_path)
    if not cache:  # If the cache was never initialized
        refresh_cache()
        cache = Cache(cache_path)

    items = [{"number": key, "name": str(cache[key]).capitalize()} for key in cache]
    cache.close()
    return items
