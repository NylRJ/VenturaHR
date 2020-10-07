import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';

import 'input_text_login.dart';

class LoginPageForm extends StatelessWidget {
  const LoginPageForm({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context);
    return Container(
        width: 330,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
            InputTextLogin(
               iconsPath: 'assets/images/login/icons/email.svg',
               placeHolder: 'Endereço de E-mail'
            ),
            SizedBox(
             height: 20,
           ),
           const InputTextLogin(
               iconsPath: 'assets/images/login/icons/key.svg',
               placeHolder: 'Senha'
           ),
           Container(
             alignment: Alignment.centerRight,
             child: CupertinoButton(
               padding:const EdgeInsets.symmetric(vertical: 15),
               onPressed: (){

               },
               child: const Text(
                   'Esqueceu a senha',
                 style: TextStyle(
                   fontFamily: 'sans',
                     color: Color(0xff4dd0e1)
                 ),
               ),
             ),
           ),
           RoundedButton(
             label: 'Entrar',
               onPressed:(){},
           ),
           SizedBox(
            height: 200,
           ),

         ],
       ),
      );
  }
}
