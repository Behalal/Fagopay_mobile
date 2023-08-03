extension ExtendedString on String {
  /// The string without any whitespace.
  String removeWhitespace() {
    // Remove all white space.
    return this.replaceAll(RegExp(r"\s+"), "");
  }
}