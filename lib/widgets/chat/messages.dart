import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          .orderBy('createdAt')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final chatDocs = snapshot.data?.docs;
          return ListView.builder(
              // reverse: true,
              itemCount: chatDocs?.length,
              itemBuilder: (context, index) {
                bool isMe = chatDocs?[index]['user'] ==
                    FirebaseAuth.instance.currentUser?.uid;

                return Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        height: 270,
                        margin: isMe
                            ? EdgeInsets.only(left: 30, top: 10, bottom: 10)
                            : EdgeInsets.only(right: 30, top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ScoreWidget(
                              userid: chatDocs?[index]['user'],
                            ),
                            Text(chatDocs?[index]["question"]),
                            buildPoll(chatDocs?[index])
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: isMe
                              ? const Color.fromRGBO(112, 195, 231, 16)
                              : Colors.black12,
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
                            horizontal: 15, vertical: 5),
                        // margin: const EdgeInsets.symmetric(
                        //     horizontal: 10, vertical: 10),
                      ),
                    )
                  ],
                );
              });
        }
      },
    );
  }

  Widget buildPoll(QueryDocumentSnapshot<Object?>? curMsg) {
    return Container(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String s = "op" + (index + 1).toString();
          return Container(
            height: 35,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => null,
                  icon: Icon(
                    Icons.radio_button_off,
                    color: Colors.blue,
                  ),
                ),
                Text(curMsg?[s])
              ],
            ),
          );
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
}
