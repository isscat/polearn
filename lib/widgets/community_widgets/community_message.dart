import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polearn/widgets/score_widget.dart';

Color myCol = const Color.fromRGBO(206, 237, 254, 1);
Color senderCol = Colors.white;
// ignore: prefer_typing_uninitialized_variables
var isCommunityMe;

class CommunityMessage extends StatefulWidget {
  const CommunityMessage({Key? key}) : super(key: key);

  @override
  State<CommunityMessage> createState() => _CommunityMessageState();
}

class _CommunityMessageState extends State<CommunityMessage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("community")
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Nothing"));
          } else if (snapshot.hasData) {
            final chatDocs = snapshot.data?.docs;

            String? curUser = FirebaseAuth.instance.currentUser?.uid;
            return ListView.builder(
                reverse: true,
                // controller: controller,
                itemCount: chatDocs?.length,
                itemBuilder: (context, index) {
                  isCommunityMe = chatDocs?[index]['user'] == curUser;

                  return Row(
                    mainAxisAlignment: isCommunityMe
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 100,
                          width: 320,
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
                            color: isCommunityMe
                                ? myCol
                                // fromRGBO(211, 222, 220, 1)
                                : senderCol,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: !isCommunityMe
                                  ? const Radius.circular(0)
                                  : const Radius.circular(12),
                              bottomRight: isCommunityMe
                                  ? const Radius.circular(0)
                                  : const Radius.circular(12),
                            ),
                          ),
                          margin: isCommunityMe
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
                                    msgDelFunc: null),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    chatDocs?[index]["message"],
                                  ),
                                )
                              ]))
                    ],
                  );
                });
          }
          return const Center(child: Text("Nothing Yet! Start Creating"));
        });
  }
}
