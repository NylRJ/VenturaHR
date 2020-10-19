import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';

import 'component/tabela_criterio.dart';

class VagaDetails extends StatelessWidget {
  const VagaDetails(this.vaga);

  final Vaga vaga;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    print(vaga.criterio[1].pmd);
    //1º alternativa descartada
    //2º foi mapear dentro da propia tabela

    // String  name = vaga.criterio.map((e) => e.name).toString();
    // String  description = vaga.criterio.map((e) => e.description).toString();
    // String  pmd = vaga.criterio.map((e) => e.pmd).toString();
    // String  peso = vaga.criterio.map((e) => e.weight).toString();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(vaga.companyTitle),
        centerTitle: true,
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
                  image: NetworkImage(vaga.image),
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

              TabelaCriterio(vaga: vaga,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
