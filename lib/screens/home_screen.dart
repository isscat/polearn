import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:polearn/screens/auth_screen.dart';

import 'package:polearn/widgets/home_screen_widgets/start_button.dart';
import 'package:polearn/widgets/profile_appbar.dart';

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
          body: Center(
            child: buildStartButton("Start Learning", Colors.blue, context),
          ));
    } else {
      return const AuthScreen();
    }
  }
}
