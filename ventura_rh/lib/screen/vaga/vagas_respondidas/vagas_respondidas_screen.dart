import 'package:flutter/material.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/resposta_vaga/vacancies_answered.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';
import 'components/vacancies_answered_tile.dart';

class VagasRespondidas extends StatelessWidget {
  final  Vaga vaga;

  const VagasRespondidas({Key key, this.vaga}) : super(key: key);


  @override
  Widget build(BuildContext context) {

  final userManager = context.watch<UserManager>();
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final listVagasFilter = context.watch<VagaManager>().filterResponseByVacancy(vaga);

    return  Scaffold(
      appBar: AppBar(
        title: Text(!userManager.isCompany()?'Vagas Respondidas':'Ranking'),
        centerTitle: true,
      ),
      body: Consumer<VagaManager>(
        builder: (_, vagaManager, __) {
          return ListView.builder(
              padding: EdgeInsets.all(4),
              itemCount: listVagasFilter.length,
              itemBuilder: (_, index) {
                return LimitedBox(
                  maxHeight: isTablet?200:160,
                  child: VacanciesAnsweredTile(
                    isTablet: isTablet,
                    vacanciesAnswered:listVagasFilter[index],
                  ),
                );
              });
        },
      ),
    );
  }
}
