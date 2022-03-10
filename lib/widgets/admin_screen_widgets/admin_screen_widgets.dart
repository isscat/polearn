import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildAdminText() {
  return Container(
    margin: const EdgeInsets.all(10),
    child: Text(
      "Hello Admin!",
      style: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: const Color.fromRGBO(141, 127, 127, 100),
      ),
    ),
  );
}
