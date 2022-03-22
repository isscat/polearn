import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polearn/provider/admin.dart';
import 'package:polearn/screens/chat_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryContainer extends StatelessWidget {
  String containerName = "", imageName = "", chatName = "";

  CategoryContainer({
    Key? key,
    String name = "",
    String assetName = "",
    String chat = "",
  }) : super(key: key) {
    containerName = name;
    imageName = assetName;
    chatName = chat;
  }
  @override
  Widget build(BuildContext context) {
    bool isAdmin = Provider.of<Admin>(context, listen: false).adminId ==
        FirebaseAuth.instance.currentUser?.uid;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      chat: chatName,
                      name: containerName,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: Colors.black, width: 0.0, style: BorderStyle.solid),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.35),
              // soften the shadow
              blurRadius: 3,
              spreadRadius: 0, //extend the shadow
              offset: Offset(
                0, // Move to right 10  horizontally
                4.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: AssetImage(imageName),
              alignment: Alignment.topCenter,
            ),
            Text(containerName,
                style: GoogleFonts.openSans(
                    color: const Color.fromRGBO(25, 52, 152, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
            if (isAdmin) buildTotalQuestionsText(context)
          ],
        ),
      ),
    );
  }

  buildTotalQuestionsText(context) {
    var score = Provider.of<Admin>(context, listen: true)
        .progressDetails?[chatName]["total"];
    return Text("total: " + score.toString(),
        style: GoogleFonts.openSans(
            color: const Color.fromRGBO(25, 52, 152, 1),
            fontWeight: FontWeight.bold,
            fontSize: 9.0));
  }
}
