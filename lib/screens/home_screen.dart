import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:polearn/screens/category_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:polearn/widgets/circular_profile.dart';
import 'package:polearn/widgets/score_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? curUser;
  var highestScorer;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    curUser = user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text("PoLearn"),
          toolbarHeight: 70, // Set this height
          flexibleSpace: Container(
              margin: const EdgeInsets.only(top: 25),
              alignment: Alignment.topRight,
              child: Center(
                child: ScoreWidget(
                    userid: FirebaseAuth.instance.currentUser?.uid,
                    isAppBar: true),
              ))),
      body: Stack(
        children: [
          //buildBackgroundImage
          Column(
            children: [
              buildWinnerContainer(),
              // buildTopThree(),
              buildColumn(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildColumn(BuildContext context) {
    return Center(
        child: Container(
      child: buildStartButton("Start Learning", Colors.blue, context),
      alignment: Alignment.bottomCenter,
    ));
  }

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
          textStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  buildWinnerContainer() {
    if (highestScorer == null) {
      FirebaseFirestore.instance
          .collection("user")
          .orderBy("total", descending: true)
          .limit(1)
          .get()
          .then((value) => {
                // ignore: avoid_function_literals_in_foreach_calls
                value.docs.forEach((element) {
                  bool flag = true;
                  for (var value in element["dayWinDates"]) {
                    if (DateFormat.yMd().format(DateTime.now()) ==
                        DateFormat.yMd().format(value.toDate())) {
                      flag = false;
                      break;
                    }
                  }
                  if (flag) {
                    // then add new win date
                    FirebaseFirestore.instance
                        .collection("user")
                        .doc(element["uid"])
                        .update({
                      "dayWinDates": FieldValue.arrayUnion([DateTime.now()]),
                      "dayWin": FieldValue.increment(1)
                    });
                  }

                  setState(() {
                    highestScorer = {
                      "uid": element["uid"],
                      "username": element["username"],
                      "score": element["total"],
                      "photoUrl": element["photoUrl"],
                    };
                  });
                })
              });
      return CircularProgressIndicator();
    }
    return Stack(children: [
      Container(
        margin: EdgeInsets.all(30),
        width: 242,
        height: 321,
        child: (highestScorer != null)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AvatarGlow(
                    glowColor: Colors.white,
                    endRadius: 100.0,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 10),
                    animate: true,
                    child: Material(
                      // Replace this child with your own
                      elevation: 2.0,
                      shape: CircleBorder(),
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(70)),
                            image: DecorationImage(
                                image: NetworkImage(highestScorer?["photoUrl"]),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromRGBO(236, 164, 0, 1),
                      ),
                      height: 100,
                      child: Text(
                        "Today’s Winner: " +
                            highestScorer?["username"] +
                            "\n" +
                            "Score: " +
                            highestScorer["score"].toString(),
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.5),
                        textAlign: TextAlign.center,
                      ))
                ],
              )
            : Text("Be the First One to Win"),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(25, 52, 152, 1),
            boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 4)],
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
    ]);
  }
}
