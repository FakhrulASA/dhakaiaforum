import 'package:dhakaiaforum/ui/dashboard_screen.dart';
import 'package:dhakaiaforum/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Enter email!"),
              onChanged: (value) {
                email = value;
                setState(() {

                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Enter password!"),
              onChanged: (value) {
                password = value;
                setState(() {

                });
              },
            ),
          ),
          GestureDetector(
              onTap: () async {
                showLoaderDialog(context, "Registering, please wait!");
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  ).then((value){
                    Navigator.pop(context);
                    showToastMessage("Successfully registered!");
                  });
                } on FirebaseAuthException catch (e) {
                  Navigator.pop(context);
                  if (e.code == 'weak-password') {
                    showToastMessage('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    showToastMessage('The account already exists for that email.');
                  }
                } catch (e) {
                  Navigator.pop(context);
                  showToastMessage(e.toString());
                }
              },
              child: Container(
                  height: 30,
                  width: 150,
                  color: Colors.blue,
                  child: Center(child: Text("Register User"))))
        ],
      )),
    );
  }
}
