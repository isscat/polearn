import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommunityNewMessage extends StatefulWidget {
  const CommunityNewMessage({Key? key}) : super(key: key);

  @override
  State<CommunityNewMessage> createState() => _CommunityNewMessageState();
}

class _CommunityNewMessageState extends State<CommunityNewMessage> {
  @override
  Widget build(BuildContext context) {
    String s = "";
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 12),
                  hintText: "Type your message here!"),
              onChanged: (value) => s = value,
              onEditingComplete: () {
                s = "";
              },
            ),
          ),
          FloatingActionButton(
              mini: false,
              backgroundColor: Colors.pink[300],
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                DocumentReference documentReference =
                    FirebaseFirestore.instance.collection("community").doc();
                documentReference.set({
                  'msgid': documentReference.id,
                  "message": s,
                  "user": FirebaseAuth.instance.currentUser?.uid,
                  "createdAt": Timestamp.now()
                });
                s = "";
              })
        ],
      ),
    );
  }
}
