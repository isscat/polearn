import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/* 
This is class represents Admin .
methods in this class will get information regarding progress of polls
and also admin data like his userID to uniquely identify him.
Data members in this class temporarily stores them.
*/

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
