import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  late Function onBackButton;

  HomeViewModel({required this.onBackButton});

  void handleBackButton() {
    onBackButton();
  }

  void handleLogin() {
    onBackButton();
  }
}
