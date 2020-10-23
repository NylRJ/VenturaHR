import 'package:flutter/material.dart';
class CustomIconButton extends StatelessWidget {

  const CustomIconButton({this.iconData,this.color,this.onTap});

  final IconData iconData;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    //InkWell tem que esta dentro de um Material para funcionar
    //ClipRRect deixa a sombra do InkWell a redondada quando ele precionar
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              iconData,
              color: onTap != null? color:Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
