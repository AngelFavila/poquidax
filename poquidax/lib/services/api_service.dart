import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:pokedax/model/custom_pokemon.dart';
import 'package:pokedax/model/pokemon.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String _baseUrl = 'https://100.117.21.123:5000';

  http.Client _createUnsafeClient() {
    final ioClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    return IOClient(ioClient);
  }

  //Obtiene los Pokémon de un usuario específico por su UID
  Future<List<CustomPokemon>> getPokemonsByUID(String uid) async {
    final client = _createUnsafeClient();
    final response = await client.get(Uri.parse('$_baseUrl/user_pokemons?id=$uid'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList
          .map((e) => CustomPokemon.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  Future<CustomPokemon?> fetchByIdAndUser(int id, String user) async {
  final client = _createUnsafeClient();
  final response = await client.get(Uri.parse('$_baseUrl/user_pokemons?id=$user'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);

    final match = jsonList.firstWhere(
      (item) => item['id'] == id && item['user'] == user,
      orElse: () => null,
    );

    if (match != null) {
      return CustomPokemon(
        user: match['user'],
        id: match['id'],
        number: match['number'],
        name: match['name'],
        level: match['level'],
        hp: match['hp'],
      );
    }
  }

  return null;
}

  // Guarda un Pokémon específico del usuario
  Future<void> savePokemon(CustomPokemon pokemon) async {
    final client = _createUnsafeClient();
    final url = Uri.parse('$_baseUrl/user_pokemon/add_custom');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pokemon.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save pokemon');
    }
  }

  // Actualiza un Pokémon específico del usuario
  Future<void> updatePokemon(CustomPokemon pokemon) async {
    final client = _createUnsafeClient();
    final url = Uri.parse('$_baseUrl/user_pokemon/modify_custom');

    final response = await client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pokemon.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save pokemon');
    }
  }

  // Elimina un Pokémon específico del usuario
  Future<void> removePokemon(CustomPokemon pokemon) async {
    final client = _createUnsafeClient();
    final url = Uri.parse('$_baseUrl/user_pokemon/delete_custom');

    final response = await client.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pokemon.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save pokemon');
    }
  }

  // Obtiene la información de un Pokémon específico por su número
  Future<Pokemon> getPokemonByNumber(int number) async {
    try {
      final client = _createUnsafeClient();
      final response =
          await client.get(Uri.parse('$_baseUrl/get_pokemon?number=$number'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return Pokemon.fromJson(data);
      } else {
        throw Exception('Failed to load Pokémon: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getPokemonByNumber: $e' + e.toString());
      rethrow;
    }
  }

  // Obtiene el listado completo de Pokémon
  Future<List<Pokemon>> getAllPokemons() async {
    final client = _createUnsafeClient();
    final response = await client.get(Uri.parse('$_baseUrl/get_cache'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList
          .map((e) => Pokemon.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }
}
