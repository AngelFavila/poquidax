import 'package:flutter/material.dart';

class DPad extends StatelessWidget {
  final VoidCallback onUp;
  final VoidCallback onDown;
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final VoidCallback onCenter;

  const DPad({
    super.key,
    required this.onUp,
    required this.onDown,
    required this.onLeft,
    required this.onRight,
    required this.onCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Botón de arriba
          IconButton(
            icon: const Icon(Icons.arrow_drop_up),
            onPressed: onUp,
            iconSize: 50,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Botón de la izquierda
              IconButton(
                icon: const Icon(Icons.arrow_left),
                onPressed: onLeft,
                iconSize: 50,
              ),
              // Botón central
              IconButton(
                icon: const Icon(Icons.circle),
                onPressed: onCenter,
                iconSize: 50,
              ),
              // Botón de la derecha
              IconButton(
                icon: const Icon(Icons.arrow_right),
                onPressed: onRight,
                iconSize: 50,
              ),
            ],
          ),
          // Botón de abajo
          IconButton(
            icon: const Icon(Icons.arrow_drop_down),
            onPressed: onDown,
            iconSize: 50,
          ),
        ],
      ),
    );
  }
}
