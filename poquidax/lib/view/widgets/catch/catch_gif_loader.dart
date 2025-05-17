import 'package:flutter/material.dart';

class CatchGifLoader extends StatefulWidget {
  @override
  _CatchGifLoaderState createState() => _CatchGifLoaderState();
}

class _CatchGifLoaderState extends State<CatchGifLoader> {
  bool _showCatch = true;

  @override
  void initState() {
    super.initState();
    // Change this duration to match the length of your 'catch.gif'
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showCatch = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        _showCatch
            ? 'assets/animations/catch.gif'
            : 'assets/animations/wiggle.gif',
        fit: BoxFit.contain,
      ),
    );
  }
}
