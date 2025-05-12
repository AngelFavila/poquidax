import 'package:flutter/widgets.dart';
import 'package:pokedax/viewmodel/dummy_viewmodel.dart';
import 'package:pokedax/viewmodel/pokedex_vm_interface.dart';

class PokedexProvider extends ChangeNotifier {
  late PokedexVmInterface _viewModel;
  late Widget _screenContent;

  late VoidCallback _viewModelListener;

  PokedexVmInterface get viewModel => _viewModel;
  Widget get screenContent => _screenContent;

  Size screenSize = const Size(0, 0); 

  PokedexProvider() {
    _viewModel = DummyViewModel();  
    _screenContent = const Placeholder(); 
    
    _viewModelListener = () {
      notifyListeners();
    };
  }

  void changeModel(PokedexVmInterface newModel, Widget newScreenContent) {
    print("changeModel called with newModel: ${newModel.runtimeType}");
    // Remove the listener from the old model if it's a ChangeNotifier
    if (_viewModel is ChangeNotifier) {
      (_viewModel as ChangeNotifier).removeListener(_viewModelListener);
    }

    // Assign the new model and screen content
    _viewModel = newModel;
    _screenContent = newScreenContent;

    // Add the listener to the new model if it's a ChangeNotifier
    if (_viewModel is ChangeNotifier) {
      (_viewModel as ChangeNotifier).addListener(_viewModelListener);
    }

    // Notify listeners immediately
    notifyListeners();
  }

  void ensureModel(PokedexVmInterface vm, Widget content) {
    print("ensureModel called with vm: ${vm.runtimeType}");
    final sameVM = _viewModel.runtimeType == vm.runtimeType;
    final sameContent = _screenContent.runtimeType == content.runtimeType;

    // Only update if the VM or content has actually changed
    if (!sameVM || !sameContent) {
      _viewModel = vm;
      _screenContent = content;
      
      // Notify listeners immediately
      notifyListeners();
    }
  }
}


