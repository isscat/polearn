import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Admin extends ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  var progressDetails;
  // ignore: prefer_typing_uninitialized_variables
  var adminId;
  var isAdmin = false;
  var progAvail = false;
  setAdminId(String id) {
    adminId = id;
    isAdmin = true;
  }

  setProgressDetails({required var progDet}) {
    progressDetails = progDet;
    progAvail = true;
  }

  getProgressDetails() {
    FirebaseFirestore.instance
        .collection("progress")
        .doc("score")
        .get()
        .then((value) => progressDetails = value);
    notify();
  }

  notify() {
    notifyListeners();
  }
}
