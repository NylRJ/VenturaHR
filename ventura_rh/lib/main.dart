import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:ventura_rh/screens/base/base_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  runApp(MyApp());


}

Future<void> initializeParse() async{
  await Parse().initialize(
    'qGZcg2jD43HfFw6YAbpcfN7RQgFB0udZIgtWWvw6',
    'https://parseapi.back4app.com/',
    clientKey: 'nZbpDwex4JsskmE02Lp9oEpzlD6vQWeEnFCZ54P3',
    autoSendSessionId: true,
    debug: true,
  );

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ventura HR',
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