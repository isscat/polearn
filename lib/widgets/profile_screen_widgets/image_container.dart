import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageContainer extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var photoUrl;
  ImageContainer({Key? key, required var photoUrl}) : super(key: key) {
    // ignore: prefer_initializing_formals
    this.photoUrl = photoUrl;
  }

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 4),
          borderRadius: const BorderRadius.all(Radius.circular(35))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          widget.photoUrl,
          height: 120,
          width: 120,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext ctx, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const SizedBox(
                height: 120,
                width: 120,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
