import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polearn/widgets/admin_screen_widgets/styling_utils.dart';
import 'package:polearn/widgets/admin_screen_widgets/table/table_utils.dart';

class TableList extends StatelessWidget {
  const TableList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Progress",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.black54,
                )),
          ),
          SizedBox(
            height: 290,
            child: Column(
              children: [
                //heading
                buildTableHeadings(
                    dataList: [
                      "SUBJECT",
                      "TOTAL QUESTIONS",
                      "ANSWERED",
                      "TOP SCORER"
                    ],
                    context: context,
                    textColor: Colors.black54,
                    containerColor: const Color.fromARGB(1, 250, 252, 255)),
                buildRows()
              ],
            ),
          ),
        ],
      ),
      height: 350,
      width: MediaQuery.of(context).size.width - 15,
      margin: const EdgeInsets.fromLTRB(5, 70, 5, 40),
      decoration: BoxDecoration(
          border: stroke, boxShadow: boxShadows, color: Colors.white),
    );
  }

  Widget buildRows() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("progress")
            .doc("score")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var progressDetails = snapshot.data;

            return SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildRow("Science", progressDetails?["science"],
                      containerCol: containerCol),
                  buildRow("General Knowledge", progressDetails?["general"]),
                  buildRow("Languages", progressDetails?["lang"],
                      containerCol: containerCol),
                  buildRow("Tech Hacks", progressDetails?["tech"]),
                  buildRow("GATE", progressDetails?["gate"],
                      containerCol: containerCol),
                  buildRow(
                    "NEET",
                    progressDetails?["neet"],
                  ),
                ],
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }

  buildRow(String s, progressDetail, {containerCol = Colors.white}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 7, 3, 7),
      color: containerCol,
      margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildText(
              data: s, color: Colors.black54, fontSize: 12, isScore: false),
          buildText(
            data: progressDetail?["total"].toString(),
            color: const Color.fromRGBO(88, 129, 210, 100),
            fontSize: 12.0,
            isScore: true,
          ),
          buildText(
            color: const Color.fromRGBO(102, 190, 159, 100),
            data: progressDetail?["answered"].toString(),
            fontSize: 12.0,
            isScore: true,
          ),
          buildText(
              color: Colors.black54,
              data: progressDetail?["topscorer"],
              fontSize: 12.0,
              isScore: false),
        ],
      ),
    );
  }
}
