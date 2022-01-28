import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ColorContainer extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var userData;
  var col;
  ColorContainer({Key? key, required var userData, required color})
      : super(key: key) {
    // ignore: prefer_initializing_formals
    this.userData = userData;
    this.col = color;
  }
  @override
  Widget build(BuildContext context) {
    var userTotalScore = userData?['gate'] +
        userData?['science'] +
        userData?['general'] +
        userData?['lang'] +
        userData?['neet'] +
        userData?['tech'];
    var dayWinCount = userData?["dayWin"];
    return Container(
      height: 221,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(userData?["username"],
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText("Score"),
                  buildText(userTotalScore.toString())
                ],
              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 53),
                child: Text(
                  "Day Winner",
                  style: TextStyle(
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, right: 5),
                width: 120,
                height: 37,
                child: Center(
                  child: Text(
                    dayWinCount.toString() + " times",
                    style: TextStyle(
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(237, 167, 8, 1),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              )
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
          color: col,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
    );
  }

  buildText(String string) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        string,
        style: TextStyle(
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w100,
            color: Colors.white),
      ),
    );
  }
}
