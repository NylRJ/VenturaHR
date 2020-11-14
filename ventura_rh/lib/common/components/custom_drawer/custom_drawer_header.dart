import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ventura_rh/models/page_manager.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/utils/responsive.dart';


class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
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
             if (userManager.isLoggedIn)
              Container(
                width: responsive.ip(20),
                height: responsive.ip(25),
                margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(userManager.userHR.images.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (!userManager.isLoggedIn)
             const Icon(Icons.person, color: Colors.white,size: 35,),

              //'Olá ${userManager.user?.name ?? ''}'
              GestureDetector(
                onTap: (){
                  if(userManager.isLoggedIn){
                    context.read<PageManager>().setPage(0);
                    userManager.signOut();
                  }else{
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(
                  userManager.isLoggedIn
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
