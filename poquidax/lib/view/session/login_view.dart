import 'package:flutter/material.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_banner.dart';
import 'package:pokedax/view/session/painter/arrow_painter.dart';
import 'package:pokedax/view/session/widgets/custom_text_field.dart';
import '../../viewmodel/login_viewmodel.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  final LoginViewModel _viewModel = new LoginViewModel();

  LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late Size screenSize;
  
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);

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
                height: double.infinity,
                alignment: Alignment.center,
                child: _loginForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _loginForm() {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: ArrowPainter(),
          ),
        ),
        Container(
          alignment: Alignment.topCenter, // Centers the content inside
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Prevents Column from taking full height
            children: [
              SizedBox(height: 40),
              Title(),
              SizedBox(height: 40),
              _emailField(),
              SizedBox(height: 10),
              _passwordField(),
              SizedBox(height: 10),
              _loginButton(),
              SizedBox(height: 10),
              _signUpButton(),
            ],
          ),
        ),
      ],
    );
  }

  Text Title(){
    final double fontSize = Theme.of(context).textTheme.bodyLarge!.fontSize!*1.5;

      return Text(
        'Inicio de Sesión',
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.yellow,
          shadows: [
            Shadow(
              blurRadius: 3.0,
              color: Colors.black,
              offset: Offset(0.5, 0.5),
            ),
          ],
        ),
      );
  }
  // Email Field creado desde factory
  Widget _emailField() {
    Size customSize = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 0.04);

    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.2,
          right: MediaQuery.of(context).size.width * 0.2),
      child: CustomTextField(
        label: "Email",
        size: customSize,
        notifier: widget._viewModel.emailNotifier,
        hints: [AutofillHints.email],
        onChanged: (value) {
          widget._viewModel.email = value; // Actualiza el email en el viewmodel
        },
      ),
    );
  }

  // Password field creado desde factory
  Widget _passwordField() {
    Size customSize = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 0.04);

    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.2,
          right: MediaQuery.of(context).size.width * 0.2),
      child: CustomTextField(
        obscureText: true,
        label: "Contraseña",
        size: customSize,
        notifier: widget._viewModel.passwordNotifier,
        hints: [AutofillHints.password],
        onChanged: (value) {
          widget._viewModel.password =
              value; // Actualiza el password en el viewmodel
        },
      ),
    );
  }

  // Login Button
  Widget _loginButton() {
    final double fontSize = Theme.of(context).textTheme.bodyLarge?.fontSize ?? 16.0;

    return SizedBox(
      width: double.infinity,
      height: screenSize.height * 0.04,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2),
        child: ElevatedButton(
          onPressed: () {
            widget._viewModel.handleLogin();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenSize.width * 0.02),
            ),
          ),
          child: Text(
            "Ingresar",
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    final double fontSize =
        Theme.of(context).textTheme.bodyLarge?.fontSize ?? 16.0;

    return SizedBox(
      width: double.infinity,
      height: screenSize.height * 0.04,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2),
        child: ElevatedButton(
          onPressed: () {
            widget._viewModel.goToSignUp();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenSize.width * 0.02),
            ),
          ),
          child: Text("Crear Cuenta", style: TextStyle(fontSize: fontSize)),
        ),
      ),
    );
  }
}
