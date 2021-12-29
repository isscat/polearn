import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:polearn/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [buildElevatedSignUpButton(context)],
      ),
    );
  }

  Widget buildElevatedSignUpButton(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 120.0),
      child: ElevatedButton.icon(
        icon: const FaIcon(
          FontAwesomeIcons.google,
          color: Colors.red,
        ),
        label: const Text("Sign Up with Google"),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: const Size(double.infinity, 50)),
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin();
        },
      ),
    );
  }
}
