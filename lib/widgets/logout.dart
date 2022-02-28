import 'package:flutter/material.dart';
import 'package:polearn/provider/google_sign_in.dart';
import 'package:polearn/widgets/home_page.dart';
import 'package:provider/provider.dart';

Widget buildLogout(BuildContext context) {
  final ButtonStyle style = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(20),
      primary: Colors.white,
      textStyle: const TextStyle(fontSize: 25));
  return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 120.0),
      child: ElevatedButton(
        style: style,
        child: const Text(
          'Logout',
          style: TextStyle(color: Colors.red),
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
