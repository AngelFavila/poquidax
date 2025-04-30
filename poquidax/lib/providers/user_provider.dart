import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedax/model/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = StateNotifierProvider<UserNotifier, AppUser>(
  (ref) => UserNotifier(),
);


// Notifier del usuario que maneja el estado de la aplicación
// y la persistencia de los datos del usuario en SharedPreferences
class UserNotifier extends StateNotifier<AppUser> {
  late final Future<void> initializationFuture;

  UserNotifier() : super(AppUser(uuid: '', requestToken: '',)){
    initializationFuture = _initialize();
  }

  Future<void> _loadUUID() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUUID = prefs.getString('uuid') ?? '';
    state = state.copyWith(uuid: savedUUID);
  }
  Future<void> _loadRequestToken() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token') ?? '';
    state = state.copyWith(requestToken: savedToken);
  }
  
  get requestToken => state.requestToken;
  get uuid => state.uuid;

  Future<void> _initialize() async {
    await _loadUUID();
    await _loadRequestToken();
  }
  // Métodos para actualizar el estado del usuario y guardar los cambios en SharedPreferences
  // Actualiza el UUID del usuario y lo guarda en SharedPreferences
  Future<void> setUUID(String newUUID) async {
    state = state.copyWith(uuid: newUUID);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uuid', newUUID);
  }

  Future<void> setRequestToken(String token) async {
    state = state.copyWith(requestToken: token);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Método para borrar los datos de usuario del estado y SharedPreferences
  Future<void> clearUserData() async {
    state = state.copyWith(uuid: '', requestToken: '');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uuid');  // Remove the UUID from SharedPreferences
    await prefs.remove('token');  // Remove the token from SharedPreferences
  }
}
