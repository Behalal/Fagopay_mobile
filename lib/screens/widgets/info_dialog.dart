import 'package:clean_dialog/clean_dialog.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

showInformationDialog(BuildContext context, String info, String infoTitle){
  showDialog(
    context: context,
    builder: (context) => CleanDialog(
      title: infoTitle,
      content: info,
      backgroundColor: fagoSecondaryColor,
      titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
      contentTextStyle: const TextStyle(fontSize: 14, color: Colors.white,),
      actions: [
        CleanDialogActionButtons(
            actionTitle: 'Ok',
            textColor: fagoSecondaryColor,
            onPressed: (){
              Navigator.pop(context);
            }
        ),
      ],
    ),
  );
}