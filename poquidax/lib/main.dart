import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedax/config/router/app_router.dart';
import 'package:pokedax/providers/user_provider.dart';
import 'package:pokedax/services/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokedax/services/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final container = ProviderContainer();
  await container.read(userProvider.notifier).initializationFuture;
  
  // Forzado a modo Retrato
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    // Forza la aplicación a pantalla completa
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await PreferencesService().initialize();
    runApp(
      const ProviderScope(
        child: Main(),
      ),
    );
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
        final baseFontSize = MediaQuery.of(context).size.width / 30;

        return MaterialApp.router(
          title: 'Poquidax',
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
      },
    );
  }
}
