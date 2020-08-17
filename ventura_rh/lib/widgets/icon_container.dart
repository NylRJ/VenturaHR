import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  final double size;
  IconContainer({Key key, @required this.size})
      : assert(size != null && size > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(this.size * 0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 25,
              offset: Offset(0,15),
            ),
          ]),
      padding: EdgeInsets.all(this.size * 0.15),
      child: Center(
        child: SvgPicture.asset(
          'assets/logo.svg',color: null,
          width: this.size * 0.8,
          height: this.size * 0.8,
        ),
      ),
    );
  }
}
