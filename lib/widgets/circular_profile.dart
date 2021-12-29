import 'package:flutter/material.dart';
import 'package:polearn/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

Widget buildProfile(final user, BuildContext context) {
  return GestureDetector(
    onTap: () {
      final provider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
      provider.logout();
    },
    child: Container(
      margin: const EdgeInsets.all(15),
      width: 55,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
            image: NetworkImage(user.toString()), fit: BoxFit.fill),
      ),
    ),
  );
}
