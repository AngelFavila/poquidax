import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'view/shared/main_screen.dart';
import 'view/shared/pokedex_banner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, 
  ]).then((_) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Force fullscreen
    runApp(const MainApp());
  });
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: myColorScheme.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height:MediaQuery.of(context).size.height*0.15,
              child: bannerContainer(colorScheme: myColorScheme),
            ),
            pokeScreenFrameContainer(Placeholder(), MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.4),
            Expanded(child: Placeholder())
          ],
        ),
      ),
    );
  }
}
