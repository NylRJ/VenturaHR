import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class InputTextLogin extends StatelessWidget {
  final String iconsPath;
  final String placeHolder;
  const InputTextLogin({Key key,@required this.iconsPath, @required this.placeHolder}):
        assert(iconsPath != null && placeHolder != null),super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CupertinoTextField(
      padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 7),
      prefix: Container(
        width: 40,
        height: 30,
        padding: const EdgeInsets.all(2),
        child: SvgPicture.asset(iconsPath,color: const Color(0xff37474f),),

      ),
      style: const TextStyle(fontFamily: 'sans'),
      placeholder: placeHolder,
      placeholderStyle: TextStyle(fontFamily: 'sans',color: Color(0xffcccccc)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xff37474f)),
        ),
      ),
    );
  }
}
