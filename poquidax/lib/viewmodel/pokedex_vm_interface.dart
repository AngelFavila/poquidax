import 'package:flutter/widgets.dart';

abstract class PokedexVmInterface extends ChangeNotifier {
  late Widget	_screenContent;	
  Widget get screenContent=>_screenContent;

  late String _secondaryScreenText;

  String get secondaryScreenText => _secondaryScreenText;

  set secondaryScreenText(String value) {
    _secondaryScreenText = value;
  }

  // Remove the screenContent management from the ViewModel
  void onBackButton();

  void onAcceptButton();

  void onDPadUp();

  void onDPadDown();

  void onDPadLeft();

  void onDPadRight();
}
