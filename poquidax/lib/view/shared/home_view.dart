import 'package:flutter/material.dart';
import '../../viewmodel/home_viewModel.dart';
import 'package:pokedax/view/widgets/dpad.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  final Widget screenContent;
  HomeViewModel _viewModel;
  final Size screenSize;

  HomeView(
    this._viewModel, {
    super.key,
    required this.screenSize,
    required Function onBackButton,
    required this.screenContent,
  }) {
    _viewModel.onBackButton = onBackButton;
  }

  void _handleUp() {
    print("Arriba");
    // Lógica para mover hacia arriba
  }

  void _handleDown() {
    print("Abajo");
    // Lógica para mover hacia abajo
  }

  void _handleLeft() {
    print("Izquierda");
    // Lógica para mover hacia la izquierda
  }

  void _handleRight() {
    print("Derecha");
    // Lógica para mover hacia la derecha
  }

  void _handleCenter() {
    print("Centro");
    // Lógica para el botón central
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double sidePadding = constraints.maxWidth * 0.15;
          double topPadding = constraints.maxHeight * 0.05;

          return SizedBox(
            child: Padding(
              padding: EdgeInsets.only(
                left: sidePadding,
                top: topPadding,
                right: sidePadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PokeScreenFrame.pokedexScreenFrame(
                    screenContent: screenContent,
                    screenSize: Size(screenSize.width, screenSize.height * 0.4),
                    viewModel: _viewModel,
                  ),
                  // Cruceta (DPad)
                  DPad(
                    onUp: _handleUp,
                    onDown: _handleDown,
                    onLeft: _handleLeft,
                    onRight: _handleRight,
                    onCenter: _handleCenter,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PokeScreenFrame {
  static pokedexScreenFrame(
      {required Widget screenContent,
      required Size screenSize,
      required HomeViewModel viewModel}) {}
}
