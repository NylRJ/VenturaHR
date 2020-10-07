import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/circle_button.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';

import 'input_text_login.dart';

class LoginPageForm extends StatelessWidget {
  const LoginPageForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      top: false,
      child: Container(
        width: 330,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputTextLogin(
                iconsPath: 'assets/images/login/icons/email.svg',
                placeHolder: 'Endereço de E-mail'),
            SizedBox(
              height: 20,
            ),
            const InputTextLogin(
                iconsPath: 'assets/images/login/icons/key.svg',
                placeHolder: 'Senha'),
            Container(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 15 ),
                onPressed: () {},
                child: const Text(
                  'Esqueceu a senha',
                  style:
                      TextStyle(fontFamily: 'sans', color: Color(0xff4dd0e1)),
                ),
              ),
            ),
            RoundedButton(
              onPressed: () {},
              label: 'Entrar',
              backgroundColor: AppColors.button,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'ou continue com',
              style: TextStyle(
                  fontFamily: 'sans', color: AppColors.secondaryColor),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleButton(
                  size: 55,
                  iconPath: 'assets/images/rede_social/facebook.svg',
                  backgroundColor: Color(0xff448AFF),
                ),
                SizedBox(
                  width: 20,
                ),
                CircleButton(
                  size: 55,
                  iconPath: 'assets/images/rede_social/google.svg',
                  backgroundColor: Color(0xffFF1744),
                ),
              ],
            ),
            SizedBox(width: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Não tem conta?'),
                SizedBox(width: 10,),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  onPressed: () {},
                  child: const Text(
                    'Inscrever-se',
                    style:
                    TextStyle(fontFamily: 'sans', color: Color(0xff4dd0e1),fontWeight:FontWeight.w800 ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
