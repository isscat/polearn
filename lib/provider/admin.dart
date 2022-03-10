import 'package:flutter/material.dart';

class Admin extends ChangeNotifier {
  var progressDetails = null;
  var adminId = null;
  var isAdmin = false;
  var progAvail = false;
  setAdminId(String id) {
    adminId = id;
    isAdmin = true;
  }

  setProgressDetails({required var progDet}) {
    progressDetails = progDet;
    progAvail = true;
    notifyListeners();
  }
}
