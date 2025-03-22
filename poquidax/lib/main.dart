import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedax/firebase_options.dart';
import 'package:provider/provider.dart';
import 'view/shared/pokedex_banner.dart';
import 'viewmodel/main_viewModel.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky); // Force fullscreen
    
    runApp(const MainApp());
  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return Builder(
      builder: (context) {
        Size screenSize = MediaQuery.of(context).size;

        return ChangeNotifierProvider(
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

  MaterialApp PokedexBody(Size screenSize, MainViewModel viewModel) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: myColorScheme.primary,
      body: Column(
        children: [
          bannerContainer(
              height: screenSize.height,
              colorScheme: myColorScheme), 
          Expanded(
            child: Container(
              alignment: Alignment.center, 
              child: viewModel.screenWidget,
            ),
          ),
        ],
      ),
    ),
  );
}


}
