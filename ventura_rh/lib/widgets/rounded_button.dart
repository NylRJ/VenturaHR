import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ventura_rh/utils/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const RoundedButton({Key key, @required this.onPressed, @required this.label, this.backgroundColor})
      : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Container(
        decoration:  BoxDecoration(
            color: backgroundColor ?? AppColors.primaryColor ,
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
