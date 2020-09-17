import 'package:flutter/material.dart';
import 'package:ventura_rh/common/components/custom_drawer/drawer_tile.dart';
import 'package:ventura_rh/common/components/custom_drawer/page_header.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(right:  Radius.circular(50)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              PageHeader(),
              const SizedBox(height: 10,),
              const DrawerTile(
                iconData: Icons.home,
                title: 'Inicio',
                page: 0,
              ),
              const Divider(),
              const DrawerTile(
                iconData: IconData(0xe900, fontFamily: 'busca_vaga'),
                title: 'Buscar Vaga',
                page: 1,
              ),
              const Divider(),
              const DrawerTile(
                iconData:  IconData(0xe900, fontFamily: 'editar_vagas'),
                title: 'Publicar Vagas',
                page: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
