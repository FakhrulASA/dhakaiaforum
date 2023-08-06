import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhakaiaforum/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/elementary_component.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var postString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a post"),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
              decoration: BoxDecoration(
              color: Colors.lightGreen.shade100,
                borderRadius: new BorderRadius.circular(10.0),
              ),
          child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: TextFormField(
                maxLines: 10,
                minLines: 6,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    hintText: "Whats your thought!!",
                    hintStyle:
                    TextStyle(color: CupertinoColors.inactiveGray)),
                onChanged: (value) {
                  postString = value;
                  setState(() {});
                },
              ))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: customButton("Submit Post", Colors.black45, () {
                try{
                  final user = FirebaseAuth.instance.currentUser;
                  showLoaderDialog(
                      context, "Your post is uploading, please wait!");
                  CollectionReference addPostToDb =
                  FirebaseFirestore.instance.collection('posts');
                  addPostToDb.add({
                    'time': getCurrentTimeAsString(),
                    // 'user': user!.email,
                    // 'user_id': user!.uid,
                    'user': "abc@xyz.com",
                    'user_id': "lk129409214kj2140",
                    'post_string': postString,
                  }).then((value) {
                    Navigator.pop(context); //dialog
                    Navigator.pop(context); //screen close
                    navigateToDashboardScreen(context);
                  }).catchError((error) {
                    Navigator.pop(context);
                    showToastMessage("Failed to add post: $error");
                  });
                }catch(e){
                  Navigator.pop(context);
                  showToastMessage(e.toString());
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: customButton(
                  "Discard Post", Colors.redAccent.shade100, () {}),
            )
          ],
        ),
      ),
    );
  }
}
