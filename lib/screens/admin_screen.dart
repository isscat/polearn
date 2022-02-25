import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:polearn/widgets/logout.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(
          "Admin Screen Here!",
          style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
        ),
        buildLogout(context)
      ],
    ));
  }
}
