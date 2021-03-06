import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polearn/provider/admin.dart';
import 'package:polearn/screens/admin_screen.dart';
import 'package:polearn/screens/auth_screen.dart';
import 'package:polearn/screens/home_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child:
                  Text("Something went wrong! Check Your Internet Connection"),
            );
          } else if (snapshot.hasData) {
            return Scaffold(
              body: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("admin")
                      .snapshots(),
                  builder: (context, snapshot) {
                    try {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        final chatDocs = snapshot.data?.docs;
                        var admin = chatDocs?.firstWhere((element) {
                          if (element['uid'] != null &&
                              element['uid'] ==
                                  FirebaseAuth.instance.currentUser?.uid) {
                            return true;
                          }
                          return false; // current message user
                        });
                        if (admin?["uid"] ==
                            FirebaseAuth.instance.currentUser?.uid) {
                          Provider.of<Admin>(context, listen: false)
                              .setAdminId(admin?["uid"]);
                          return const AdminScreen();
                        } else {
                          return const HomeScreen();
                        }
                      }
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                    }
                    return const HomeScreen();
                  }),
            );
          }

          return const AuthScreen();
        },
      ),
    );
  }
}
