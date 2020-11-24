import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/resposta_vaga/vacancies_answered.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:provider/provider.dart';

class VacanciesAnsweredTile extends StatelessWidget {
  final VacanciesAnswered vacanciesAnswered ;
  final bool isTablet ;

  const VacanciesAnsweredTile({Key key, this.vacanciesAnswered, this.isTablet}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context);
    final userManager  = context.watch<UserManager>() ;
    return GestureDetector(
      onTap:userManager.isLoggedIn? (){
        if (!userManager.isCompany()) {
          Navigator.of(context).pushNamed('/vagaDetails',arguments: vacanciesAnswered.vaga,);

        }else if (userManager.isCompany()) {
          Navigator.of(context).pushNamed('/userVagaDetails',arguments: vacanciesAnswered,);
        }
      }:(){
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Cadastre-se ou Entre Para Visualizar Os Detalhes das Vagas',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.secondaryColor,
          ),
        );
      },
      child:!userManager.isCompany()?
      Container(
        margin:const EdgeInsets.all(4),
        child: Material(
          elevation: 14.0,
          borderRadius: isTablet?BorderRadius.circular(40):BorderRadius.circular(24),
          child: Transform.translate(
            offset:isTablet ?const Offset(50,0.0):const Offset(0.0,0.0),
            child: Row(
              children: [
                //Logo
                Transform.translate(
                  offset:isTablet ?const Offset(100,0.0):const Offset(10,0.0),
                  child: Material(
                    elevation: 14.0,
                    borderRadius: isTablet?BorderRadius.circular(79):BorderRadius.circular(60),
                    child: Container(
                      width:isTablet?160:120,
                      height:isTablet?160:120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(vacanciesAnswered.companyImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset:isTablet ? const Offset(160,20):const Offset(20,20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(vacanciesAnswered.companyTitle,style:  TextStyle(fontSize:isTablet?25:24,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 1),
                      Text(vacanciesAnswered.titleVacancy, style:  TextStyle(fontSize:isTablet?22:21,),),
                      SizedBox(height: responsive.ip(1.2),),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ):
      Container(

        height: 200,
        margin:const EdgeInsets.all(4),

        child: Material(
          elevation: 14.0,
          borderRadius: isTablet?BorderRadius.circular(40):BorderRadius.circular(24),
          child: Row(

            children: [
              Transform.translate(
                offset: isTablet?Offset(100,0):Offset(10,0),
                child: Material(
                  elevation: 14.0,
                  borderRadius: isTablet?BorderRadius.circular(70):BorderRadius.circular(60),
                  child: Container(
                    width:isTablet?160:120,
                    height:isTablet?160:120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(vacanciesAnswered.userImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Transform.translate(
                offset: isTablet?Offset(160,20):Offset(5,20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                       Text('Vaga',
                       style: TextStyle(
                           fontSize:isTablet?25:17,fontWeight: FontWeight.bold,fontFamily: 'sans'),
                     ),

                     Text(vacanciesAnswered.titleVacancy,
                      style: TextStyle(
                          fontSize:isTablet?25:17,fontWeight: FontWeight.w500,fontFamily: 'sans'),
                     ),
                    Row(
                      children: [
                        Text(vacanciesAnswered.userName,
                          style: TextStyle(
                              fontSize: isTablet?25:17,fontWeight: FontWeight.bold,fontFamily: 'sans'),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                         Transform.translate(
                           offset:isTablet? Offset(90,-90):Offset(0,15),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Text('Score',
                                 style: TextStyle(
                                     fontSize: 17,color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontFamily: 'sans'),
                               ),
                               Stack(
                                 children: [
                                   Image.asset('assets/images/score/score.png',height: 25,),
                                   Transform.translate(
                                     offset: Offset(10,5),
                                     child: Text(vacanciesAnswered.score.toString(),
                                       style: TextStyle(
                                           fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'sans'),
                                     ),
                                   ),
                                 ],
                               )
                             ],
                           ),
                         )
                      ],
                    ),



                  ],
                ),
              ),
            ],
          ),
        ),
    )
    );
  }
}
