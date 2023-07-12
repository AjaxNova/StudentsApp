import 'package:flutter/material.dart';

goto({required BuildContext context, required Widget pageTogo}) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => pageTogo,
  ));
}

void showStudentAddedSnackbar(
    BuildContext context, String text, Color snacolor) {
  final snackbar = SnackBar(
    margin: const EdgeInsets.only(bottom: 10),
    behavior: SnackBarBehavior.floating,
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: snacolor,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
