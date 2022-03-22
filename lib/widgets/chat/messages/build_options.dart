

import 'package:flutter/material.dart';

enum Option { op1, op2, op3, op4 }
Map msg = {};

class BuildOptions extends StatefulWidget {
  BuildOptions({Key? key, required Map message}) : super(key: key) {
    msg = message;
    msg["ans"] = "op1";
  }

  @override
  _BuildOptionsState createState() => _BuildOptionsState();
}

class _BuildOptionsState extends State<BuildOptions> {
  Option? option = Option.op1;

  int? choosenOp;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [buildRadio(Option.op1), buildTextField("First Option", 1)],
        ),
        Row(
          children: [
            buildRadio(Option.op2),
            buildTextField("Second Option", 2)
          ],
        ),
        Row(
          children: [buildRadio(Option.op3), buildTextField("Third Option", 3)],
        ),
        Row(
          children: [
            buildRadio(Option.op4),
            buildTextField("Fourth Option", 4)
          ],
        ),
      ],
    );  
  }

  Widget buildTextField(String? text, int optNo) {
    return Flexible(
        child: Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: TextField(
        
        style: const TextStyle(fontSize: 12),
        onChanged: (value) {
          
          switch (optNo) {
            case 1:
              msg["op1"] = value;
              break;
            case 2:
              msg["op2"] = value;
              break;
            case 3:
              msg["op3"] = value;
              break;
            case 4:
              msg["op4"] = value;
              break;
          }
        },
      
      
        decoration: InputDecoration(
          hintText: text,
         
        ),
        maxLines: 1,
      
      
      ),
    ));
  }

  Widget buildRadio(Option op) {
    return Radio<Option>(
        value: op,
        groupValue: option,
        onChanged: (Option? value) {
          setState(() {
            option = value;
            switch (option) {
              case Option.op1:
                msg["ans"] = "op1";
                break;
              case Option.op2:
                msg["ans"] = "op2";
                break;
              case Option.op3:
                msg["ans"] = "op3";
                break;
              case Option.op4:
                msg["ans"] = "op4";
                break;
              default:
                break;
            }
          });
        });
  }
  
}
