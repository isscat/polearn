import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polearn/widgets/category_container.dart';
import 'package:polearn/widgets/circular_profile.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70, // Set this height
          flexibleSpace: Container(
              margin: const EdgeInsets.only(top: 25),
              alignment: Alignment.topRight,
              child: buildProfile(user.photoURL, context))),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              mainAxisSpacing: 25,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 140 / 194,
              children: <Widget>[
                CategoryContainer(
                  chat: "science",
                  name: "Science",
                  assetName: "assets/science.png",
                ),
                CategoryContainer(
                  chat: "general knowledge",
                  name: "General\nknowledge",
                  assetName: "assets/general.png",
                ),
                CategoryContainer(
                  chat: "languages",
                  name: "Languages",
                  assetName: "assets/lang.png",
                ),
                CategoryContainer(
                  chat: "tech hacks",
                  name: "Tech Hacks",
                  assetName: "assets/tech.png",
                ),
                CategoryContainer(
                  chat: "gate",
                  name: "GATE",
                  assetName: "assets/gate.png",
                ),
                CategoryContainer(
                  chat: "neet",
                  name: "NEET",
                  assetName: "assets/neet.png",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
