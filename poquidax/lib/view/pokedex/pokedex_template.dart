import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_banner.dart';
import 'package:pokedax/view/pokedex/widgets/dpad.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';
import 'package:pokedax/viewmodel/pokemon_viewmodel.dart';
import 'package:pokedax/viewmodel/catch_form_viewmodel.dart';
import 'package:provider/provider.dart';
import 'widgets/pokedex_screen.dart';

class PokedexTemplate extends StatefulWidget {
  const PokedexTemplate({super.key});

  @override
  _PokedexTemplateState createState() => _PokedexTemplateState();
}

class _PokedexTemplateState extends State<PokedexTemplate> {
  final Map<String, int> _initializedNumbers = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final uri = GoRouterState.of(context).uri;
    final numberStr = uri.queryParameters['number'];
    final number = int.tryParse(numberStr ?? '');
    final viewModel = context.read<PokedexProvider>().viewModel;

    if (number == null) return;

    // CatchFormViewModel case
    if (viewModel is CatchFormViewModel) {
      if (_initializedNumbers['catch'] != number &&
          viewModel.pokemon?.number != number) {
        _initializedNumbers['catch'] = number;
        Future.microtask(() => viewModel.setSelectePokemonNumber(number));
      }
    }

    // PokemonViewModel case
    if (viewModel is PokemonViewModel) {
      final userStr = uri.queryParameters['uid'];
      if (userStr != null &&
          _initializedNumbers['pokemon'] != number &&
          viewModel.pokemon?.number != number) {
        _initializedNumbers['pokemon'] = number;
        Future.microtask(
            () => viewModel.setSelectePokemonNumber(number, userStr));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var viewModel = context.watch<PokedexProvider>().viewModel;

    if (viewModel.isDialogVisible) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    viewModel.showDialog(); // reset the flag
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(viewModel.dialogText),
        actions: [
          TextButton(
            onPressed: () {
              viewModel.noPressed();
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              viewModel.yesPressed();
              Navigator.of(context).pop();
            },
            child: const Text('Si'),
          ),
        ],
      ),
    );
  });
}


    return Scaffold(
      backgroundColor: myColorScheme.primary,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double sidePadding = constraints.maxWidth * 0.15;
            double topPadding = constraints.maxHeight * 0.05;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _pokedexBanner(),
                  _pokedexBody(topPadding, sidePadding),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _pokedexBanner() {
    return BannerContainer(
      height: MediaQuery.of(context).size.height * 0.15,
      colorScheme: myColorScheme,
    );
  }

  Padding _pokedexBody(double topPadding, double sidePadding) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding, left: sidePadding, right: sidePadding),
      child: Column(
        children: [
          // Use the screenContent from PokedexProvider
          PokedexScreen.pokedexScreen(
            screenSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.4),
          ),
          _buildActionButtons(),
          _buildControlPanel(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final viewModel = context.watch<PokedexProvider>().viewModel;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _backButton(viewModel),
          _acceptButton(viewModel),
        ],
      ),
    );
  }

  Widget _acceptButton(PokedexVmInterface viewModel) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ElevatedButton(
        onPressed: () {
          viewModel.onAcceptButton();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2c6f95),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 25,
            fontFamily: 'Jersey',
          ),
        ),
        child: const Text("Aceptar"),
      ),
    );
  }

  Widget _backButton(PokedexVmInterface viewModel) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ElevatedButton(
        onPressed: () {
          viewModel.onBackButton();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF901825),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 25, // adjust size as needed
            fontFamily: 'Jersey',
          ),
        ),
        child: const Text("Atrás"),
      ),
    );
  }

  Widget _buildControlPanel() {
    final viewModel = context.watch<PokedexProvider>().viewModel;

    return Row(
      children: [
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
              child: Center(
                child: viewModel.secondaryScreenContent,
              ),
            ),
          ),
        ),
        DPad(
          size: MediaQuery.of(context).size.width * .25,
          onUpPressed: viewModel.onDPadUp,
          onDownPressed: viewModel.onDPadDown,
          onLeftPressed: viewModel.onDPadLeft,
          onRightPressed: viewModel.onDPadRight,
        ),
      ],
    );
  }
}
