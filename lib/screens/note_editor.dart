import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper/style/app_style.dart';
import 'package:intl/intl.dart';

class NoteEditorScreen extends StatefulWidget {
  // const NoteEditorScreen(QueryDocumentSnapshot<Object?> note, {Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyborad = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a note",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                FirebaseFirestore.instance.collection("Notes").add({
                  "notes_title": _titleController.text,
                  "creation_date": date,
                  "note_content": _mainController.text,
                  "color_id": color_id,
                }).then((value) {
                  print(value.id);
                  Navigator.pop(context);
                }).catchError(
                    (error) => print("Failed to add new note deu to $error"));
              },
              // child: const Text('Save')),
              child: Icon(Icons.save)),
          // TextButton(onPressed: () {}, child: const Text('Delete')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Title',
                ),
                style: AppStyle.mainTitle,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                date,
                style: AppStyle.datetitle,
              ),
              SizedBox(
                height: 28.0,
              ),
              TextField(
                controller: _mainController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Content',
                ),
                style: AppStyle.mainContent,
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: AppStyle.accentColor,
      //     onPressed: () async {
      //       FirebaseFirestore.instance.collection("Notes").add({
      //         "notes_title": _titleController.text,
      //         "creation_date": date,
      //         "note_content": _mainController.text,
      //         "color_id": color_id,
      //       }).then((value) {
      //         print(value.id);
      //         Navigator.pop(context);
      //       }).catchError(
      //           (error) => print("Failed to add new note deu to $error"));
      //     },
      //     child: Icon(Icons.save)),
    );
  }
}
