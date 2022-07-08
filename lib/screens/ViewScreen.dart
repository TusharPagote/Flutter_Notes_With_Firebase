import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper/style/app_style.dart';
import 'package:intl/intl.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen(this.docToEdit, {Key? key}) : super(key: key);

  QueryDocumentSnapshot docToEdit;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  // int color_id = widget.docToEdit["color_id"];
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  TextEditingController _updateTitleController = TextEditingController();
  TextEditingController _updateMainController = TextEditingController();

  @override
  void initState() {
    _updateTitleController =
        TextEditingController(text: widget.docToEdit["notes_title"]);
    _updateMainController =
        TextEditingController(text: widget.docToEdit["note_content"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int color_id = widget.docToEdit["color_id"];

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              onPressed: () {
                //   widget.docToEdit.reference
                //       .update({
                //         'notes_title': _updateTitleController,
                //         'creation_date': date,
                //         'note_content': _updateMainController,
                //       })
                //       .whenComplete(() => Navigator.pop(context))
                //       .catchError((error) =>
                //           print("Failed to add new note deu to $error"));
                // },
                // child: const Text('Save')),

                widget.docToEdit.reference.delete();
//
                FirebaseFirestore.instance.collection("Notes").add({
                  "notes_title": _updateTitleController.text,
                  "creation_date": date,
                  "note_content": _updateMainController.text,
                  "color_id": color_id,
                }).then((value) {
                  print(value.id);
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                }).catchError(
                    (error) => print("Failed to add new note deu to $error"));
              },
              // child: const Text('Save')),
              child: Icon(Icons.save)),
          TextButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('! Warning'),
                      content: const Text(
                          'Do you really want to delete this note ?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.docToEdit.reference
                                .delete()
                                .whenComplete(() => Navigator.of(context)
                                  ..pop()
                                  ..pop()
                                  ..pop());
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
              // child: const Text('Delete')),
              child: Icon(Icons.delete)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            // reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _updateTitleController,
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
                  controller: _updateMainController,
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
      ),
    );
  }
}
