import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';

import 'components/tabela_criterio.dart';


class VagaDetails extends StatelessWidget {
  const VagaDetails(this.vaga);

  final Vaga vaga;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(vaga.companyTitle.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          Consumer<UserManager>(
            builder: (_,userManager,__){
              if (userManager.isCompany()) {
                return IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed('/vaga_edit',arguments: vaga);
                  },
              );
              }else{
                return Container();
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 250,
            color: Colors.white,
            child: Container(
              width: responsive.ip(20),
              height: responsive.ip(25),
              margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(vaga.images.first),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  vaga.titleVacancy,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.secondaryDarker,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    vaga.descriptionVacancy,
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.secondaryDarker,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: AppColors.secondaryColorlighter,
                  thickness: 0.5,
                ),
                TabelaCriterio(
                  vaga: vaga,
                ),


              ],
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,

        onPressed: (){},
        child: Icon(
          IconData(0xe900, fontFamily: 'editar_vagas'),
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
