import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ventura_rh/screens/base/base_screen.dart';

void main() {
  runApp(MyApp());
  Firestore.instance.collection('teste').add({'teste':'teste'});
  
  
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VenturaHR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor: const Color.fromARGB(255, 0, 131 , 143),
        scaffoldBackgroundColor: const Color.fromARGB(255, 197, 200, 200),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BaseScreen(),
    );
  }
}