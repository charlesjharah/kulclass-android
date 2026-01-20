class CustomFormatNumber {
  static String convert(int number) {
    if (number >= 1000000000) {
      double billions = number / 1000000000;
      return '${billions.toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      double millions = number / 1000000;
      return '${millions.toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      double thousands = number / 1000;
      return '${thousands.toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }
}
