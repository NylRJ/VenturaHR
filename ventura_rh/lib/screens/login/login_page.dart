import 'package:flutter/material.dart';
import 'package:ventura_rh/screens/login/components/welcome.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/icon_container.dart';

import 'components/login_page_form.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context);
    return Scaffold(

      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height:double.infinity,
          color:  AppColors.textColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Stack(
                children: [
                  Welcome(),
                  Transform.translate(
                      offset: const Offset(145.0, 260.0),
                      child: IconContainer( size:responsive.wp(17),))
                ],

              ),

              LoginPageForm(),


            ],
          ),
        ),
      ),
    );
  }
}
