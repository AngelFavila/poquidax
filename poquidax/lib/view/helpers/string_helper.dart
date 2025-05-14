mixin StringHelper {
  String formatAsTitle(String s) => s
    .split(' ')
    .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
    .join(' ');

}