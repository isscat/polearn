import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polearn/provider/admin.dart';
import 'package:polearn/screens/chat_screen.dart';
import 'package:provider/provider.dart';

var boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(30),
  border: Border.all(color: Colors.black, width: 0.0, style: BorderStyle.solid),
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
);

// ignore: must_be_immutable
class CategoryContainer extends StatefulWidget {
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
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    bool isAdmin = Provider.of<Admin>(context, listen: true).adminId ==
        FirebaseAuth.instance.currentUser?.uid;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      chat: widget.chatName,
                      name: widget.containerName,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: boxDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: AssetImage(widget.imageName),
              alignment: Alignment.topCenter,
            ),
            Text(widget.containerName,
                style: GoogleFonts.openSans(
                    color: const Color.fromRGBO(25, 52, 152, 1),
                    fontWeight: FontWeight.bold,
                    fontSize:
                        (widget.containerName == "Community") ? 12 : 20.0)),
            if (isAdmin && !(widget.chatName == "community"))
              buildTotalQuestionsText(context)
          ],
        ),
      ),
    );
  }

  buildTotalQuestionsText(context) {
    var score = Provider.of<Admin>(context, listen: true)
        .progressDetails?[widget.chatName]["total"];

    return Text("total: " + score.toString(),
        style: GoogleFonts.openSans(
            color: const Color.fromRGBO(25, 52, 152, 1),
            fontWeight: FontWeight.bold,
            fontSize: 9.0));
  }
}
