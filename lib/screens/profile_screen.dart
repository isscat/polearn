import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  String? userId;
  ProfileScreen({Key? key, required String? userId}) : super(key: key) {
    // ignore: prefer_initializing_formals
    this.userId = userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
