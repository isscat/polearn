import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var containerCol = const Color.fromRGBO(228, 239, 255, 100);
Widget buildTableHeadings({
  required var containerColor,
  required var dataList,
  required var textColor,
  required var context,
}) {
  return Container(
    color: containerColor,
    height: 34,
    width: MediaQuery.of(context).size.width - 20,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildText(
            color: textColor, data: dataList[0], fontSize: 10, isScore: false),
        buildText(
            color: textColor, data: dataList[1], fontSize: 10, isScore: false),
        buildText(
            color: textColor, data: dataList[2], fontSize: 10, isScore: false),
        buildText(
            color: textColor, data: dataList[3], fontSize: 10, isScore: false),
      ],
    ),
  );
}

buildText({
  data,
  color,
  double fontSize = 10,
  isScore,
}) {
  return SizedBox(
    width: (isScore) ? 20 : 80,
    child: Text(
      data,
      style: GoogleFonts.roboto(color: color, fontSize: fontSize),
      textAlign: TextAlign.left,
    ),
  );
}
