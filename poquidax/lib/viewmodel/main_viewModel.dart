import 'package:flutter/material.dart';
import 'package:pokedax/view/session/login_view.dart';
import 'package:pokedax/view/session/signup_view.dart';
import 'package:pokedax/view/shared/home_view.dart';
import 'package:pokedax/viewmodel/login_viewModel.dart';
import 'package:pokedax/viewmodel/signup_viewModel.dart';
import 'home_viewModel.dart';

class MainViewModel extends ChangeNotifier {
  Widget _screenWidget = Placeholder();
  bool _isLoggedIn = false;

  Widget get screenWidget => _screenWidget;
  final Size screenSize;

  MainViewModel({required this.screenSize}) {
    _initialize();
  }

  void _initialize() {
    // Verifica que el usuario este loggeado al iniciar la aplicación
    if (_isLoggedIn) {
      _showHomeScreen();
    } else {
      _showLoginScreen();
    }
    updateScreen(screenWidget);
  }

  void updateScreen(Widget newWidget) {
    _screenWidget = newWidget;
    notifyListeners();
  }

  // Construye la pantalla de Home
  void _showHomeScreen() {
  var homeViewModel = HomeViewModel(onBackButton: backButton);
  var homeView = HomeView(
    homeViewModel,
    screenSize: screenSize, 
    onBackButton: backButton,
    screenContent: Placeholder(),
  );
  updateScreen(homeView);
}

void _showLoginScreen() {
  var loginViewModel = LoginViewModel(onLoginResult: handleLoginResult, onSignUpClick: goToSignUp);
  var loginView = LoginView(
    loginViewModel,
    screenSize: screenSize, 
    onLoginResult: handleLoginResult,
  );
  updateScreen(loginView);
}


  void handleLoginResult(bool success) {
    if (success) {
      _showHomeScreen();
    } else {
      _showLoginScreen();
    }
  }

  void backButton() {
    _showLoginScreen();
  }

  void goToSignUp() {
    var signUpViewModel = SignUpViewModel(onSignUpResult: handleLoginResult,onBackButton: backButton);
  var signUpView = SignUpView(
    signUpViewModel,
    screenSize: screenSize, 
    onSignUpResult: handleLoginResult,
  );
  updateScreen(signUpView);
  }
}
