import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;
  PreferencesService._internal();

  String _uuid = '';
  String _requestToken = '';


  Future<void> _loadUUID() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUUID = prefs.getString('uuid') ?? '';
    _uuid = savedUUID;
  }
  Future<void> _loadRequestToken() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token') ?? '';
    _requestToken = savedToken;
  }
  
  get requestToken => _requestToken;
  get uuid => _uuid;

  Future<void> initialize() async {
    await _loadUUID();
    await _loadRequestToken();
  }
  // Métodos para actualizar el estado del usuario y guardar los cambios en SharedPreferences
  // Actualiza el UUID del usuario y lo guarda en SharedPreferences
  Future<void> setUUID(String newUUID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uuid', newUUID);
    _uuid = newUUID;
  }

  Future<void> setRequestToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    _requestToken = token;
  }

  // Método para borrar los datos de usuario del estado y SharedPreferences
  Future<void> clearUserData() async {
    _uuid = '';
    _requestToken = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uuid');  // Remove the UUID from SharedPreferences
    await prefs.remove('token');  // Remove the token from SharedPreferences
  }
}
