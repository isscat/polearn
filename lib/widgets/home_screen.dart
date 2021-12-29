import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polearn/screens/category_screen.dart';

import 'package:polearn/widgets/circular_profile.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  User? curUser;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    curUser = user;
    return Scaffold(
        body: Stack(
      children: [
        Stack(
          children: [
            Container(
              color: Colors.blue,
              height: 150.0,
            ),
            Container(
                margin: const EdgeInsets.only(top: 25),
                alignment: Alignment.topRight,
                child: buildProfile(user.photoURL, context))
          ],
        ),
        Stack(
          children: [
            buildBackContainer(),
            buildColumn(context),
          ],
        ),
      ],
    ));
  }

  Widget buildBackContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 100.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 800,
    );
  }

  Widget buildColumn(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //buildWinner(),
        // buildTopThree(),
        Container(
          child: buildStartButton("Start Learning", Colors.blue, context),
          alignment: Alignment.bottomCenter,
        )
      ],
    ));
  }

  Widget buildWinner() {
    return Card(
      child: Column(
        children: const [],
      ),
    );
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
}
