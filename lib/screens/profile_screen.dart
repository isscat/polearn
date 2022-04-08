import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:polearn/widgets/logout.dart';
import 'package:polearn/widgets/profile_screen_widgets/color_container.dart';
import 'package:polearn/widgets/profile_screen_widgets/image_container.dart';

import '../widgets/profile_screen_widgets/profile_edit_container.dart';

/*
This displays user profile that contains performance and ability to change profile photo
and username and displays their score

 */
// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var userData;
  // ignore: prefer_typing_uninitialized_variables
  var photoUrl;
  ProfileScreen({Key? key, required DocumentSnapshot<Object?>? user, var color})
      : super(key: key) {
    // ignore: prefer_initializing_formals, unnecessary_this

    userData = user;
    photoUrl = user?["photoUrl"];
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var colors = [
    const Color.fromARGB(255, 158, 176, 243),
    const Color.fromARGB(255, 238, 160, 154),
    const Color.fromARGB(255, 250, 178, 202),
    const Color.fromARGB(255, 240, 214, 135),
    const Color.fromARGB(255, 172, 248, 175)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            // blue area it contains text
            ColorContainer(
              userData: widget.userData,
              color: Colors.blue[900],
            ),
            //photo
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 120,
                    width: 150,
                    child: Stack(
                      children: [
                        ImageContainer(
                          photoUrl: widget.photoUrl,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ProfileEditContainer(
                              uid: widget.userData?["uid"],
                              func: changePhotoUrl),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 323),
                child: Column(
                  children: [
                    buildText("Performance", 24, Colors.blue[900]),
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
        buildCircularProgressBar("Science", widget.userData?["science"],
            Random().nextInt(colors.length)),
        buildCircularProgressBar("General Knowledge",
            widget.userData?["general"], Random().nextInt(colors.length)),
        buildCircularProgressBar("Languages", widget.userData?["lang"],
            Random().nextInt(colors.length)),
        buildCircularProgressBar("Tech Hacks", widget.userData?["tech"],
            Random().nextInt(colors.length)),
        buildCircularProgressBar(
            "GATE", widget.userData?["gate"], Random().nextInt(colors.length)),
        buildCircularProgressBar(
            "NEET", widget.userData?["neet"], Random().nextInt(colors.length)),
      ],
    );
  }

  buildCircularProgressBar(String s, int total, int idx) {
    double percent = (total /
            ((widget.userData["total"] == 0) ? 1 : widget.userData["total"])) *
        100;
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

  changePhotoUrl(String url, ctx) {
    setState(() {
      widget.photoUrl = url;
      // ignore: deprecated_member_use
      // Scaffold.of(ctx).hideCurrentSnackBar();
    });
  }
}
