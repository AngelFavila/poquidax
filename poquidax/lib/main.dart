import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedax/services/firebase/firebase_options.dart';
import 'package:provider/provider.dart';
import 'view/pokedex/pokedex_banner.dart';
import 'viewmodel/main_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Forzado a modo Retrato
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // Forza la aplicación a pantalla completa
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky); 
    
    runApp(const Main());
  });
  // Inicialización de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// Widget inicial de la aplicación
class Main extends StatelessWidget {
  const Main({super.key});
  // ColorScheme de la aplicación
  final ColorScheme myColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFDB082D),
    onPrimary: Colors.white,
    secondary: Color(0xFFFBE335),
    onSecondary: Colors.black,
    error: Color(0xFFB00020),
    onError: Colors.white,
    surface: Color(0xFF56AE60),
    onSurface: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        Size screenSize = MediaQuery.of(context).size;

        return ChangeNotifierProvider(
          // Se asigna el vieweModel que controla el estado de la aplicación
          create: (_) => MainViewModel(screenSize: screenSize),
          child: Consumer<MainViewModel>(
            builder: (context, viewModel, child) {
              return PokedexBody(screenSize, viewModel);
            },
          ),
        );
      },
    );
  }

  /*
  Body del Pokedex el cual incluye el banner con luces y una sección dinámica
  donde se cargan los elementos para login/signup o estructura del pokedex
  y es controlado por su viewModel
  */
  MaterialApp PokedexBody(Size screenSize, MainViewModel viewModel) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: myColorScheme.primary,
      resizeToAvoidBottomInset: false,  // Previene mover el triangulo amarillo y overflow
      body: Column(
        children: [
          bannerContainer(
            height: screenSize.height * 0.15,
            colorScheme: myColorScheme,
          ),
          Expanded(  // This will take up remaining space in the column
            child: Container(
              width: double.infinity,  // Ensure it covers the full width
              height: double.infinity, // Ensure it takes up all available height
              alignment: Alignment.center,
              child: viewModel.screenWidget,  // Your dynamic content widget
            ),
          ),
        ],
      ),
    ),
  );
}



}
