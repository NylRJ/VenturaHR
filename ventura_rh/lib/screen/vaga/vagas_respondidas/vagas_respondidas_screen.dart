import 'package:flutter/material.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';
import 'components/vacancies_answered_tile.dart';

class VagasRespondidas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final userManager = context.watch<UserManager>();
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    return  Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(!userManager.isCompany()?'Vagas Respondidas':'Ranking'),
        centerTitle: true,
      ),
      body: Consumer<VagaManager>(
        builder: (_, vagaManager, __) {
          return ListView.builder(
              padding: EdgeInsets.all(4),
              itemCount: vagaManager.allVacanciesAnswered.length,
              itemBuilder: (_, index) {
                return LimitedBox(
                  maxHeight: isTablet?200:160,
                  child: VacanciesAnsweredTile(
                    isTablet: isTablet,
                    vacanciesAnswered:vagaManager.allVacanciesAnswered[index],
                  ),
                );
              });
        },
      ),
    );
  }
}
