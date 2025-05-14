import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedax/config/router/app_router.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/services/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokedax/services/preferences_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Preferences Service
  await PreferencesService().initialize();

  // Forzado a modo Retrato
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    // Forza la aplicación a pantalla completa
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokedexProvider()),
      ],
      child: const Main(),
    ));
  });
}

// Widget inicial de la aplicación
class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final baseFontSize = MediaQuery.of(context).size.width / 30;

    return MaterialApp.router(
      title: 'Pokedax',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        fontFamily: 'Jersey',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: baseFontSize * 1.4),
          bodyMedium: TextStyle(fontSize: baseFontSize * 1.2),
          bodySmall: TextStyle(fontSize: baseFontSize),
        ),
      ),
    );
  }
}
