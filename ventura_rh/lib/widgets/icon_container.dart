import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ventura_rh/utils/responsive.dart';

class IconContainer extends StatelessWidget {
  final double size;
  const IconContainer({Key key, @required this.size})
      : assert(size != null && size > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive respansive = Responsive.of(context);
    return Container(
      width: respansive.ip(15),
      height: respansive.ip(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size * 0.1),
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 25,
              offset: Offset(0,15),
            ),
          ]),
      padding: EdgeInsets.all(this.size * 0.15),
      child: Center(
        child: SvgPicture.asset(
          'assets/logo.svg',color: null,
          width: size * 0.8,
          height:size * 0.8,
        ),
      ),
    );
  }
}
