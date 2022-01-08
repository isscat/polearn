import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../score_widget.dart';

// ignore: must_be_immutable
class Messages extends StatelessWidget {
  String chatName = "neet";
  Messages({Key? key, String chat = "neet"}) : super(key: key) {
    chatName = chat;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(chatName)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final chatDocs = snapshot.data?.docs;
          Color myCol = Color.fromRGBO(255, 239, 239, 1);
          Color senderCol = Colors.white;
          return ListView.builder(
              reverse: true,
              // controller: controller,
              itemCount: chatDocs?.length,
              itemBuilder: (context, index) {
                bool isMe = chatDocs?[index]['user'] ==
                    FirebaseAuth.instance.currentUser?.uid;

                return Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 380,
                      width: 320,
                      margin: isMe
                          ? EdgeInsets.only(
                              left: 30, top: 10, bottom: 10, right: 5)
                          : EdgeInsets.only(
                              right: 30, top: 10, bottom: 10, left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ScoreWidget(
                            userid: chatDocs?[index]['user'],
                          ),
                          Text(chatDocs?[index]["question"]),
                          buildPoll(
                              chatDocs?[index], (isMe) ? myCol : senderCol),
                        ],
                      ),
                      decoration: BoxDecoration(
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
                );
              });
        }
      },
    );
  }

  Widget buildPoll(QueryDocumentSnapshot<Object?>? curMsg, Color clr) {
    return Container(
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
                        if (s == curMsg?["ans"]) {
                          print("correct Answer");
                        }
                      },
                      icon: Icon(
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

  // radioButtonPressed(QueryDocumentSnapshot<Object?>? currMsg, int index) {
  //   String s = "op" + (index + 1).toString() + "Count";
  //   FirebaseFirestore.instance.collection(chatName).snapshots().
  // }

  // radioButtonPressed(QueryDocumentSnapshot<Object?>? curMsg, int index) {

  // }
  // Container(
  //             margin: EdgeInsets.all(5),
  //             height: 35,
  //             decoration: BoxDecoration(
  //               border: Border(bottom: BorderSide(color: Colors.black)),
  //             ),
  //             child: Row(
  //               children: [
  //                 IconButton(
  //                     onPressed: null,
  //                     icon: Icon(
  //                       Icons.radio_button_off,
  //                       color: Colors.black,
  //                     )),
  //                 Text(curMsg?[s])
  //               ],
  //             ));

}
