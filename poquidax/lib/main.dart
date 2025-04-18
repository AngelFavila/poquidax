import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedax/config/router/app_router.dart';
import 'package:pokedax/services/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Forzado a modo Retrato
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // Forza la aplicación a pantalla completa
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

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

  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (context) {
        final baseFontSize = MediaQuery.of(context).size.width/30;

        return MaterialApp.router(
          title: 'Poquidax',
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: ThemeData(fontFamily: 'Jersey',
          textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: baseFontSize * 1.4),
        bodyMedium: TextStyle(fontSize: baseFontSize * 1.2),
        bodySmall: TextStyle(fontSize: baseFontSize),
      ),),

        );
      },
    );
  }
}
