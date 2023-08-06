import 'package:dhakaiaforum/ui/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../ui/dashboard_screen.dart';

showToastMessage(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 16.0
  );
}

showLoaderDialog(BuildContext context, String message) {
  AlertDialog alert = AlertDialog(
    content: IntrinsicHeight(
      child: Column(
        children: [
          const CircularProgressIndicator(
            color: Color.fromARGB(255, 233, 167, 81),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text(
                message,
                style: const TextStyle(
                    color: Color.fromARGB(255, 54, 54, 54),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void navigateToPostScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostScreen()));
}
void navigateToDashboardScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardScreen()));
}
String getCurrentTimeAsString(){
  DateTime now = DateTime.now();
  return DateFormat('kk:mm:ss, d, MMM EEE').format(now);
}