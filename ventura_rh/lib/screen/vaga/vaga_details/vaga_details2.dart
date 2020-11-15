import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/resposta_vaga/vacancies_answered.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';

import 'components/tabela_criterio.dart';


class VagaDetails2 extends StatelessWidget {
  const VagaDetails2(this.vaga);

  final Vaga vaga;


  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final userManager = context.watch<UserManager>();


    return Consumer<VagaManager>(
      builder: (_,vagaManager,__){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(vaga.companyTitle.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
            actions: [
            if(userManager.isLoggedIn)
              if ( userManager.isCompany()  && userManager.userHR.id == vaga.userId )
            IconButton(
            icon: Icon(Icons.edit),
                  onPressed: (){
        Navigator.of(context).pushReplacementNamed('/vaga_edit',arguments: vaga);
            },
        ),
         Container(),


         Container(),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      //padding: EdgeInsets.fromLTRB(left, top, right, bottom)
                      padding: EdgeInsets.fromLTRB(150, 8, 150, 8),


                      child: Text(
                        '${vaga.titleVacancy}',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: Text(
                        '${vaga.descriptionVacancy}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 18,
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

                    if (userManager.isLoggedIn && !userManager.isCompany())
                      RoundedButton(
                        disableColor: AppColors.primaryColorlighter,
                          backgroundColor: AppColors.primaryColor,
                          onPressed:vagaManager.vacancyIsAnswered(vaga)?null:(){
                          //TODO:SALVAR RESPOSTA
                          vagaManager.vacanciesAnsweredUser.saveUser();
                          vagaManager.vacanciesAnsweredCompany.saveCompany();

                           print(vagaManager.vacanciesAnsweredUser);

                           vagaManager.updateListVacanciesAnswered();
                           Navigator.of(context).pop();
                          },
                          label: 'Responder'
                      )
                    else Container(),
                  ],
                ),
              ),

            ],
          ),


        );
      },
    );
  }
}
