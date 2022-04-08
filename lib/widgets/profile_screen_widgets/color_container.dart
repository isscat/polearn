import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ColorContainer extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var userData;
  // ignore: prefer_typing_uninitialized_variables
  var col;
  // ignore: prefer_typing_uninitialized_variables
  var userName;
  ColorContainer({Key? key, required var userData, required color})
      : super(key: key) {
    // ignore: prefer_initializing_formals
    this.userData = userData;
    col = color;
    userName = userData?["username"];
  }

  @override
  State<ColorContainer> createState() => _ColorContainerState();
}

class _ColorContainerState extends State<ColorContainer> {
  // ignore: prefer_typing_uninitialized_variables
  var ctx;
  @override
  Widget build(BuildContext context) {
    ctx = context;
    var userTotalScore = widget.userData?['gate'] +
        widget.userData?['science'] +
        widget.userData?['general'] +
        widget.userData?['lang'] +
        widget.userData?['neet'] +
        widget.userData?['tech'];
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.userName,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: editName(widget.userData?["uid"]),
                )
              ],
            ),
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, right: 5),
            width: 120,
            height: 37,
            child: Center(
              child: Text(
                "Score  " + userTotalScore.toString(),
                style: TextStyle(
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(237, 167, 8, 1),
                borderRadius: BorderRadius.all(Radius.circular(15))),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: widget.col,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
    );
  }

  buildText(String string) {
    return Text(
      string,
      style: TextStyle(
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w100,
          color: Colors.white),
    );
  }

  editName(userData) {
    return GestureDetector(
        onTap: () => showDialogNameEdit(ctx, userData),
        child: const Icon(
          Icons.edit_outlined,
          color: Colors.white,
        ));
  }

  String s = "";

  showDialogNameEdit(ctx, userId) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              width: 300,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 12),
                          hintText: "Type your new username"),
                      onChanged: (value) => s = value,
                    ),
                  ),
                  FloatingActionButton(
                      child: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("user")
                            .doc(userId)
                            .update({"username": s});
                        Navigator.of(context, rootNavigator: true).pop();
                        setState(() {
                          widget.userName = s;
                        });
                      })
                ],
              ),
            ),
          );
        });
  }
}
