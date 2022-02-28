import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageContainer extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var photoUrl;
  ImageContainer({Key? key, required var photoUrl}) : super(key: key) {
    // ignore: prefer_initializing_formals
    this.photoUrl = photoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(
                1.0,
                14.0,
              ),
              blurRadius: 4.0,
              spreadRadius: 0.0,
            ),
          ],
          image:
              DecorationImage(image: NetworkImage(photoUrl), fit: BoxFit.fill),
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(70))),
    );
  }
}
