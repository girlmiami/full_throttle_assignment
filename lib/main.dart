import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:full_throttle_assignment/screens/todo_list.dart';
import 'package:full_throttle_assignment/widgets/floating_button.dart';

final databaseRef = FirebaseFirestore.instance.collection("FullThrottle");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Color(0xff266AFD),
        scaffoldBackgroundColor: Color(0xff181827),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Abhinav\'s Assignment"),
          backgroundColor: Color(0xff266AFD),
        ),
        body: ToDoList(),
        floatingActionButton: FloatingButton(),
      ),
    );
  }
}
