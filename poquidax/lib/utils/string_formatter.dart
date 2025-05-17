import 'package:intl/intl.dart';

String formatAsCurrency(double amount) {
  // Formatea el número como moneda en el formato de Estados Unidos
  return NumberFormat.currency(locale: "en_US",symbol: "\$").format(amount);
}

String formatAsTitle(String? title) {
  if (title == null || title.isEmpty) {
    return '';
  }

  return title
      .split(' ')
      .map((word) =>
          word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '')
      .join(' ');
}
