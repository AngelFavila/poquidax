import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pokedax/viewmodel/pokedex_vm_interface.dart';

class DummyViewModel extends ChangeNotifier implements PokedexVmInterface {
  @override
  void onBackButton() {
    print("Back Button pressed");
    notifyListeners();
  }

  @override
  void onAcceptButton() {
    print("Accept Button pressed");
    notifyListeners();
  }

  @override
  void onDPadUp() {
    print("DPad Up pressed");
    notifyListeners();
  }

  @override
  void onDPadDown() {
    print("DPad Down pressed");
    notifyListeners();
  }

  @override
  void onDPadLeft() async {
    print("DPad Left pressed");
    notifyListeners();
  }

  @override
  void onDPadRight() {
    print("DPad Right pressed");
    notifyListeners();
  }
  
  @override
  String secondaryScreenText = "Dummy Screen";

  @override
  Widget screenContent = Placeholder(); // Placeholder text for secondary screen
}