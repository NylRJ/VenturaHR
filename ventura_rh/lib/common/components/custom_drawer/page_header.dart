import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/page_manager.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';

class PageHeader extends StatelessWidget {
  final bool isTablet;

  const PageHeader({Key key, this.isTablet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      color: Theme.of(context).primaryColor,
      height: isTablet ? 200 : 95,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<UserManager>(
        builder: (_,userManager,__){
          return Row(
            children: [
              if (userManager.isLoggedIn)
              Container(
                width: responsive.ip(10),
                height: responsive.ip(15),
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
              Icon(
                Icons.person,
                color: Colors.white,
                size: isTablet ? 75 : 35,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (userManager.isLoggedIn)
                      Text(
                      'Olá ${userManager.userHR?.name ?? ''}',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: isTablet ? 22 : 16,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: (){
                        if(userManager.isLoggedIn){
                          context.read<PageManager>().setPage(0);
                          userManager.signOut();
                        } else {
                          Navigator.of(context).pushNamed('/login');
                        }
                      },
                      child: Text(
                        userManager.isLoggedIn
                            ? 'Sair'
                            : 'Entre ou cadastre-se >',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
