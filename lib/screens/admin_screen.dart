import 'package:flutter/material.dart';
import 'package:polearn/widgets/admin_screen_widgets.dart';
import 'package:polearn/widgets/logout.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [buildAdminProfile(), buildLogout(context)],
    ));
  }
}
