import 'package:flutter/material.dart';

Widget Plate({
  required String text,
  Color? background,
  required BuildContext context,
}) {
  int checkText() {
    if (text.length == 7) {
      return 0;
    } else {
      return 1;
    }
  }

  return Card(
    shadowColor: Colors.blue[850],
    shape: OutlineInputBorder(
      borderSide: const BorderSide(width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 4,
    child: Column(
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "PARAGUAY",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.center,
            child: checkText() == 0
                ? Text(
                    text[0] +
                        text[1] +
                        text[2] +
                        text[3] +
                        "-" +
                        text[4] +
                        text[5] +
                        text[6],
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    text[0] +
                        text[1] +
                        text[2] +
                        "-" +
                        text[3] +
                        text[4] +
                        text[5],
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    ),
  );
}
