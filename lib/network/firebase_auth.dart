import 'package:dhakaiaforum/model/NetworkRequestModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Future<NetworkRequestModel> registerUserWithFirebase(
//     String email,
//     String password) async {
//   String message = "";
//   bool isSc  = false;
//   try {
//     await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     ).then((value) {
//       message = "Registration Success";
//       isSc = true;
//
//     });
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       message = "The password provided is too weak.";
//       isSc = false;
//     } else if (e.code == 'email-already-in-use') {
//       message = "The account already exists for that email.";
//       isSc = false;
//     } else {
//       message = e.code;
//       isSc = false;
//     }
//   } catch (e) {
//     message =e.toString();
//     isSc = false;
//   }
//   return NetworkRequestModel(message, isSc);
// }
