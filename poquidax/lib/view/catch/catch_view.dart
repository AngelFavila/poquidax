import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/catch/widget/catch_form_view.dart';
import 'package:pokedax/viewmodel/catch_viewmodel.dart';
import 'package:pokedax/view/pokedex/pokedex_view.dart';

class CatchView extends ConsumerStatefulWidget {
  const CatchView({super.key});

  @override
  ConsumerState<CatchView> createState() => _CatchViewState();
}
final catchViewModelProvider = ChangeNotifierProvider<CatchViewModel>((ref) {
  return CatchViewModel(ref);
});

class _CatchViewState extends ConsumerState<CatchView> {
  late CatchViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    viewModel = ref.watch(catchViewModelProvider);// Se obtiene el ViewModel

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
          screenContent: CatchFormView(screenSize: screenSize, viewModel: viewModel)
        ),
      ),
    );
  }
}
