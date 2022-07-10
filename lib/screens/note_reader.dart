import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper/screens/ViewScreen.dart';
import 'package:note_keeper/style/app_style.dart';
// import 'package:note_keeper/screens/';

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
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
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
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doc["notes_title"],
                style: AppStyle.mainTitle,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.doc["creation_date"],
                style: AppStyle.datetitle,
              ),
              const SizedBox(
                height: 28.0,
              ),
              Text(
                widget.doc["note_content"],
                style: AppStyle.mainContent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
