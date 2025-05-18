import 'package:flutter/widgets.dart';

abstract class PokedexVmInterface extends ChangeNotifier{
  late Widget	_screenContent;	
  Widget get screenContent=>_screenContent;

  late Widget _secondaryScreenContent;

  Widget get secondaryScreenContent => _secondaryScreenContent;

  set secondaryScreenWidget(Widget value) {
    _secondaryScreenContent = value;
  }

  // Remove the screenContent management from the ViewModel
  void onBackButton();

  void onAcceptButton();

  void onDPadUp();

  void onDPadDown();

  void onDPadLeft();

  void onDPadRight();

  bool _isDialogVisible = false;
  bool get isDialogVisible => _isDialogVisible;

  String _dialogText = '';
  String get dialogText => _dialogText;

  void noPressed();
  void yesPressed();
  void showDialog();
}
