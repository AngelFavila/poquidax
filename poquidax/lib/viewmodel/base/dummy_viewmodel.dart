import 'package:flutter/material.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';

class DummyViewModel extends ChangeNotifier implements PokedexVmInterface {
  @override
  Widget secondaryScreenContent = Text("Dummy Screen");

  @override
  Widget screenContent = Expanded(child: Container(color: Colors.black, ),); 
  
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
  set secondaryScreenWidget(Widget value) {
    // TODO: implement secondaryScreenWidget
  }
}