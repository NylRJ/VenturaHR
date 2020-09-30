import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ventura_rh/screens/base/base_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            width:MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  Color(0xff00838f),
                  Color(0xffa0aeaf),
                  Color(0xff00838f),
                  Color(0xff078574)
                ],
                stops: [0.0, 0.318, 1.0, 1.0],
              ),
            ),
          ),
          Container(
            width:MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  Color(0xff00838f),
                  Color(0xff8eecdf),
                  Color(0xffffffff),
                  Color(0xff8eecdf),
                  Color(0xff10b5c4)
                ],
                stops: [0.0, 0.234, 0.452, 0.686, 1.0],
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(35.0, 232.0),
            child:
            // Adobe XD layer: 'logo Azul' (shape)
            Container(
              width: 291.0,
              height: 140.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logoRH.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BaseScreen()));
    });
  }
}
