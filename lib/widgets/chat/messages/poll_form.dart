import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'build_options.dart';

String chatName = "";

class RoundedAlertBox extends StatefulWidget {
  RoundedAlertBox({Key? key, required String chat}) : super(key: key) {
    chatName = chat;
  }

  @override
  _RoundedAlertBoxState createState() => _RoundedAlertBoxState();
}

bool isInvalid = false;

class _RoundedAlertBoxState extends State<RoundedAlertBox> {
  Color? myColor = const Color.fromARGB(253, 197, 71, 1);

  var message = {
    "question": "",
    "op1": "",
    "op2": "",
    "op3": "",
    "op4": "",
    "ans": "op1",
  };

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: openAlertBox,
        child: Container(
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
          return StatefulBuilder(builder: (context, setState) {
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
                        children: <Widget>[
                          Text(
                            "Poll", //PPPPPPPPPPPPPPPOOOOOOOOOOOLLLLLLLLLLL
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              fontFamily: GoogleFonts.openSans().fontFamily,
                            ),
                          )
                        ]),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    (isInvalid)
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Please Fill All The Fields!",
                                style: GoogleFonts.roboto(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13)),
                          )
                        : Container(),
                    buildQuestion(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Choose Answer Option!",
                        style: TextStyle(color: Colors.green[400]),
                      ),
                    ),
                    BuildOptions(
                      message: message,
                    ),
                    buildDoneButton(setState)
                  ],
                ),
              ),
            );
          });
        });
  }

  buildDoneButton(state) {
    return InkWell(
      onTap: () {
        int? quesLength = message["question"]?.length;
        int? op1 = message["op1"]?.length;
        int? op2 = message["op2"]?.length;
        int? op3 = message["op3"]?.length;
        int? op4 = message["op4"]?.length;
        if (op1! > 0 && op2! > 0 && op3! > 0 && op4! > 0 && quesLength! > 0) {
          if (isInvalid) isInvalid = false;
          DocumentReference documentReference =
              FirebaseFirestore.instance.collection(chatName).doc();
          documentReference.set({
            'question': message['question'],
            'op1': message['op1'],
            'op2': message['op2'],
            'op3': message['op3'],
            'op4': message['op4'],
            'ans': (message['ans'] != null) ? message['ans'] : "op1",
            "op1Count": 0,
            "op2Count": 0,
            "op3Count": 0,
            "op4Count": 0,
            "user": FirebaseAuth.instance.currentUser?.uid,
            "category": chatName.toLowerCase(),
            "createdAt": Timestamp.now(),
            "answered_users": [],
            'msgid': documentReference.id,
            "total": 0
          });
          documentReference =
              FirebaseFirestore.instance.collection("progress").doc("score");
          documentReference.update({
            '$chatName.total': FieldValue.increment(1),
          });
          message = {
            "question": "",
            "op1": "",
            "op2": "",
            "op3": "",
            "op4": "",
            "ans": "op1",
          };
          Navigator.of(context, rootNavigator: true).pop();
        } else {
          state(() {
            isInvalid = true;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        decoration: BoxDecoration(
          color: Colors.green[300],
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
    );
  }

  buildQuestion() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (value) => message['question'] = value,
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
          hintText: "Your Question Here!",
        ),
        maxLines: 1,
      ),
    );
  }
}
