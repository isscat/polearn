import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polearn/screens/auth_screen.dart';
import 'package:polearn/widgets/home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child:
                  Text("Something went wrong! Check Your Internet Connection"),
            );
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
