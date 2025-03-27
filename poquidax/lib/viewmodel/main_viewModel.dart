import 'package:flutter/material.dart';
import 'package:pokedax/view/pokedex/pokedex_view.dart';
import 'package:pokedax/view/session/login_view.dart';
import 'package:pokedax/view/session/signup_view.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';
import 'package:pokedax/viewmodel/login_viewmodel.dart';
import 'package:pokedax/viewmodel/signup_viewModel.dart';

/*
ViewModel del View de Pokedex que controla los estados y contiene los métodos genéricos de las pantallas
*/
class MainViewModel extends ChangeNotifier {
  Widget _screenWidget = Placeholder();
  bool _isLoggedIn = false;

  Widget get screenWidget => _screenWidget;
  final Size screenSize;

  MainViewModel({required this.screenSize}) {
    _initialize();
  }

  // Método que se corre al iniciar la aplicación
  void _initialize() {
    // Verifica que el usuario este loggeado al iniciar la aplicación
    if (_isLoggedIn) {
      // Si inicio sesión correctamente muestra la pantalla
      _showHomeScreen();
    } else {
      // Si no esta igresado lo envía a la pantalla de Inicio de sesión
      _showLoginScreen();
    }
    // Actualiza la pantalla cargada
    _updateScreen(screenWidget);
  }

  // Actualiza el widget cargado en la pantalla
  void _updateScreen(Widget newWidget) {
    _screenWidget = newWidget;
    notifyListeners();
  }

  // Construye la pantalla de Home y la muestra
  void _showHomeScreen() {
    var homeViewModel = HomeViewModel(onBackButton: _showLoginScreen);
    var homeView = PokedexView(homeViewModel, screenSize: screenSize, screenContent: Placeholder());
    _updateScreen(homeView);
  }

  // Método que construye la pantalla de login
  void _showLoginScreen() {
    var loginViewModel = LoginViewModel(onLoginResult: handleLoginResult, onSignUpClick: goToSignUp);
    var loginView = LoginView(
      loginViewModel,
      screenSize: screenSize, 
      onLoginResult: handleLoginResult,
    );
    _updateScreen(loginView);
  }


  /* 
  Método que se dispara al hacer el Callback en el View de Login.
  Este esta asignado al método onLoginResult del LoginViewModel.
  */ 
  void handleLoginResult(bool success) {
    if (success) {
      _showHomeScreen();
    } else {
      _showLoginScreen();
    }
  }

  // Método que se dispara al hacer el Callback en el View
  void backButton() {
    _showLoginScreen();
  }

  // Metodo para cargar Página de Sign Up
  void goToSignUp() {
    var signUpViewModel = SignUpViewModel(
        onSignUpResult: handleLoginResult, onBackButton: backButton);
    var signUpView = SignUpView(
      signUpViewModel,
      screenSize: screenSize,
      onSignUpResult: handleLoginResult,
    );
    _updateScreen(signUpView);
  }
}
