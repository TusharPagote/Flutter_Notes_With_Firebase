// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_keeper/screens/ViewScreen.dart';
import 'package:note_keeper/screens/note_editor.dart';
import 'package:note_keeper/screens/note_reader.dart';
import 'package:note_keeper/style/app_style.dart';
import 'package:note_keeper/widgets/note_card.dart';

// import 'EditNotes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Fire - Notes"),
        centerTitle: true,
        // backgroundColor: AppStyle.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your recent Notes",
                style: GoogleFonts.roboto(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    // print(snapshot.data!.docs[0]);
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((note) => noteCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NoteReaderScreen(note),
                                    ));
                              }, note))
                          .toList(),
                    );
                  }
                  return Text(
                    "There's No Notes",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        child: Icon(Icons.add),
      ),
      // drawer: Drawer(
      //   elevation: 16.0,
      //   backgroundColor: Color(0xFF000633),
      //   child: Column(
      //     children: <Widget>[
      //       const UserAccountsDrawerHeader(
      //         accountName: Text("xyz"),
      //         accountEmail: Text("xyz@gmail.com"),
      //         currentAccountPicture: CircleAvatar(
      //           backgroundColor: Colors.white,
      //           child: Text("xyz"),
      //         ),
      //         otherAccountsPictures: <Widget>[
      //           CircleAvatar(
      //             backgroundColor: Colors.white,
      //             child: Text("abc"),
      //           )
      //         ],
      //       ),
      //       ListTile(
      //         title: new Text("Profile"),
      //         leading: new Icon(Icons.mail),
      //         textColor: Colors.white,
      //         iconColor: Colors.white,
      //       ),
      //       Divider(
      //         height: 0.1,
      //       ),
      //       ListTile(
      //         title: new Text("All Notes"),
      //         leading: new Icon(Icons.inbox),
      //         textColor: Colors.white,
      //         iconColor: Colors.white,
      //       ),
      //       ListTile(
      //         title: new Text("Dark Mode"),
      //         leading: new Icon(Icons.people),
      //         textColor: Colors.white,
      //         iconColor: Colors.white,
      //       ),
      //       ListTile(
      //         title: new Text("Log out"),
      //         leading: new Icon(Icons.local_offer),
      //         textColor: Colors.white,
      //         iconColor: Colors.white,
      //       ),
      //       ListTile(
      //         // title: new Text("Log out"),
      //         // leading: new Icon(Icons.local_offer),
      //         textColor: Colors.white,
      //         iconColor: Colors.white,
      //       ),
      //       ListTile(
      //         // title: new Text("Log out"),
      //         // leading: new Icon(Icons.local_offer),
      //         textColor: Colors.white,
      //         iconColor: Colors.white,
      //       ),
      //       ListTile(
      //         title: new Text("About"),
      //         leading: new Icon(Icons.local_offer),
      //         textColor: Colors.white,
      //         iconColor: Colors.white,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
