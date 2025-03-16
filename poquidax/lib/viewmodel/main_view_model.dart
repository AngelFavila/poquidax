import 'package:flutter/material.dart';

import '../view/shared/main_screen.dart';

class MainViewModel extends ChangeNotifier {
  List<Widget> _screenWidgets = [];
  bool _isLoggedIn = false;

  List<Widget> get screenWidgets => _screenWidgets;
  final Size screenSize;

  MainViewModel({required this.screenSize}) {
    _initialize();
  }

  void _initialize() {
    // Verifica que el usuario este loggeado al iniciar la aplicación
    if (_isLoggedIn) {
      _screenWidgets = _buildHomeScreen();
    } else {
      _screenWidgets = _buildLoginScreen();
    }
    updateScreen(_screenWidgets);
  }

  void updateScreen(List<Widget> newWidgets) {
    _screenWidgets = newWidgets;
    notifyListeners();
  }

  // Construye la pantalla de Home
  List<Widget> _buildHomeScreen() {
    return [
      pokeScreenFrameContainer(
        Placeholder(),
        screenSize.width,
        screenSize.height * 0.4,
      ),
      ElevatedButton(onPressed: ()=> updateScreen(_buildLoginScreen()), child: Text("Back")),
      Placeholder(),
    ];
  }

  // Construye la pantallde login
  List<Widget> _buildLoginScreen() {
    return [
      Center(
        child: Column(children: [
          TextFormField(),
          TextFormField(
            
          ),
          ElevatedButton(
            onPressed: () =>
                updateScreen(_buildHomeScreen()), //Manda a la ventana principal
            child: Text("Login"),
          ),
        ]),
      ),
    ];
  }
}
