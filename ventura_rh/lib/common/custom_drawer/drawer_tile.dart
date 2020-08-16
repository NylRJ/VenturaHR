import 'package:flutter/material.dart';
class DrawerTile extends StatelessWidget {
  DrawerTile({this.icon,this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text(text),
      ],
    );
  }
}
