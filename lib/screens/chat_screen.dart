import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polearn/widgets/chat/messages.dart';
import 'package:polearn/widgets/chat/new_message.dart';
import 'package:polearn/widgets/circular_profile.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  String chatName = "neet";
  String name = "neet";
  User? curUser;
  ChatScreen({Key? key, String chat = "neet", String name = ""})
      : super(key: key) {
    final user = FirebaseAuth.instance.currentUser!;
    curUser = user;
    chatName = chat;
    // ignore: prefer_initializing_formals
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(name),
          toolbarHeight: 70, // Set this height
          flexibleSpace: Container(
              margin: const EdgeInsets.only(top: 25),
              alignment: Alignment.topRight,
              child: buildProfile(curUser!.photoURL, context))),
      body: Column(
        children: [
          Expanded(
              child: Messages(
            chat: chatName,
          )),
          NewMessage(
            chat: chatName,
          )
        ],
      ),
    );
  }
}
