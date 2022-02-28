import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:polearn/widgets/chat/messages/poll_form.dart';
import 'package:intl/intl.dart';
import '../../score_widget.dart';

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

  @override
  void initState() {
    super.initState();

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();

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
          Color myCol = const Color.fromRGBO(206, 237, 254, 1);
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ScoreWidget(
                                userid: chatDocs?[index]['user'],
                                isAppBar: false,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(chatDocs?[index]["question"],
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.openSans().fontFamily,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),

                              buildPoll(chatDocs?[index],
                                  (isMe) ? myCol : senderCol, curUser),
                              //time

                              Row(
                                children: [
                                  Text(
                                    DateFormat().format(
                                        chatDocs?[index]["createdAt"].toDate()),
                                    style: GoogleFonts.roboto(fontSize: 7),
                                  ),
                                ],
                              )
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
                        maximumSize: const Size(7, 20),
                        maxBlastForce: 50,
                        minBlastForce: 20,
                        gravity: 0.4,
                        shouldLoop: false,
                        emissionFrequency: 0.01,
                        numberOfParticles: 150,
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
    // ignore: prefer_typing_uninitialized_variables
    var find;

    if (curMsg?["answered_users"].length != 0) {
      find = curMsg?["answered_users"].firstWhere(
          (element) =>
              (element?["user"] == FirebaseAuth.instance.currentUser?.uid),
          orElse: () => null);
    }
    if (find != null) {
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
            int flag = 2;
            // ignore: curly_braces_in_flow_control_structures
            if ((find["answered_opt"] == s)) if (find["answered_opt"] ==
                curMsg?["ans"]) {
              flag = 1;
            } else {
              flag = 3;
            }
            else {
              flag = 2;
            }

            return SizedBox(
              height: 56,
              child: Column(
                children: [
                  buildColumn(curMsg, s, flag, total),
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
          return Column(
            children: [
              Row(
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
                              "total": FieldValue.increment(1)
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
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          );
        },
        itemCount: 4,
      ),
    );
  }

  Widget buildColumn(
      QueryDocumentSnapshot<Object?>? curMsg, String s, int flag, int total) {
    Color? myCol;
    if (flag == 1) myCol = Colors.green;
    if (flag == 2) myCol = const Color.fromRGBO(246, 119, 119, 1);
    if (flag == 3) myCol = Colors.blue;
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            ((curMsg?[s + "Count"] / total * 100).ceil()).toString() + "%",
            style: TextStyle(color: myCol, fontSize: 10),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            curMsg?[s],
            style: TextStyle(
                fontFamily: GoogleFonts.openSans().fontFamily,
                fontWeight: FontWeight.w500),
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (flag == 1)
                ? Icon(
                    Icons.check_circle,
                    color: myCol,
                    size: 20,
                  )
                : Icon(
                    Icons.cancel,
                    size: 20,
                    color: myCol,
                  ),
            const SizedBox(
              width: 10,
            ),
            LinearPercentIndicator(
              width: 220.0,
              lineHeight: 8.0,
              percent: curMsg?[s + "Count"] / total,
              progressColor: myCol,
            ),
          ],
        )
      ],
    );
  }
}
