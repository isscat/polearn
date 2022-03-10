import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polearn/screens/category_screen.dart';

import 'package:polearn/widgets/admin_screen_widgets/admin_profile.dart';
import 'package:polearn/widgets/admin_screen_widgets/admin_screen_widgets.dart';
import 'package:polearn/widgets/admin_screen_widgets/bar_chart_widgets/bar_chart.dart';

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildLogout(context),
                    ],
                  ),
                  buildAdminText(),
                  AdminProfile(adminDet: adminData),
                  const TableList(),
                  const BarChart(),
                  buildCategoryButton()
                ],
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    ));
  }

  buildCategoryButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                ctx,
                MaterialPageRoute(
                  builder: (context) => const CategoryScreen(),
                ));
          },
          child: Container(
              color: Colors.blue,
              child: const Text("Explore",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)))),
    );
  }
}
