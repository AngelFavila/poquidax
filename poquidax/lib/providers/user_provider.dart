import 'package:flutter/foundation.dart';
import 'package:pokedax/model/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  AppUser _user = AppUser(uuid: '', requestToken: '');
  late final Future<void> initializationFuture;

  UserProvider() {
    initializationFuture = _initialize();
  }

  AppUser get user => _user;
  String get uuid => _user.uuid;
  String get requestToken => _user.requestToken;

  Future<void> _initialize() async {
    await _loadUUID();
    await _loadRequestToken();
  }

  Future<void> _loadUUID() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUUID = prefs.getString('uuid') ?? '';
    _user = _user.copyWith(uuid: savedUUID);
    notifyListeners();
  }

  Future<void> _loadRequestToken() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token') ?? '';
    _user = _user.copyWith(requestToken: savedToken);
    notifyListeners();
  }

  Future<void> setUUID(String newUUID) async {
    _user = _user.copyWith(uuid: newUUID);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uuid', newUUID);
  }

  Future<void> setRequestToken(String token) async {
    _user = _user.copyWith(requestToken: token);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> clearUserData() async {
    _user = _user.copyWith(uuid: '', requestToken: '');
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uuid');
    await prefs.remove('token');
  }
}
