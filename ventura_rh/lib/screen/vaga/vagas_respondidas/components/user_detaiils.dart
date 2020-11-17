import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ventura_rh/models/vaga/resposta_vaga/vacancies_answered.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';

class UserDetaiils extends StatelessWidget {
  final VacanciesAnswered vacanciesAnswered;

  const UserDetaiils({Key key, this.vacanciesAnswered}) : super(key: key);

  @override
  void afterFirstLayout(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    if (!isTablet) {
      //Se estiver no SmartPhone Blouqeio a rotação do dispositivo
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final bool isPortrait = responsive.width < responsive.height;
    final bool _isTablet = MediaQuery.of(context).size.shortestSide >= 600;


    return OrientationBuilder(
      builder: (_,Orientation orientation){

            if (isPortrait) {
              return Transform.translate(
                offset: const Offset(10,0),
                child: Container(
                  height: isTablet?850:650,
                  margin: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width - 20,
                  child: Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius:isTablet ? BorderRadius.circular(20): BorderRadius.circular(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: isTablet ? 500 : 300,
                              decoration: BoxDecoration(
                                borderRadius:  BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(vacanciesAnswered.userImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset:isTablet? Offset(90,-90):Offset(320,15),
                              child: Column(
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
                          ] ,
                        ),

                        Container(
                          margin:const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Text(
                                vacanciesAnswered.userName,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                              ),

                            ],
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(90,20),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Vaga',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                Text(
                                  vacanciesAnswered.titleVacancy,
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Divider(
                          color: AppColors.secondaryColor,
                        ),
                        Transform.translate(
                          offset: Offset(10,0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Endereço',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                              Row(
                                children: [
                                  const Icon(Icons.home),
                                  const SizedBox(width: 10,),
                                  Text(
                                    '${vacanciesAnswered.userHR.address.street},',
                                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                                  ),const SizedBox(width: 2,),
                                  Text(
                                    '${vacanciesAnswered.userHR.address.district},',
                                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                                  ),
                                  const SizedBox(width: 2,),
                                  Text(
                                    '${vacanciesAnswered.userHR.address.state}',
                                    style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Divider(

                          color: AppColors.secondaryColor,

                        ),
                        Transform.translate(
                          offset:const Offset(10,0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('E-mail',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                              Row(
                                children: [
                                  Icon(Icons.email),
                                  SizedBox(width: 10,),
                                  Text(
                                    vacanciesAnswered.userHR.email,
                                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Divider(

                          color: AppColors.secondaryColor,

                        ),
                        Transform.translate(
                          offset: Offset(10,0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Telefone',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                              Row(
                                children: [
                                  Icon(Icons.phone),
                                  SizedBox(width: 10,),
                                  Text(
                                    vacanciesAnswered.userHR.phone,
                                    style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else{
              return Transform.translate(
                offset: const Offset(10,50),
                child: Container(
                  height: isTablet?400:650,
                  margin: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width - 20,
                  child: Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius:isTablet ? BorderRadius.circular(20): BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: isTablet ? 600 : 300,
                                      width: 600,
                                      decoration: BoxDecoration(
                                        borderRadius:  BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(vacanciesAnswered.userImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset:isTablet? Offset(530,0):Offset(320,15),
                                      child: Column(
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
                                  ] ,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:const EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          vacanciesAnswered.userName,
                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(-100,20),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Vaga',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                          Text(
                                            vacanciesAnswered.titleVacancy,
                                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Divider(
                                    color: AppColors.secondaryColor,
                                  ),
                                  Transform.translate(
                                    offset:const Offset(-100,0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Endereço',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                        Row(
                                          children: [
                                            const Icon(Icons.home),
                                            const SizedBox(width: 10,),
                                            Text(
                                              '${vacanciesAnswered.userHR.address.street},',
                                              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                                            ),const SizedBox(width: 2,),
                                            Text(
                                              '${vacanciesAnswered.userHR.address.district},',
                                              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                                            ),
                                            const SizedBox(width: 2,),
                                            Text(
                                              '${vacanciesAnswered.userHR.address.state}',
                                              style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Divider(

                                    color: AppColors.secondaryColor,

                                  ),
                                  Transform.translate(
                                    offset:const Offset(-100,0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('E-mail',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                        Row(
                                          children: [
                                            Icon(Icons.email),
                                            SizedBox(width: 10,),
                                            Text(
                                              vacanciesAnswered.userHR.email,
                                              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Divider(

                                    color: AppColors.secondaryColor,

                                  ),
                                  Transform.translate(
                                    offset: Offset(-100,0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Telefone',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                        Row(
                                          children: [
                                            Icon(Icons.phone),
                                            SizedBox(width: 10,),
                                            Text(
                                              vacanciesAnswered.userHR.phone,
                                              style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
      },
    );
  }
}
