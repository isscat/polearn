import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polearn/screens/chat_screen.dart';

// ignore: must_be_immutable
class CategoryContainer extends StatelessWidget {
  String containerName = "", imageName = "", chatName = "";
  CategoryContainer(
      {Key? key, String name = "", String assetName = "", String chat = ""})
      : super(key: key) {
    containerName = name;
    imageName = assetName;
    chatName = chat;
  }
  @override
  Widget build(BuildContext context) {
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
              color: Colors.black, width: 1.0, style: BorderStyle.solid),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              // soften the shadow
              blurRadius: 4,
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
                style: GoogleFonts.roboto(
                    color: const Color.fromRGBO(25, 52, 152, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0))
          ],
        ),
      ),
    );
  }
}
