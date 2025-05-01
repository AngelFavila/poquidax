abstract class PokedexVmInterface {
  late String _secondaryScreenText;
  String get secondaryScreenText => _secondaryScreenText;
  set secondaryScreenText(String value) {
    _secondaryScreenText = value;
  }
  void onBackButton();

  void onAcceptButton();

  void onDPadUp();

  void onDPadDown();

  void onDPadLeft();

  void onDPadRight();
}