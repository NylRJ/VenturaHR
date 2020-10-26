import 'package:flutter/material.dart';
import 'package:ventura_rh/models/page_manager.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';

class PageHeader extends StatelessWidget {

  final bool isTablet ;

  const PageHeader({Key key, this.isTablet}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: isTablet? 200:95,
      padding: const EdgeInsets.symmetric(horizontal: 20) ,

      child: Row(
        children: [

           Icon(Icons.person, color: Colors.white,size:isTablet? 75:35,),
          const SizedBox(width: 20,),
          Expanded(
            child: Consumer<UserManager>(
              builder: (_,useranager,__){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Acesse sua conta agora!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: isTablet? 22:16,
                          fontWeight: FontWeight.w500
                      ),

                    ),

                    GestureDetector(
                      onTap: (){


                        Navigator.of(context).pushNamed('/login');

                      },

                      child: Text('Clique a Aqui',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet? 18:14,
                            fontWeight: FontWeight.w400

                        ),

                      ),
                    )

                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
