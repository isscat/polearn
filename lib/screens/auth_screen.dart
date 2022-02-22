import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:polearn/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          width: MediaQuery.of(context).size.width - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTitle(),
              buildText(),
              buildImage(),
              buildElevatedSignUpButton(context)
            ],
          ),
        ),
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
        label: const Text("Log In with Google"),
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

  buildImage() {
    return Center(
      child: Image.asset(
        "assets/home_screen_background.gif",
      ),
    );
  }

  buildTitle() {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
        fontSize: 50.0, fontFamily: 'Horizon', fontWeight: FontWeight.bold);

    return SizedBox(
      width: 250.0,
      child: AnimatedTextKit(
        animatedTexts: [
          // ColorizeAnimatedText(
          //   '',
          //   textStyle: colorizeTextStyle,
          //   colors: colorizeColors,
          // ),
          ColorizeAnimatedText('PoLearn',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
              speed: Duration(milliseconds: 500)),
        ],
        repeatForever: true,
        isRepeatingAnimation: true,
        onTap: () {
          print("Tap Event");
        },
      ),
    );
  }

  buildText() {
    var first = TextStyle(
      color: Colors.lime,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
    var second = TextStyle(
      color: Colors.deepOrange[300],
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
    return Container(
      height: 100,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 70,
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText('Learn as You Go!',
                    duration: Duration(milliseconds: 2000),
                    textStyle: first,
                    textAlign: TextAlign.center),
                FadeAnimatedText('Compete and Win!!',
                    textStyle: second, textAlign: TextAlign.center),
                FadeAnimatedText('Start Learning!!!',
                    textAlign: TextAlign.center),
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
      ),
    );
  }
}
