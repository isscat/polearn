import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'build_options.dart';

String chatName = "";

class RoundedAlertBox extends StatefulWidget {
  RoundedAlertBox({Key? key, required String chat}) : super(key: key) {
    chatName = chat;
  }

  @override
  _RoundedAlertBoxState createState() => _RoundedAlertBoxState();
}

class _RoundedAlertBoxState extends State<RoundedAlertBox> {
  Color? myColor = const Color.fromARGB(253, 197, 71, 1);
  var message = {
    "question": "",
    "op1": "",
    "op2": "",
    "op3": "",
    "op4": "",
    "ans": "",
  };
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          openAlertBox();
        },
        child: Container(
          margin: const EdgeInsets.all(15),
          width: 65,
          height: 60,
          decoration: BoxDecoration(
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  offset: Offset(
                    0.0,
                    4.0,
                  ))
            ],
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            image: const DecorationImage(
              image: AssetImage('assets/poll.png'),
            ),
          ),
        ));
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              width: 400.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Text(
                        "Poll",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      onChanged: (value) => message['question'] = value,
                      style: const TextStyle(fontSize: 12),
                      decoration: const InputDecoration(
                        hintText: "Your Question Here!",
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Choose Answer Option!",
                      style: TextStyle(color: Colors.green[400]),
                    ),
                  ),
                  BuildOptions(
                    message: message,
                  ),
                  // buildExplanation()
                  InkWell(
                    onTap: () {
                      FirebaseFirestore.instance.collection(chatName).add({
                        'question': message['question'],
                        'op1': message['op1'],
                        'op2': message['op2'],
                        'op3': message['op3'],
                        'op4': message['op4'],
                        'ans': message['ans'],
                        "op1Count": 0,
                        "op2Count": 0,
                        "op3Count": 0,
                        "op4Count": 0,
                        "user": FirebaseAuth.instance.currentUser?.uid,
                        "category": chatName.toLowerCase(),
                        "createdAt": Timestamp.now()
                      });
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: const Text(
                        "Done",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
