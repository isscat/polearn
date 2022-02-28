import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:polearn/widgets/admin_screen_widgets/admin_profile.dart';
import 'package:polearn/widgets/admin_screen_widgets/admin_screen_widgets.dart';
import 'package:polearn/widgets/admin_screen_widgets/table/table.dart';

import 'package:polearn/widgets/logout.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var adminData = snapshot.data;

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(5, 50, 5, 0),
              child: Column(
                children: [
                  buildAdminText(),
                  AdminProfile(adminDet: adminData),
                  const TableList(),
                  buildLogout(context)
                ],
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    ));
  }
}
