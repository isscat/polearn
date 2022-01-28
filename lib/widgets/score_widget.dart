import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:polearn/provider/google_sign_in.dart';
import 'package:polearn/screens/profile_screen.dart';

// ignore: must_be_immutable
class ScoreWidget extends StatefulWidget {
  ScoreWidget({Key? key, required String? userid, required bool isAppBar})
      : super(key: key) {
    userId = userid;
    isApp = isAppBar;
  }
  String? userId = "";
  bool isApp = false;
  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  // ignore: prefer_typing_uninitialized_variables
  var curMsgUser;
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
          curMsgUser = chatDocs?.firstWhere((element) {
            return element['uid'] == widget.userId; // current message user
          });
          totalScore = curMsgUser?['gate'] +
              curMsgUser?['science'] +
              curMsgUser?['general'] +
              curMsgUser?['lang'] +
              curMsgUser?['neet'] +
              curMsgUser?['tech'];
          return SizedBox(
            // color: Colors.amber,
            height: (widget.isApp) ? 55 : 40,
            child: Row(
              children: (!widget.isApp)
                  ? [
                      buildProfile(curMsgUser),
                      buildScore(totalScore, curMsgUser?['username']),
                    ]
                  : [
                      buildScore(totalScore, curMsgUser?['username']),
                      buildProfile(curMsgUser),
                    ],
            ),
          );
        }
      },
    );
  }

  Widget buildScore(int total, String userName) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            (widget.isApp) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: (widget.isApp)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                height: (widget.isApp) ? 25 : 15,
                width: (widget.isApp) ? 27 : 17,
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/points.png"),
                        fit: BoxFit.fill)),
              ),
              Text(
                total.toString(),
                style: TextStyle(
                    fontSize: (widget.isApp) ? 14 : 10,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(253, 197, 71, 1)),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 4),
              child: Text(userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                    fontSize: (widget.isApp) ? 13 : 10,
                    color: widget.isApp
                        ? Colors.white
                        : const Color.fromRGBO(103, 134, 250, 1),
                  )))
        ],
      ),
    );
  }

  Widget buildProfile(curMsgUser) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileScreen(
                      user: curMsgUser,
                      color: Colors.blue,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        width: widget.isApp ? 45 : 30,
        height: widget.isApp ? 50 : 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          image: DecorationImage(
              image: NetworkImage(curMsgUser?["photoUrl"]), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
