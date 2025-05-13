import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_banner.dart';
import 'package:pokedax/view/pokedex/widgets/dpad.dart';
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
  Widget build(BuildContext context) {
    final pokedexProvider = context.watch<PokedexProvider>();
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            viewModel.onBackButton();
          },
          child: Text("Atrás"),
        ),
        ElevatedButton(
          onPressed: () {
            viewModel.onAcceptButton();
          },
          child: Text("Aceptar"),
        ),
      ],
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
