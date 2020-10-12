import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ventura_rh/models/page_manager.dart';
import 'package:ventura_rh/models/users/user_manager.dart';


class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 95,
      padding: const EdgeInsets.symmetric(horizontal: 20) ,

      child: Consumer<UserManager>(
        builder: (_,userManager,__){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //espaçar o texto dentro da coluna
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Icon(Icons.person, color: Colors.white,size: 35,),
              //'Olá ${userManager.user?.name ?? ''}'
              Text(
                  '',
                //caso o nome seja muito grande nao estoure a tela
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: (){
                  // if(userManager.isLoggedIn){
                  //   context.read<PageManager>().setPage(0);
                  //   userManager.signOut();
                  // }else{
                  //   Navigator.of(context).pushNamed('/login');
                  // }
                },
                child: Text(
                  false
                      ? 'Sair'
                      : 'Entre ou Cadastre-se >',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          );
        }
      ) ,
    );
  }
}
