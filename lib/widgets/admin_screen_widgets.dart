import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget buildAdminProfile() {
  var adminDetails;

  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection("user").snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting)
        return CircularProgressIndicator();
      else if (snapshot.hasData) {
        var chatDocs = snapshot.data?.docs;
        adminDetails = chatDocs?.firstWhere((element) =>
            element["uid"] == FirebaseAuth.instance.currentUser?.uid);
        return buildProfileContainer(adminDetails);
      }
      return Center(child: Text("Something Went Wrong! Check Your Network"));
    },
  );
}

Widget buildProfileContainer(var admin) {
  return Center(
    child: Container(
      child: Column(
        children: [
          Container(
            child: Text(
              "Admin Here!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
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
                border: Border.all(
                  color: Colors.white,
                  width: 8,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(70))),
            child: Image.network(admin["photoUrl"]),
          ),
        ],
      ),
    ),
  );
}
