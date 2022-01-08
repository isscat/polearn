import 'package:flutter/material.dart';
import 'package:polearn/widgets/poll_form.dart';

// ignore: must_be_immutable

class NewMessage extends StatefulWidget {
  String chatName = "";
  NewMessage({Key? key, required String chat}) : super(key: key) {
    chatName = chat;
  }

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var enteredMessage = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          RoundedAlertBox(
            chat: widget.chatName,
          )
        ],
      ),
    );
  }
}
