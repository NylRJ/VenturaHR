import 'package:flutter/material.dart';
import 'package:ventura_rh/common/components/custom_drawer/drawer_tile.dart';
import 'package:ventura_rh/common/components/custom_drawer/page_header.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;


    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(right:  Radius.circular(50)),
      child: SizedBox(
        width: isTablet? MediaQuery.of(context).size.width * 0.50:MediaQuery.of(context).size.width * 0.60,
        child: Drawer(
          child: Consumer<UserManager>(
            builder: (_,userManager,__){
              return ListView(
                children: <Widget>[
                  PageHeader(isTablet: isTablet,),
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
                  if(userManager.isLoggedIn)
                    if(userManager.isCompany())
                  const DrawerTile(
                    iconData:  IconData(0xe900, fontFamily: 'editar_vagas'),
                    title: 'Publicar Vagas',
                    page: 2,
                  ),
                  if(userManager.isLoggedIn)
                    if(userManager.isCompany())
                      const DrawerTile(
                        iconData:  IconData(0xe9ae, fontFamily: 'ic_mala'),
                        title: 'Vagas Publicadas',
                        page: 3,

                      ),
                  if(userManager.isLoggedIn)
                    if(userManager.isCompany())
                      Transform.translate(
                        offset: Offset(-25,0),
                        child: const DrawerTile(
                          iconData:  IconData(0xe901, fontFamily: 'ranking_vagas',),
                          title: 'Ranking',
                          page: 4,
                          size: 50,
                        ),
                      ),
                  if(userManager.isLoggedIn)
                    if(!userManager.isCompany())
                  const DrawerTile(
                    iconData:  IconData(0xe900, fontFamily: 'editar_vagas'),
                    title: 'Vagas Respondidas',
                    page: 5,

                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
