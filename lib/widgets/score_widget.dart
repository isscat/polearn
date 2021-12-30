import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:polearn/provider/google_sign_in.dart';

// ignore: must_be_immutable
class ScoreWidget extends StatefulWidget {
  ScoreWidget({Key? key, required String userid}) : super(key: key) {
    userId = userid;
  }
  String userId = "";

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  @override
  Widget build(BuildContext context) {
    int totalScore = 0;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final chatDocs = snapshot.data?.docs;
          final curMsgUser = chatDocs?.firstWhere((element) {
            return element['uid'] == widget.userId; // current message user
          });
          totalScore = curMsgUser?['gate'] +
              curMsgUser?['general'] +
              curMsgUser?['lang'] +
              curMsgUser?['neet'] +
              curMsgUser?['tech'];
          return Container(
            // color: Colors.amber,
            height: 80,
            child: Row(
              children: [
                buildProfile(curMsgUser?['photoUrl']),
                buildScore(totalScore, curMsgUser?['username']),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildProfile(final userPhoto) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 55,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          image: DecorationImage(
              image: NetworkImage(userPhoto.toString()), fit: BoxFit.fill),
        ),
      ),
    );
  }

  Widget buildScore(int total, String userName) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 25,
                width: 20,
                margin: const EdgeInsets.all(13),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/points.png"),
                        fit: BoxFit.fill)),
              ),
              Text(total.toString()),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 10), child: Text(userName))
        ],
      ),
    );
  }
}
