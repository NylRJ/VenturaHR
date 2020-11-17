import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/resposta_vaga/vacancies_answered.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';

import '../vaga_details/components/tabela_criterio.dart';
import 'components/user_detaiils.dart';


class UserVagaDetails2 extends StatelessWidget {

  const UserVagaDetails2(this.vacanciesAnswered);
  final VacanciesAnswered vacanciesAnswered ;



  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final userManager = context.watch<UserManager>();
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;


    return Consumer<VagaManager>(
      builder: (_,vagaManager,__){
        return Scaffold(
          backgroundColor: AppColors.primaryColorlighter,
          appBar: AppBar(
            title: Text(vacanciesAnswered.userName),
            centerTitle: true,
          ),
          body:UserDetaiils(vacanciesAnswered: vacanciesAnswered,) ,


        );
      },
    );
  }
}
