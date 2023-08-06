import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhakaiaforum/component/elementary_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../util/util.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final db = FirebaseFirestore.instance;

  List<String> posts = [];
  getDocuments(){
    showLoaderDialog(context, "Your post is loading!");
    db.collection("posts").get().then(
          (querySnapshot) {
            Navigator.pop(context);
        for (var docSnapshot in querySnapshot.docs) {
          posts.add(docSnapshot.get("post_string"));
        }
        setState(() {

        });
      },
      onError: (e) {
            Navigator.pop(context);
      print("Error completing: $e");
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getDocuments();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard Screen"),backgroundColor: CupertinoColors.systemGreen,),
      body: SafeArea(
        child: Column(
          children: [
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: customButton("Post Something",Colors.green, () {
               navigateToPostScreen(context);
             }),

           ),
            Flexible(
              child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        postItem(posts[index]),
                        SizedBox(height: 20,)
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget postItem(String postString) {
    return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 5),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: customButton(postString, Colors.grey.shade500, () { })),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    Flexible(flex:5,child: customButton("Like", Colors.blueGrey.shade400, () { })),
                    SizedBox(width: 5,),
                    Flexible(flex:3,child: customButton("Share", Colors.green.shade300, () { }))
                  ],
                ),
              )
            ],
          );
  }

}
