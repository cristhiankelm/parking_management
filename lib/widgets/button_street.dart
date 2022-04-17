import 'package:flutter/material.dart';

Widget MyButton({
  required String text,
  required Color background,
  required BuildContext context,
}) {
  return Container(
    width: 150,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: background,
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
