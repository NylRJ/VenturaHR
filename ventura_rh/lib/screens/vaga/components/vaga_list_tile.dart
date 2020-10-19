import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/utils/responsive.dart';

class VagaListTile extends StatelessWidget {
  final Vaga vaga ;

  const VagaListTile({Key key, this.vaga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/vagaDetails',arguments: vaga);
      },
      child: Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),

      ),
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(8),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color(0xfffcfcfc),
            boxShadow: [
              BoxShadow(
                color: const Color(0x33000000),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [

              Container(
                width: responsive.ip(15),
                height: responsive.ip(12),
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                    image: NetworkImage(vaga.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(vaga.companyTitle,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                    SizedBox(height: responsive.ip(0.1),),
                    Text(vaga.titleVacancy),
                    SizedBox(height: responsive.ip(1.2),),
                    Row(

                      children: [
                        Row(

                          children: [
                            Icon(Icons.work_outlined),
                            SizedBox(width:responsive.ip(1) ,),
                            Text('${(vaga.numberOfVacancies <=9)?"0${vaga.numberOfVacancies} vagas":"${vaga.numberOfVacancies} vagas"}',style: TextStyle(fontSize: 13),),


                          ],
                        ),
                        SizedBox(width:responsive.ip(4),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.alarm_rounded),
                            SizedBox(width:responsive.ip(0.5) ,),
                            Text('${(vaga.workload <=9)?"0${vaga.workload}h":"${vaga.workload}h"}',style: TextStyle(fontSize: 13)),
                          ],
                        ),


                      ],
                    ),
                    SizedBox(height: responsive.ip(2),),
                    Row(
                      children: [
                        Row(

                          children: [
                            Icon(Icons.location_on_outlined),
                            SizedBox(width:3 ,),
                            Text('${vaga.workplace }',style: TextStyle(fontSize: 13)),


                          ],
                        ),
                        SizedBox(width:responsive.ip(2.5),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.edit_location_rounded),
                            SizedBox(width:responsive.ip(0.1) ,),
                            Text('${vaga.address.city}',style: TextStyle(fontSize: 13),),
                          ],
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
}

