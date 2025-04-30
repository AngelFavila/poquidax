import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/catch_selector/widgets/catch_widget.dart';
import 'package:pokedax/viewmodel/catch_selector_viewmodel.dart';

import 'package:pokedax/view/pokedex/pokedex_view.dart';

class CatchSelectorView extends ConsumerStatefulWidget {
  const CatchSelectorView({super.key});

  @override
  ConsumerState<CatchSelectorView> createState() => _CatchSelectorViewState();
}

final catchViewModelProvider = ChangeNotifierProvider<CatchSelectorViewModel>((ref) {
  return CatchSelectorViewModel(ref);
});

class _CatchSelectorViewState extends ConsumerState<CatchSelectorView> {
  late CatchSelectorViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    viewModel = ref.watch(catchViewModelProvider); // Se obtiene el ViewModel

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
          screenContent: CatchWidget(screenSize: screenSize, viewModel: viewModel),
        ),
      ),
    );
  }
}
