import 'package:flutter/material.dart';
import 'package:pokedax/viewmodel/selector_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_template.dart';

class SelectorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectorViewModel(),
      child: Consumer<SelectorViewModel>(
        builder: (context, viewModel, child) {
          final screenSize = MediaQuery.of(context).size;

          return Scaffold(
            backgroundColor: myColorScheme.primary,
            resizeToAvoidBottomInset: false,
            body: Container(
              width: screenSize.width,
              height: screenSize.height,
              alignment: Alignment.center,
              child: PokedexTemplate(),
            ),
          );
        },
      ),
    );
  }
}
