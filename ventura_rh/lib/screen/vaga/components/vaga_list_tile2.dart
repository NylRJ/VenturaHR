import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';

class VagaListTile2 extends StatelessWidget {
  final Vaga vaga;

  final bool isTablet;

  const VagaListTile2({
    Key key,
    this.vaga,
    this.isTablet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);


    return Consumer<UserManager>(
      builder: (_,userManager,__){
        return GestureDetector(
          onTap: userManager.isLoggedIn
              ? () {
            Navigator.of(context)
                .pushNamed('/vagasRespondidas', arguments:vaga);
          }
              : () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content:const Text(
                  'Cadastre-se ou Entre Para Visualizar Os Detalhes das Vagas',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: AppColors.secondaryColor,
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(4),
            child: Material(
              elevation: 14.0,
              borderRadius:
              isTablet ? BorderRadius.circular(40) : BorderRadius.circular(24),
              child: Transform.translate(
                offset: isTablet ? const Offset(40, 0.0) : const Offset(5.0, 0.0),
                child: Row(
                  children: [
                    //Logo
                    Material(
                      elevation: isTablet ? 14 : 10.0,
                      borderRadius: isTablet
                          ? BorderRadius.circular(79)
                          : BorderRadius.circular(60),
                      child: Container(
                        width: isTablet ? 160 : 120,
                        height: isTablet ? 160 : 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(vaga.images.first),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    Transform.translate(
                      offset:
                      isTablet ? const Offset(20, 20) : const Offset(10, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            vaga.companyTitle,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 1),
                          Text(vaga.titleVacancy),
                          SizedBox(
                            height: responsive.ip(1.2),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.work_outlined),
                              SizedBox(
                                width: responsive.ip(1),
                              ),
                              Text(
                                '${(vaga.numberOfVacancies <= 9) ? "0${vaga.numberOfVacancies} vagas" : "${vaga.numberOfVacancies} vagas"}',
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(
                                width: responsive.ip(4),
                              ),
                              Icon(Icons.alarm_rounded),
                              SizedBox(
                                width: responsive.ip(0.5),
                              ),
                              Text(
                                  '${(vaga.workload <= 9) ? "0${vaga.workload}h" : "${vaga.workload}h"}',
                                  style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          SizedBox(
                            height: responsive.ip(2),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.location_on_outlined),
                              SizedBox(
                                width: 3,
                              ),
                              Text('${vaga.workplace}',
                                  style: TextStyle(fontSize: 13)),
                              SizedBox(
                                width: responsive.ip(2.5),
                              ),
                              Icon(Icons.edit_location_rounded),
                              SizedBox(
                                width: responsive.ip(0.1),
                              ),
                              Text(
                                '${vaga.address.city}',
                                style: TextStyle(fontSize: 13),
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
          ),
        );
      },
    );
  }
}