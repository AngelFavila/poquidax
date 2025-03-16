import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  late Function onBackButton;

  HomeViewModel({required this.onBackButton});

  // Handle login logic
  void handleLogin() {
    onBackButton();
  }
}