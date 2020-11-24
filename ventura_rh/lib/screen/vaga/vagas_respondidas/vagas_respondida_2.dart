import 'package:flutter/material.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/resposta_vaga/vacancies_answered.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';
import 'package:ventura_rh/screen/vaga/components/vaga_list_tile.dart';
import 'package:ventura_rh/screen/vaga/components/vaga_list_tile2.dart';

import 'components/vacancies_answered_tile.dart';

class VagasRespondida2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return  Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(!userManager.isCompany()?'Vagas Preenchidas':'Vagas Respondidas'),
        centerTitle: true,
      ),
      body: Consumer<VagaManager>(
        builder: (_, vagaManager, __) {
          final List<Vaga>filteredVagas = [];

         if (userManager.isCompany()) {
           vagaManager.allVagas.map((v) {
             if(v.userId == userManager.userHR.id ) {

               vagaManager.allVacanciesAnswered.forEach((e){
                 if (v.id == e.vagaId) {
                   if(!filteredVagas.contains(v)){
                     filteredVagas.add(v);
                   }
                 }
               });

             }
           } ).toList();
         } else{

         }
          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount:userManager.isCompany()?filteredVagas.length:vagaManager.allVacanciesAnswered.length,
              itemBuilder: (_, index) {
                return LimitedBox(
                  maxHeight: isTablet?200:160,

                  child:userManager.isCompany()?VagaListTile2(
                    isTablet: isTablet,
                    vaga: filteredVagas[index],
                  ):VacanciesAnsweredTile(
                    isTablet: isTablet,
                    vacanciesAnswered: vagaManager.allVacanciesAnswered[index],
                  ),
                );
              });
        },
      ),
    );
  }
}
