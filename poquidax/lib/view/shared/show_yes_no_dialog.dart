import 'package:flutter/material.dart';

Future<void> showYesNoDialog({
  required BuildContext context,
  required String message,
  required VoidCallback onYes,
  required VoidCallback onNo,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Confirmación'),
      content: Text(message),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
          onNo();
        }, child: const Text('No')),
        TextButton(onPressed: () {
          Navigator.pop(context);
          onYes();
        }, child: const Text('Sí')),
      ],
    ),
  );
}
