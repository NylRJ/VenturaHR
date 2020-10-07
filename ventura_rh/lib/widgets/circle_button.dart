import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ventura_rh/utils/app_colors.dart';

class CircleButton extends StatelessWidget {
  final String iconPath;
  final double size ;
  final Color backgroundColor;

  const CircleButton({Key key, this.size = 50, this.backgroundColor,@required this.iconPath}) :
        assert(iconPath != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(10),

      decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor,
          shape: BoxShape.circle
      ),
      child: SvgPicture.asset(iconPath,color: AppColors.textColor,) ,
    );
  }
}
