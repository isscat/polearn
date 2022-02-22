import 'package:flutter/material.dart';
import 'package:polearn/widgets/category_container.dart';
import 'package:polearn/widgets/profile_appbar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(),
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
                  chat: "general",
                  name: "General\nknowledge",
                  assetName: "assets/general.png",
                ),
                CategoryContainer(
                  chat: "lang",
                  name: "Languages",
                  assetName: "assets/lang.png",
                ),
                CategoryContainer(
                  chat: "tech",
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
