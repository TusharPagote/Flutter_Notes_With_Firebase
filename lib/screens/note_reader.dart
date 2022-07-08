import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper/screens/ViewScreen.dart';
import 'package:note_keeper/style/app_style.dart';
import 'package:path/path.dart'; // import 'package:note_keeper/screens/';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          // TextButton(
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
          //     child: const Text('Save')),
          // TextButton(
          //     onPressed: () {
          //       widget.doc.reference.update({
          //         'notes_title': widget.doc["notes_title"],
          //         'creation_date': widget.doc["creation_date"],
          //         'note_content': widget.doc["note_content"],
          //       }).whenComplete(() => Navigator.pop(context));
          //     },
          //     child: const Text('Save as')),
          // TextButton(onPressed: () {}, child: const Text('Delete')),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateScreen(widget.doc)),
                );
              },
              child: const Icon(Icons.edit))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doc["notes_title"],
                style: AppStyle.mainTitle,
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                widget.doc["creation_date"],
                style: AppStyle.datetitle,
              ),
              SizedBox(
                height: 28.0,
              ),
              Text(
                widget.doc["note_content"],
                style: AppStyle.mainContent,
                // overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
