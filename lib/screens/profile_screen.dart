import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:polearn/widgets/logout.dart';
import 'package:polearn/widgets/profile_screen_widgets/color_container.dart';
import 'package:polearn/widgets/profile_screen_widgets/image_container.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var userData;

  ProfileScreen({Key? key, required DocumentSnapshot<Object?>? user, var color})
      : super(key: key) {
    // ignore: prefer_initializing_formals, unnecessary_this

    userData = user;
  }
  var colors = [
    const Color.fromRGBO(25, 52, 152, 1),
  ];
  @override
  Widget build(BuildContext context) {
    var randIdx = Random().nextInt(colors.length);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            // blue area it contains text
            ColorContainer(
              userData: userData,
              color: colors[randIdx],
            ),
            //photo
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ImageContainer(
                  photoUrl: userData?["photoUrl"],
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 323),
                child: Column(
                  children: [
                    buildText("Performance", 24, colors[randIdx]),
                    SizedBox(
                      height: 320,
                      child: buildGrid(),
                    ),
                    // buildText("Days Won", 24, colors[randIdx]),
                    // buildList(userData?["dayWinDates"], randIdx),
                    buildLogout(context)
                  ],
                )),
          ],
        ),
      ),
    );
  }

  buildText(String s, double i, var col) {
    return Text(
      s,
      style: GoogleFonts.getFont("Roboto",
          fontSize: i, fontWeight: FontWeight.bold, color: col),
    );
  }

  buildGrid() {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      children: <Widget>[
        buildCircularProgressBar(
            "Science", userData?["science"], Random().nextInt(colors.length)),
        buildCircularProgressBar("General Knowledge", userData?["general"],
            Random().nextInt(colors.length)),
        buildCircularProgressBar(
            "Languages", userData?["lang"], Random().nextInt(colors.length)),
        buildCircularProgressBar(
            "Tech Hacks", userData?["tech"], Random().nextInt(colors.length)),
        buildCircularProgressBar(
            "GATE", userData?["gate"], Random().nextInt(colors.length)),
        buildCircularProgressBar(
            "NEET", userData?["neet"], Random().nextInt(colors.length)),
      ],
    );
  }

  buildCircularProgressBar(String s, int total, int idx) {
    double percent =
        (total / ((userData["total"] == 0) ? 1 : userData["total"])) * 100;
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(
                1.0,
                14.0,
              ),
              blurRadius: 4.0,
              spreadRadius: 0.0,
            ),
          ],
          border: Border.all(
            color: colors[idx].withAlpha(80),
            width: 5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(70))),
      // padding: EdgeInsets.all(10),
      child: LiquidCircularProgressIndicator(
        value: percent, // Defaults to 0.5.
        valueColor: AlwaysStoppedAnimation(
            colors[idx]), // Defaults to the current Theme's accentColor.
        backgroundColor:
            Colors.white, // Defaults to the current Theme's backgroundColor.
        borderColor: Colors.white,
        borderWidth: 3.0,
        direction: Axis
            .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
        center: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                s,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                percent.toString() + "%",
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  // buildList(userDayWins, int idx) {
  //   return Container(
  //     margin: const EdgeInsets.all(14),
  //     decoration: BoxDecoration(
  //         border: Border.all(color: colors[idx].withAlpha(90), width: 2)),
  //     height: 200,
  //     child: ListView.builder(
  //       itemBuilder: (context, index) {
  //         return Container(
  //           margin: const EdgeInsets.all(10),
  //           width: 200,
  //           height: 70,
  //           decoration: BoxDecoration(
  //               borderRadius: const BorderRadius.all(Radius.circular(15)),
  //               border: Border.all(color: colors[idx].withAlpha(85), width: 1)),
  //           child: Center(
  //             child: Text(
  //               DateFormat.yMMMMd().format(userDayWins[index].toDate()),
  //               style: GoogleFonts.roboto(
  //                 fontSize: 18,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //         );
  //       },
  //       itemCount: userDayWins.length,
  //     ),
  //   );
  // }
}
