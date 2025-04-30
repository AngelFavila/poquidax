import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_view.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';
import 'package:pokedax/view/home/widgets/main_menu_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}
final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel(ref);
});

class _HomeViewState extends ConsumerState<HomeView> {
  late HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    viewModel = ref.watch(homeViewModelProvider);// Se obtiene el ViewModel

    return Scaffold(
      backgroundColor: myColorScheme.primary,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        alignment: Alignment.center,
        child: PokedexView(
          viewModel, // Se asigna el ViewModel al PokedexView
          screenSize: screenSize,
          screenContent: MainMenu(
            screenSize: screenSize,
            viewModel: viewModel,
          ),
        ),
      ),
    );
  }
}
