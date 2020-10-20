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
        child: Row(
          children: [
            //Logo
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
            Transform.translate(
              offset: Offset(20,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(vaga.companyTitle,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  SizedBox(height: 1),
                  Text(vaga.titleVacancy),
                  SizedBox(height: responsive.ip(1.2),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.work_outlined),
                      SizedBox(width:responsive.ip(1) ,),
                      Text('${(vaga.numberOfVacancies <=9)?"0${vaga.numberOfVacancies} vagas":"${vaga.numberOfVacancies} vagas"}',style: TextStyle(fontSize: 13),),
                      SizedBox(width:responsive.ip(4),),
                      Icon(Icons.alarm_rounded),
                      SizedBox(width:responsive.ip(0.5) ,),
                      Text('${(vaga.workload <=9)?"0${vaga.workload}h":"${vaga.workload}h"}',style: TextStyle(fontSize: 13)),

                    ],
                  ),
                  SizedBox(height: responsive.ip(2),),
                  Row(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.location_on_outlined),
                      SizedBox(width:3 ,),
                      Text('${vaga.workplace }',style: TextStyle(fontSize: 13)),
                      SizedBox(width:responsive.ip(2.5),),
                      Icon(Icons.edit_location_rounded),
                      SizedBox(width:responsive.ip(0.1) ,),
                      Text('${vaga.address.city}',style: TextStyle(fontSize: 13),),
                       ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

