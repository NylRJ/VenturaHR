import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const RoundedButton({Key key, @required this.onPressed, @required this.label})
      : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Container(
        decoration:  BoxDecoration(
            color:  const Color(0xff37474f),
            borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),]
        ),
        padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
        child: Text(
          label,
          style: const TextStyle(fontFamily: 'sans',letterSpacing: 1,fontSize: 18, color: Color(0xffffffff)),
        ),
      ),
    );
  }
}
