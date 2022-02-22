import 'package:flutter/material.dart';
import 'package:polearn/screens/category_screen.dart';

Widget buildStartButton(String s, Color color, BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CategoryScreen()),
      );
    },
    child: Text(s),
    style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        primary: color,
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  );
}
