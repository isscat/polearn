import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polearn/widgets/admin_screen_widgets/bar_chart_widgets/bar_chart_score.dart';

class BarChart extends StatefulWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("progress")
            .doc("score")
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            var items = [
              [data?["science"]["answered"], data?["science"]["total"]],
              [data?["general"]["answered"], data?["general"]["total"]],
              [data?["lang"]["answered"], data?["lang"]["total"]],
              [data?["tech"]["answered"], data?["tech"]["total"]],
              [data?["gate"]["answered"], data?["gate"]["total"]],
              [data?["neet"]["answered"], data?["neet"]["total"]]
            ];
            return BarChartScore(items: items);
          }
          return const CircularProgressIndicator();
        });
  }
}
