import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:polearn/widgets/poll_form.dart';

import '../score_widget.dart';

// ignore: must_be_immutable
class Messages extends StatefulWidget {
  String chatName = "neet";
  Messages({Key? key, String chat = "neet"}) : super(key: key) {
    chatName = chat;
  }

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late ConfettiController _controllerCenter;

  late ConfettiController _controllerCenterRight;

  late ConfettiController _controllerCenterLeft;

  late ConfettiController _controllerTopCenter;

  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    super.initState();

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.chatName)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final chatDocs = snapshot.data?.docs;
          Color myCol = const Color.fromRGBO(255, 239, 239, 1);
          Color senderCol = Colors.white;
          String? curUser = FirebaseAuth.instance.currentUser?.uid;
          return ListView.builder(
              reverse: true,
              // controller: controller,
              itemCount: chatDocs?.length,
              itemBuilder: (context, index) {
                bool isMe = chatDocs?[index]['user'] == curUser;

                return SafeArea(
                    child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 326,
                          width: 320,
                          margin: isMe
                              ? const EdgeInsets.only(
                                  left: 30, top: 10, bottom: 10, right: 5)
                              : const EdgeInsets.only(
                                  right: 30, top: 10, bottom: 10, left: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ScoreWidget(
                                userid: chatDocs?[index]['user'],
                              ),
                              Text(chatDocs?[index]["question"]),
                              buildPoll(chatDocs?[index],
                                  (isMe) ? myCol : senderCol, curUser),
                            ],
                          ),
                          decoration: BoxDecoration(
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: [
                              const BoxShadow(
                                color: Colors.black26,
                                offset: Offset(
                                  0,
                                  4.0,
                                ),
                                blurRadius: 4.0,
                                spreadRadius: 0.0,
                              )
                            ],
                            color: isMe
                                ? myCol
                                // fromRGBO(211, 222, 220, 1)
                                : senderCol,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: !isMe
                                  ? const Radius.circular(0)
                                  : const Radius.circular(12),
                              bottomRight: isMe
                                  ? const Radius.circular(0)
                                  : const Radius.circular(12),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        )
                      ],
                    ),
                    //celebration animation
                    Align(
                      alignment: Alignment.center,
                      child: ConfettiWidget(
                        minimumSize: const Size(4, 7),
                        maximumSize: const Size(10, 25),
                        maxBlastForce: 40,
                        minBlastForce: 20,
                        gravity: 0.4,
                        shouldLoop: false,
                        emissionFrequency: 0.06,
                        numberOfParticles: 70,
                        confettiController: _controllerCenter,
                        blastDirectionality: BlastDirectionality
                            .explosive, // don't specify a direction, blast randomly
                        displayTarget: false,
                        colors: const [
                          Colors.green,
                          Colors.blue,
                          Colors.yellow,
                          Colors.orange,
                          Colors.purple
                        ], // manually specify the colors to be used
                      ),
                    ),
                  ],
                ));
              });
        }
      },
    );
  }

  Widget buildPoll(
    QueryDocumentSnapshot<Object?>? curMsg,
    Color clr,
    String? curUser,
  ) {
    // print(curMsg?["user"] + "\n" + FirebaseAuth.);
    if (curMsg?["answered_users"].contains(curUser)) {
      int total = curMsg?["op1Count"] +
          curMsg?["op2Count"] +
          curMsg?["op3Count"] +
          curMsg?["op4Count"];
      return SizedBox(
        height: 225,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            String s = "op" + (index + 1).toString();
            return SizedBox(
              height: 56,
              child: Column(
                children: [
                  buildColumn(curMsg, s, s == curMsg?["ans"], total),
                ],
              ),
            );
          },
          itemCount: 4,
        ),
      );
    }
    // answering for the first time
    return SizedBox(
      height: 225,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          String s = "op" + (index + 1).toString();
          return Card(
              elevation: 2,
              color: clr,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (curMsg?["user"] !=
                            FirebaseAuth.instance.currentUser?.uid) {
                          if (s == curMsg?["ans"]) {
                            _controllerCenter.play();
                            FirebaseFirestore.instance
                                .collection("user")
                                .doc(curUser)
                                .update({
                              chatName: FieldValue.increment(1),
                            });
                          }
                          FirebaseFirestore.instance
                              .collection(widget.chatName)
                              .doc(curMsg?["msgid"])
                              .update({
                            s + "Count": FieldValue.increment(1),
                            'answered_users': FieldValue.arrayUnion([
                              {"user": curUser, "answered_opt": s}
                            ])
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.radio_button_off,
                        color: Colors.black,
                      )),
                  Expanded(
                    child: Text(
                      curMsg?[s],
                      maxLines: 3,
                    ),
                  )
                ],
              ));
        },
        itemCount: 4,
      ),
    );
  }

  Widget buildColumn(
      QueryDocumentSnapshot<Object?>? curMsg, String s, bool flag, int total) {
    return Container(
      // height: 225,
      child: Column(
        children: [
          Text(curMsg?[s]),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (flag)
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.dangerous,
                      color: Colors.red,
                    ),
              LinearPercentIndicator(
                width: 200.0,
                lineHeight: 8.0,
                percent: curMsg?[s + "Count"] / total,
                progressColor: (flag) ? Colors.green : Colors.red,
              ),
              Text(((curMsg?[s + "Count"] / total * 100).ceil()).toString() +
                  "%"),
            ],
          )
        ],
      ),
    );
  }
}
