import 'package:flutter/material.dart';
import 'package:pokedax/view/login/login_view.dart';
import 'package:pokedax/view/shared/home_view.dart';
import 'login_viewModel.dart';
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
      screenSize: Size(screenSize.width, screenSize.height * 0.85),
      onBackButton: backButton,
      screenContent: Placeholder(),
    );
    updateScreen(homeView);
  }

  void _showLoginScreen() {
    var loginViewModel = LoginViewModel(onLoginResult: handleLoginResult);
    var loginView = LoginView(loginViewModel,
        screenSize: Size(screenSize.width, screenSize.height * 0.85),
        onLoginResult: handleLoginResult);
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
}
