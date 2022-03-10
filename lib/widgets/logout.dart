import 'package:flutter/material.dart';
import 'package:polearn/provider/google_sign_in.dart';
import 'package:polearn/widgets/home_page.dart';
import 'package:provider/provider.dart';

Widget buildLogout(BuildContext context) {
  final ButtonStyle style = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(15),
      primary: Colors.white,
      textStyle: const TextStyle(fontSize: 25));
  return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.fromLTRB(0.0, 0, 5, 10.0),
      child: ElevatedButton.icon(
        style: style,
        label: Text(
          "logout",
          style: TextStyle(fontSize: 10, color: Colors.red[400]),
        ),
        icon: const Icon(
          Icons.logout,
          color: Colors.black54,
        ),
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.logout();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false);
        },
      ));
}
