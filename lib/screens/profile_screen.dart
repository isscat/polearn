import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  var userData;
  ProfileScreen({Key? key, required QueryDocumentSnapshot<Object?> user})
      : super(key: key) {
    // ignore: prefer_initializing_formals
    this.userData = user;
  }

  @override
  Widget build(BuildContext context) {
    var colors = [
      Color.fromRGBO(19, 33, 158, 1),
      Color.fromRGBO(210, 25, 192, 1),
      Color.fromRGBO(26, 155, 183, 1),
      Color.fromRGBO(246, 119, 119, 1),
      Color.fromRGBO(235, 70, 149, 1),
      Color.fromRGBO(50, 82, 136, 1),
    ];
    var randIdx = Random().nextInt(6);
    var userTotalScore = userData?['gate'] +
        userData?['science'] +
        userData?['general'] +
        userData?['lang'] +
        userData?['neet'] +
        userData?['tech'];
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: 221,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 26),
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
                      padding: const EdgeInsets.only(right: 10, top: 43),
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
                      margin: EdgeInsets.only(top: 10, right: 5),
                      width: 120,
                      height: 37,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(237, 167, 8, 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                    )
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
                color: colors[randIdx],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
          ), // blue area it contains text
        ],
      )),
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
