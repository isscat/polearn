import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polearn/widgets/admin_screen_widgets/styling_utils.dart';
import 'package:polearn/widgets/admin_screen_widgets/table/table_utils.dart';
import 'package:polearn/widgets/profile_screen_widgets/image_container.dart';

// ignore: must_be_immutable
class AdminProfile extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var adminData;
  AdminProfile({Key? key, required var adminDet}) : super(key: key) {
    adminData = adminDet;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      decoration: BoxDecoration(
          boxShadow: boxShadows,
          color: containerCol,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.white, width: 6)),
      height: 260,
      width: 240,
      child: Column(
        children: [
          ImageContainer(
            photoUrl: adminData?["photoUrl"],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text(adminData?["username"],
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.black54,
                    shadows: const [
                      Shadow(
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          color: Colors.black12)
                    ])),
          )
        ],
      ),
    );
  }
}
