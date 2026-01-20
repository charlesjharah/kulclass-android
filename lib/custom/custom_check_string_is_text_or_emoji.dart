class CustomCheckStringIsTextOrEmoji {
  static bool onCheck(String input) {
    final RegExp textRegExp = RegExp(r'^[a-zA-Z0-9]+$');

    return textRegExp.hasMatch(input);
  }
}
