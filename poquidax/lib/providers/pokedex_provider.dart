import 'package:flutter/widgets.dart';
import 'package:pokedax/viewmodel/base/dummy_viewmodel.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';

class PokedexProvider extends ChangeNotifier {
  late PokedexVmInterface _viewModel;
  late VoidCallback _viewModelListener;

  PokedexVmInterface get viewModel => _viewModel;

  PokedexProvider() {
    _viewModel = DummyViewModel();
    _viewModelListener = () => notifyListeners();
    _viewModel.addListener(_viewModelListener);
  }

  void changeModel(PokedexVmInterface newModel) {
  if (_viewModel.runtimeType == newModel.runtimeType) return;

  print("changeModel called with newModel: ${newModel.runtimeType}");

  _viewModel.removeListener(_viewModelListener);
  _viewModel = newModel;
  _viewModel.addListener(_viewModelListener);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    notifyListeners();
  });
}


  @override
  void dispose() {
    _viewModel.removeListener(_viewModelListener);
    super.dispose();
  }
}
