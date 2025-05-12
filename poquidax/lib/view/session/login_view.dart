import 'package:flutter/material.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_banner.dart';
import 'package:pokedax/view/session/painter/arrow_painter.dart';
import 'package:pokedax/view/session/widgets/custom_text_field.dart';
import 'package:pokedax/view/session/widgets/yellow_button.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    final viewModel = Provider.of<LoginViewModel>(context, listen: false);

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
                child: _loginForm(viewModel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _loginForm(LoginViewModel viewModel) {
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
              const SizedBox(height: 40),
              _title(),
              const SizedBox(height: 40),
              _emailField(viewModel),
              const SizedBox(height: 10),
              _passwordField(viewModel),
              const SizedBox(height: 10),
              _loginButton(viewModel),
              const SizedBox(height: 10),
              _signUpButton(viewModel),
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
        shadows: const [
          Shadow(
            blurRadius: 3.0,
            color: Colors.black,
            offset: Offset(0.5, 0.5),
          ),
        ],
      ),
    );
  }

  Widget _emailField(LoginViewModel viewModel) {
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

  Widget _passwordField(LoginViewModel viewModel) {
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

  Widget _loginButton(LoginViewModel viewModel) {
    return YellowButton(
      text: "Ingresar",
      onPressed: viewModel.handleLogin,
      screenSize: screenSize,
    );
  }

  Widget _signUpButton(LoginViewModel viewModel) {
    return YellowButton(
      text: "Crear Cuenta",
      onPressed: viewModel.goToSignUp,
      screenSize: screenSize,
    );
  }
}
