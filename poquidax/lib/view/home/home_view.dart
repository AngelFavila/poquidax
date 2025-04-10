import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_view.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';
import 'package:pokedax/view/home/widgets/main_menu_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(), 
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          final screenSize = MediaQuery.of(context).size;

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
        },
      ),
    );
  }
}