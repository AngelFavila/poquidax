import 'package:flutter/material.dart';
import 'package:pokedax/services/navigation_service.dart';

class HomeViewModel extends ChangeNotifier {

  HomeViewModel();

  void onBackButton() {
    NavigationService.go('/login');
  }
}
