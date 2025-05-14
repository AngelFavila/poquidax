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
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    
    return IOClient(ioClient);
  }

  Future<List<CustomPokemon>> getPokemonsByUID(String uid) async {
    final client = _createUnsafeClient();
    final response = await client.get(Uri.parse('$_baseUrl/pokemons?id=$uid'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      
      return jsonList.map((e) => CustomPokemon.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  Future<Pokemon> getPokemonByNumber(int number) async {
  try {
    final client = _createUnsafeClient();
    final response = await client.get(Uri.parse('$_baseUrl/get_pokemon?number=$number'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Pokemon.fromJson(data);
    } else {
      throw Exception('Failed to load Pokémon: ${response.statusCode}');
    }
  } catch (e) {
    print('Error in getPokemonByNumber: $e'+e.toString());
    rethrow; // or return a fallback Pokémon if desired
  }
}


  Future<List<Pokemon>> getAllPokemons() async {
    final client = _createUnsafeClient();
    final response = await client.get(Uri.parse('$_baseUrl/get_cache'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) =>Pokemon.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }
}
