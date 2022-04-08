import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProfileEditContainer extends StatelessWidget {
  File? file;
  String? useruid;
  // ignore: prefer_typing_uninitialized_variables
  var functionToExecute;

  ProfileEditContainer({Key? key, required String uid, required func})
      : super(key: key) {
    useruid = uid;
    functionToExecute = func;
  }
  // ignore: prefer_typing_uninitialized_variables
  var ctx;
  @override
  Widget build(BuildContext context) {
    ctx = context;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
          color: const Color.fromARGB(255, 140, 150, 241),
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: openFilePickDialogue,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
    );
  }

  openFilePickDialogue() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: ["jpg", "gif", "png"]);
    if (result == null) return;
    final path = result.files.single.path!;
    var sizeOfFile = await getFileSizeName(path, 1);
    var size = await getFileSize(path, 1);
    if (sizeOfFile == "MB" && size >= 1) {
      buildDialog();
    } else {
      file = File(path);
      uploadFile();
    }
  }

  getFileSizeName(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return suffixes[i];
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)));
  }

  uploadFile() async {
    const snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text('Wait While We Upload!'),
    );
    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    if (file == null) return;
    final storageDestination = "files/$useruid";

    final task = uploadFileToFirebase(storageDestination, file);
    if (task == null) return;
    final snap = task.whenComplete(() {});
    final photoUrl = await snap.then((value) {
      return value.storage.ref("files/$useruid").getDownloadURL();
    });

    FirebaseFirestore.instance
        .collection("user")
        .doc(useruid)
        .update({"photoUrl": photoUrl});

    functionToExecute(photoUrl, ctx);
  }

  UploadTask? uploadFileToFirebase(String storageDestination, File? file) {
    try {
      final ref = FirebaseStorage.instance.ref(storageDestination);
      return ref.putFile(file!);
      // ignore: unused_catch_clause
    } on FirebaseException catch (e) {
      return null;
    }
  }

  void buildDialog() {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              width: 200,
              child: Center(
                child: Text(
                  "Please select a file with size less than 1MB.",
                  style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      color: Colors.orange,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          );
        });
  }
}
