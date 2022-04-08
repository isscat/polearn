import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:polearn/screens/auth_screen.dart';
import 'package:polearn/screens/profile_screen.dart';
import 'package:polearn/widgets/category_container.dart';

import 'package:polearn/widgets/home_screen_widgets/start_button.dart';
import 'package:polearn/widgets/profile_appbar.dart';

/*
This is where home screen is displayed with 
top 10 scorers and celebration animation.

 */
// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? curUser;
  // ignore: prefer_typing_uninitialized_variables
  var highestScorer;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    curUser = user;
    if (curUser != null) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: profileAppBar(),
          body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 270,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: buildWinnerGif(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        child: Text(
                          "Today's Top Scorers",
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.pink[200]!,
                                    offset: const Offset(0, 3))
                              ],
                              fontFamily: GoogleFonts.jotiOne().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildCurrentWinner(),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: buildStartButton(
                    "Start Learning", Colors.pink[200]!, context),
              ),
            ]),
          ));
    } else {
      return const AuthScreen();
    }
  }

  buildCurrentWinner() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        height: 300,
        decoration: boxDecoration,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("user")
              .orderBy("total", descending: true)
              .limit(10)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var winDocs = snapshot.data?.docs;

              return ListView.builder(
                itemCount: winDocs?.length,
                itemBuilder: (context, index) {
                  var total = winDocs?[index]["total"].toString();
                  return Column(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 70,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 230,
                                    child: Row(
                                      children: [
                                        buildWinImage(winDocs?[index], context),
                                        Flexible(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            winDocs?[index]["username"],
                                            style: TextStyle(
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "score: " + total!,
                                        style: const TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Divider(
                                color: Colors.pink[200],
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(
                child: SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }

  buildWinImage(winDoc, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileScreen(
                      user: winDoc,
                      color: Colors.blue,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                color: Color.fromARGB(255, 138, 133, 133),
                offset: Offset(0, 4))
          ],
          border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          image: DecorationImage(
              image: NetworkImage(winDoc?["photoUrl"]), fit: BoxFit.cover),
        ),
      ),
    );
  }

  buildWinnerGif() {
    return Image.asset("assets/winner.gif");
  }
}
