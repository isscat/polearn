import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  var photoUrl;
  ImageContainer({Key? key, var photoUrl}) : super(key: key) {
    this.photoUrl = photoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100, left: 30),
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
            width: 8,
          ),
          borderRadius: BorderRadius.all(Radius.circular(70))),
    );
  }
}
