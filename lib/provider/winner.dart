import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class WinnerProvider extends ChangeNotifier {
  bool isWinnerSet = false;
  var winner;
  Future setWinner() async {
    try {
      FirebaseFirestore.instance
          .collection("user")
          .orderBy('score')
          .limit(1)
          .get()
          .then((element) {
        element.docs.forEach((element) {
          winner = {
            "username": element["username"],
            "score": element["total"],
            "photoUrl": element["photoUrl"],
          };
          FirebaseFirestore.instance
              .collection("user")
              .doc(element["uid"])
              .update({
            "dayWinDates": FieldValue.arrayUnion([DateTime.now()]),
            "dayWin": FieldValue.increment(1)
          });
          isWinnerSet = true;
        });
      });
    } catch (e) {}
    // notifyListeners();
  }
}
