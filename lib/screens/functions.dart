import 'package:flutter/material.dart';
//import 'package:flutter_svg_provider/flutter_svg_provider.dart';

void goToPage(BuildContext context, Widget route) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) => route));
}

String capitalize(String str) {
  if (str == null || str.isEmpty) {
    return str;
  }
  return str
      .toLowerCase()
      .split(' ')
      .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : word)
      .join(' ');
}

// DecorationImage svgDecorationImage(String asset) {
//     return DecorationImage(
//           image:
//               Svg(asset));
//   }
