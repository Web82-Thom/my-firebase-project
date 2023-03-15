import 'package:flutter/material.dart';
import 'package:myfirebaseproject/ressources/constants/styles.dart';

class DialogCancelButton extends StatelessWidget {
  const DialogCancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(Colors.red)),
      child: Text(
        "Annuler",
        style: whiteBoldText,
      ),
    );
  }
}