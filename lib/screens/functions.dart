import 'package:flutter/material.dart';

void goToPage(BuildContext context, Widget route) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) => route));
}
