import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/resources/game_methods.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

void gameDialogBox(BuildContext context, String content) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                GameMethods().clearBoard(context);
                Navigator.of(context).pop();
              },
              child: const Text('Play again'),
            )
          ],
        );
      });
}

void gameDialog2(BuildContext context, String text) {
  AwesomeDialog(
    context: context,
    dialogBackgroundColor: Colors.transparent,
    borderSide: const BorderSide(color: Colors.white, width: 5),
    dialogType: DialogType.info,
    headerAnimationLoop: true,
    animType: AnimType.bottomSlide,
    dismissOnTouchOutside: false,
    title: 'RESULTS',
    titleTextStyle: GoogleFonts.tourney(),
    desc: text,
    descTextStyle: GoogleFonts.tourney(fontWeight: FontWeight.bold),
    // btnOkText: 'Play again',
    btnOk: TextButton(
      onPressed: () {
        GameMethods().clearBoard(context);
        Navigator.of(context).pop();
      },
      child: Text(
        'Play again',
        style: GoogleFonts.tourney(color: Colors.yellow),
      ),
    ),
  ).show();
}
