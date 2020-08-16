import 'package:flutter/material.dart';
import 'package:ventura_rh/common/custom_drawer/drawer_tile.dart';
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerTile(icon: Icons.home,text: 'Inicio',),
          DrawerTile(icon: Icons.list,text: 'Vagas',),
          DrawerTile(icon: Icons.home,text: 'Inicio',),
        ],
      ),
    );
  }
}
