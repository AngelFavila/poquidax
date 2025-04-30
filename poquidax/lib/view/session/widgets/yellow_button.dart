import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Size screenSize;

  const YellowButton({
    super.key,
    required this.text,
    required this.onPressed, 
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    final double fontSize =
        Theme.of(context).textTheme.bodyLarge?.fontSize ?? 16.0;

    return SizedBox(
      width: double.infinity,
      height: screenSize.height * 0.04,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenSize.width * 0.02),
            ),
          ),
          child: Text(text, style: TextStyle(fontSize: fontSize)),
        ),
      ),
    );
  }
}
