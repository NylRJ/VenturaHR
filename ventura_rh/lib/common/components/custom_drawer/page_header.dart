import 'package:flutter/material.dart';
import 'package:ventura_rh/models/page_manager.dart';
import 'package:provider/provider.dart';

class PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 95,
      padding: const EdgeInsets.symmetric(horizontal: 20) ,

      child: Row(
        children: [
          const Icon(Icons.person, color: Colors.white,size: 35,),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Acesse sua conta agora!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
                        fontSize: 14,
                        fontWeight: FontWeight.w400

                  ),

                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
