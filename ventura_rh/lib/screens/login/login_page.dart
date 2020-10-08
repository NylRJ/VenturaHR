import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/icon_container.dart';

import 'components/login_page_form.dart';
import 'components/welcome.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin {
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
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();

        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.textColor,
          child: OrientationBuilder(builder: (_, Orientation orientation) {
            if (orientation == Orientation.portrait) {
              return SingleChildScrollView(
                child: Container(
                  height: responsive.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Welcome(),
                          isTablet ? Transform.translate(
                                offset:  Offset(responsive.wp(42.05), responsive.hp(45)),
                                child: IconContainer( size:responsive.ip(7),)):Transform.translate(
                              offset:  Offset(responsive.wp(35), responsive.hp(32)),
                              child: IconContainer( size:100,)),


                        ],

                      ),

                      LoginPageForm(),

                    ],
                  ),
                ),
              );

            }  else{
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Welcome(),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height:  responsive.height,

                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconContainer( size:responsive.ip(7),),
                                LoginPageForm(),
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }
}
