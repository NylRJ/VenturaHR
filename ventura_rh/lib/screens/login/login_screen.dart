import 'package:flutter/material.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/circle.dart';
import 'package:ventura_rh/widgets/icon_container.dart';

import 'components/login_form.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    final double pinkSize = responsive.wp(80);
    final double orangeSize = responsive.wp(57);

    print('orangeSize = $orangeSize');
    print('pinkSize = $pinkSize');


    return Scaffold(
        key: scaffoldKey,

        body:GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              width: responsive.width,
              height: responsive.height,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  Positioned(
                    top:   -pinkSize * 0.4,
                    right: -pinkSize * 0.2,
                    child: Circle(
                      size: pinkSize,
                      colors:[
                        Colors.cyan,
                        Colors.grey[300]
                      ],
                    ),
                  ),
                  Positioned(
                    top: -orangeSize * 0.55,
                    left:-orangeSize * 0.15,
                    child: Circle(
                      size: orangeSize,
                      colors:[
                        Colors.black,
                        Colors.cyan,
                      ],
                    ),
                  ),
                  Positioned(
                    top: pinkSize * 0.35,

                    child: Column(
                      children: <Widget>[
                        IconContainer(
                          size:responsive.wp(17),
                        ),
                        SizedBox(
                          height: responsive.wp(3),
                        ),
                        Text(
                          'Conectando as Melhores Empresas a Você.\n E Você as Melhores \n Empresas!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: responsive.dp(1.6),
                          ) ,)
                      ],
                    ),),
                  Container(

                    child: LoginForm(),
                  ),


                ],
              ),
            ),
          ),
        )
    );
  }
}


