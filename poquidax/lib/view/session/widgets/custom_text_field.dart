import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Size size;
  final ValueNotifier<String> notifier;
  final ValueChanged<String> onChanged;
  final String label;
  final bool obscureText;
  final List<String> hints;

  CustomTextField({
    required this.size,
    required this.notifier,
    required this.onChanged,
    required this.label,
    this.hints = const [],
    this.obscureText = false,
  });

  // Factory constructor for obscured text field
  factory CustomTextField.obscured({
    required Size size,
    required ValueNotifier<String> notifier,
    required ValueChanged<String> onChanged,
    required String label,
  }) {
    return CustomTextField(
      size: size,
      notifier: notifier,
      onChanged: onChanged,
      label: label,
      obscureText: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create a TextEditingController based on the notifier value
    TextEditingController controller = TextEditingController(text: notifier.value);

    // Listen to changes in the notifier
    notifier.addListener(() {
      controller.text = notifier.value;
      controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: TextFormField(
        controller: controller,  // Bind the controller
        onChanged: onChanged,    // Pass the callback for onChanged
        obscureText: obscureText, // Conditionally obscure text
        autofillHints: hints,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
      ),
    );
  }
}
