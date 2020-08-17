import 'package:flutter/material.dart';
import 'package:ventura_rh/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
           DrawerTile(
            iconData: Icons.home,
            title: 'Inicio',
            page: 0,
          ),
          const Divider(),
          DrawerTile(
            iconData: const IconData(0xe900, fontFamily: 'busca_vaga'),
            title: 'Vagas',
            page: 1,
          ),
          const Divider(),
          DrawerTile(
            iconData: const IconData(0xe900, fontFamily: 'editar_vagas'),
            title: 'Vagas',
            page: 2,
          ),
        ],
      ),
    );
  }
}
