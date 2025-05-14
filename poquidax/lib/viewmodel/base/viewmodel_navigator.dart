import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/viewmodel/base/dummy_viewmodel.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';
import 'package:pokedax/viewmodel/catch_selector_viewmodel.dart';
import 'package:pokedax/viewmodel/catch_viewmodel.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';
import 'package:pokedax/viewmodel/pokemon_viewmodel.dart';
import 'package:provider/provider.dart';

mixin ViewModelNavigator {
  // Cambia el viewmodel actual
  void changeModel(PokedexVmInterface model) {
    final context = NavigationService.navigatorKey.currentContext!;
    final provider = Provider.of<PokedexProvider>(context, listen: false);
    provider.changeModel(model);
  }

  // Cambia el viewmodel y hace pop
  void changeModelAndPop(PokedexVmInterface model) {
    changeModel(model);
    NavigationService.pop();
  }

  // Hace push a nueva pantalla y cambia el viewmodel dependiendo de la ruta
  void navigateTo(String route) {
    final viewModel = _viewModelForRoute(route);
    changeModel(viewModel);
    // Cambia el viewmodel y hace push
    NavigationService.push(route);
  }

  // Determina el viewmodel dependiendo de la ruta
  PokedexVmInterface _viewModelForRoute(String route) {
  // Extrae el path de la ruta, ignorando los parámetros de consulta
  String path = route.contains('?') ? route.substring(0, route.indexOf('?')) : route;

  switch (path) {
    case '/':
      return HomeViewModel();
    case '/catch_selector':
      return CatchSelectorViewModel();
    case '/catch':
      return CatchViewModel();
    case '/pokemon':
      return PokemonViewModel();
    default:
      return DummyViewModel();
  }
}

}
