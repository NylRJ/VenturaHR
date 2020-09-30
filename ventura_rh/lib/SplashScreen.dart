import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            width: 360.0,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  const Color(0xff00838f),
                  const Color(0xffa0aeaf),
                  const Color(0xff00838f),
                  const Color(0xff078574)
                ],
                stops: [0.0, 0.318, 1.0, 1.0],
              ),
            ),
          ),
          Container(
            width: 360.0,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  const Color(0xff00838f),
                  const Color(0xff8eecdf),
                  const Color(0xffffffff),
                  const Color(0xff8eecdf),
                  const Color(0xff10b5c4)
                ],
                stops: [0.0, 0.234, 0.452, 0.686, 1.0],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(35.0, 232.0),
            child:
            // Adobe XD layer: 'logo Azul' (shape)
            Container(
              width: 291.0,
              height: 140.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/logoRH.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
