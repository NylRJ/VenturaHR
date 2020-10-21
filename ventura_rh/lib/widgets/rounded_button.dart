import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ventura_rh/utils/app_colors.dart';

class RoundedButton extends StatefulWidget {
  final String label;
  final Widget progress;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color disableColor ;

  const RoundedButton({Key key, @required this.onPressed, @required this.label, this.backgroundColor, this.disableColor , this.progress})
      : assert(label != null, disableColor ?? Colors.grey),
        super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: widget.onPressed??null,
      disabledColor: widget.disableColor,
      child: Container(
        decoration:  BoxDecoration(
            color: (widget.onPressed == null)?Colors.grey[500] ?? AppColors.primaryColor:widget.backgroundColor ,
            borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),]
        ),
        padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
        child: (widget.progress == null)?Text(
          widget.label,
          style: const TextStyle(fontFamily: 'sans',letterSpacing: 1,fontSize: 18, color: Color(0xffffffff)),
        ):widget.progress,
      ),
    );
  }
}
