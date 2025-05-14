import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_banner.dart';
import 'package:pokedax/view/pokedex/widgets/dpad.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';
import 'package:pokedax/viewmodel/catch_viewmodel.dart';
import 'package:pokedax/viewmodel/pokemon_viewmodel.dart';
import 'package:provider/provider.dart';
import 'widgets/pokedex_screen.dart';

class PokedexTemplate extends StatefulWidget {
  const PokedexTemplate({super.key});

  @override
  _PokedexTemplateState createState() => _PokedexTemplateState();
}

class _PokedexTemplateState extends State<PokedexTemplate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final uri = GoRouterState.of(context).uri;
    final numberStr = uri.queryParameters['number'];
    final viewModel = context.read<PokedexProvider>().viewModel;

    // Si es la pantalla de atrapar, se obtiene el número del pokemon
    if (viewModel is CatchViewModel && numberStr != null) {
      final number = int.tryParse(numberStr);
      if (number != null) {
        viewModel.setSelectePokemonNumber(number);
      }
    }

    // Si es la pantalla de Pokemon, se obtiene el número del pokemon
    final number = int.tryParse(numberStr ?? '');
    if (number != null && viewModel is PokemonViewModel) {
      if (viewModel.pokemon?.number != number) {
        Future.microtask(() => viewModel.setSelectePokemonNumber(number));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
      width: MediaQuery.of(context).size.width * 0.25,
      child: ElevatedButton(
        onPressed: () {
          viewModel.onAcceptButton();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2c6f95),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 20,
            fontFamily: 'Jersey',
          ),
        ),
        child: const Text("Aceptar"),
      ),
    );
  }

  Widget _backButton(PokedexVmInterface viewModel) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: ElevatedButton(
        onPressed: () {
          viewModel.onBackButton();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF901825),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 20, // adjust size as needed
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
            color: Colors.green,
            child: Center(
              child: Text(
                viewModel.secondaryScreenText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
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
