import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polearn/widgets/score_widget.dart';

PreferredSize profileAppBar() {
  return PreferredSize(
    preferredSize: Size(70, 70),
    child: AppBar(
        title: const Text("PoLearn"),
        toolbarHeight: 70, // Set this height
        flexibleSpace: Container(
            margin: const EdgeInsets.only(top: 25),
            alignment: Alignment.topRight,
            child: Center(
              child: ScoreWidget(
                  userid: FirebaseAuth.instance.currentUser?.uid,
                  isAppBar: true),
            ))),
  );
}
