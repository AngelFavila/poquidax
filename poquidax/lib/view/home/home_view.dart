import 'package:flutter/material.dart';
import 'package:pokedax/config/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_banner.dart';
import 'package:pokedax/view/pokedex/pokedex_view.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  final HomeViewModel _viewModel = new HomeViewModel();

  HomeView({super.key,});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: myColorScheme.primary,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          children: [
            BannerContainer(
              height: screenSize.height * 0.15,
              colorScheme: myColorScheme,
            ),
            Expanded(
              child: Container(
                width: double.infinity, 
                height:
                    double.infinity, 
                alignment: Alignment.center,
                child: PokedexView(_viewModel,
                    screenSize: screenSize,
                    screenContent: Placeholder()), 
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Los botones de acción
  Widget _buildActionButtons(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: () {
              _viewModel.onBackButton();
            },
            child: Text("Atrás")),
        ElevatedButton(onPressed: () {}, child: Text("Aceptar")),
      ],
    );
  }

  // Panel de control adicional
  Widget _buildControlPanel(Size screenSize) {
    return Row(
      children: [
        Container(
          width: screenSize.width * 0.4,
          height: screenSize.width * 0.4,
          color: Colors.green,
          child: Center(
            child: Text(
              "Selecciona una opción del menú para continuar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: screenSize.width * 0.2,
          height: screenSize.width * 0.2,
          color: Colors.black,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }

  // El widget del cuadro central
  Widget _buildCentralBox(Size screenSize) {
    return Container(
      width: screenSize.width * 0.75,
      height: screenSize.height * 0.4,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMenuItem(
                "Mis Pokémon", "Lista de mis pokémones", Colors.yellow),
            _buildMenuItem(
                "Atrapar Pokémon", "Agrega tus Pokémones", Colors.white),
            _buildMenuItem("Salir", "Volver al inicio de sesión", Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, String subtitle, Color bgColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Flexible(
        child: Container(
          color: bgColor,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(subtitle, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

class PokeScreenFrame extends StatelessWidget {
  final Size screenSize;
  final Widget screenContent;
  final HomeViewModel viewModel;

  PokeScreenFrame.pokedexScreenFrame({
    super.key,
    required this.screenContent,
    required this.screenSize,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              CustomPaint(size: screenSize, painter: CutCornerPainter()),
              pokedexScreen(screenContent, screenSize),
            ],
          ),
        ],
      ),
    );
  }
}

class CutCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFFDEDEDE) // Background color
      ..style = PaintingStyle.fill;

    var path = Path();
    double cutSize = size.width * 0.15;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(cutSize, size.height);
    path.lineTo(0, size.height - cutSize);
    path.close();

    canvas.drawPath(path, paint);

    var circlePaint = Paint()
      ..color = Color(0xFFDB082D) // Circle color
      ..style = PaintingStyle.fill;

    double radius = size.width * 0.02;

    canvas.drawCircle(
      Offset(size.width / 2 - radius * 2, radius * 4),
      radius,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2 + radius * 2, radius * 4),
      radius,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.16 - radius * 2, size.height * 0.85),
      radius,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget pokedexScreen(Widget screenContent, Size size) {
  return SizedBox(
    width: size.width,
    height: size.height,
    child: Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.10,
        top: size.height * 0.15,
        right: size.width * 0.10,
        bottom: size.height * 0.21,
      ),
      child: screenContent,
    ),
  );
}
