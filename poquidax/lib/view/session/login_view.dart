import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_banner.dart';
import 'package:pokedax/view/session/painter/arrow_painter.dart';
import 'package:pokedax/view/session/widgets/custom_text_field.dart';
import 'package:pokedax/view/session/widgets/yellow_button.dart';
import '../../viewmodel/login_viewmodel.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late Size screenSize;
  late LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    viewModel = LoginViewModel(ref);

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
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40),
              _title(),
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

  Text _title() {
    final double fontSize =
        Theme.of(context).textTheme.bodyLarge!.fontSize! * 1.5;

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

  Widget _emailField() {
    Size customSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height * 0.04,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.2,
      ),
      child: CustomTextField(
        size: customSize,
        notifier: viewModel.emailNotifier,
        onChanged: (value) {
          viewModel.email = value;
        },
        label: "Email",
      ),
    );
  }

  Widget _passwordField() {
    Size customSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height * 0.04,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.2,
      ),
      child: CustomTextField.obscured(
        size: customSize,
        notifier: viewModel.passwordNotifier,
        onChanged: (value) {
          viewModel.password = value;
        },
        label: "Contraseña",
      ),
    );
  }

  Widget _loginButton() {
    return YellowButton(
      text: "Ingresar",
      onPressed: viewModel.handleLogin,
      screenSize: screenSize,
    );
  }

  Widget _signUpButton() {
    return YellowButton(
      text: "Crear Cuenta",
      onPressed: viewModel.goToSignUp,
      screenSize: screenSize,
    );
  }
}
