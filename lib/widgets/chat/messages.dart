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
                print(chatDocs?[index]['user']);
                print(FirebaseAuth.instance.currentUser?.uid);
                return Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          ScoreWidget(
                            userid: chatDocs?[index]['user'],
                          ),
                          // buildPoll(chatDocs?[index])
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: isMe
                            ? const Color.fromRGBO(112, 195, 231, 16)
                            : Colors.black12,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft:
                              !isMe ? Radius.circular(0) : Radius.circular(12),
                          bottomRight:
                              isMe ? Radius.circular(0) : Radius.circular(12),
                        ),
                      ),
                      width: 256,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    )
                  ],
                );
              });
        }
      },
    );
  }

  // Widget buildPoll(QueryDocumentSnapshot<Object?>? curMsg) {
  //   return Container(
  //     margin: const EdgeInsets.all(10),
  //     child: Column(
  //       children: [
  //         Text(curMsg?['question']),
  //         ListView.builder(
  //           itemCount: 4,
  //           itemBuilder: (context, index) {
  //             return Row(
  //               children: [
  //                 //radio
  //                 //
  //               ],
  //             );
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
}
