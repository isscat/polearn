import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);

      var collectionref = FirebaseFirestore.instance.collection('user');
      var doc = await collectionref.doc(_user?.id.toString()).get();
      if (!doc.exists) {
        collectionref.doc(FirebaseAuth.instance.currentUser?.uid).set({
          'uid': FirebaseAuth.instance.currentUser?.uid,
          'username': _user?.displayName,
          'mail': _user?.email,
          'photoUrl': _user?.photoUrl,
          'science': 0,
          'neet': 0,
          'gate': 0,
          'general': 0,
          'tech': 0,
          'lang': 0,
          'dayWin': 0,
          'dayWinDates': [],
          'total': 0,
          'createdAt': Timestamp.now()
        });
      }
    } catch (e) {
      return;
    }
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
