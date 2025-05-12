import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_banner.dart';
import 'package:pokedax/view/pokedex/widgets/dpad.dart';
import 'package:pokedax/viewmodel/pokedex_vm_interface.dart';
import 'package:provider/provider.dart';
import 'widgets/pokedex_screen.dart';

class PokedexTemplate extends StatefulWidget {
  final Size screenSize;

  const PokedexTemplate({super.key, required this.screenSize});
  
  @override
  _PokedexTemplateState createState() => _PokedexTemplateState();
}

class _PokedexTemplateState extends State<PokedexTemplate> {
  @override
  Widget build(BuildContext context) {
    final pokedexProvider = context.watch<PokedexProvider>();
    final viewModel = pokedexProvider.viewModel;

    return Scaffold(
      backgroundColor: myColorScheme.primary,
      body: SizedBox(
        height: widget.screenSize.height,
        width: widget.screenSize.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double sidePadding = constraints.maxWidth * 0.15;
            double topPadding = constraints.maxHeight * 0.05;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _pokedexBanner(),
                  _pokedexBody(topPadding, sidePadding, viewModel),
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
      height: widget.screenSize.height * 0.15,
      colorScheme: myColorScheme,
    );
  }

  Padding _pokedexBody(double topPadding, double sidePadding, PokedexVmInterface viewModel) {
    final pokedexProvider = context.watch<PokedexProvider>();

    return Padding(
      padding: EdgeInsets.only(
        top: topPadding, 
        left: sidePadding, 
        right: sidePadding
      ),
      child: Column(
        children: [
          // Use the screenContent from PokedexProvider
          PokedexScreen.pokedexScreen(
            screenContent: pokedexProvider.screenContent,
            screenSize: Size(widget.screenSize.width, widget.screenSize.height * 0.4),
            viewModel: viewModel,
          ),
          _buildActionButtons(viewModel),
          _buildControlPanel(viewModel),
        ],
      ),
    );
  }

  Widget _buildActionButtons(PokedexVmInterface viewModel) {
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

  Widget _buildControlPanel(PokedexVmInterface viewModel) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: widget.screenSize.width * 0.05),
          child: Container(
            width: widget.screenSize.width * 0.4,
            height: widget.screenSize.width * 0.4,
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
          size: widget.screenSize.width * .25,
          onUpPressed: viewModel.onDPadUp,
          onDownPressed: viewModel.onDPadDown,
          onLeftPressed: viewModel.onDPadLeft,
          onRightPressed: viewModel.onDPadRight,
        ),
      ],
    );
  }
}
