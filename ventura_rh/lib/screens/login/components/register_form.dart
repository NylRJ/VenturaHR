import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/helpers/validators.dart';
import 'package:ventura_rh/models/users/user.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';

import 'input_text_login.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onGoToLogin;
  final Alignment alignment;

  const RegisterForm(
      {Key key,
        @required this.onGoToLogin,
        this.alignment = Alignment.bottomCenter})
      : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _agree = false;

  final GlobalKey<InputTextLoginState> _nameKey =
  GlobalKey<InputTextLoginState>();

  final GlobalKey<InputTextLoginState> _emailKey =
  GlobalKey<InputTextLoginState>();

  final GlobalKey<InputTextLoginState> _passKey =
  GlobalKey<InputTextLoginState>();

  final GlobalKey<InputTextLoginState> _passConfirKey =
  GlobalKey<InputTextLoginState>();

  final GlobalKey<InputTextLoginState> _callKey =
  GlobalKey<InputTextLoginState>();
  String radioSelected ;



  _buscarCEP(UserManager userManager) {
    final userName = _nameKey.currentState.value;
    final email = _emailKey.currentState.value;
    final pass = _passKey.currentState.value;
    final passConfirm = _passConfirKey.currentState.value;
    final call = _callKey.currentState.value;



    final userNameOk = _nameKey.currentState.isOk;
    final emailOk = _emailKey.currentState.isOk;
    final passOk = _passKey.currentState.isOk;
    final passConfirmOk = _passConfirKey.currentState.isOk;
    final callok = _callKey.currentState.isOk;




    if (userNameOk && emailOk && passOk && passConfirmOk  && callok) {
      if (pass == passConfirm) {

        UserHR userHR = UserHR.createCep(email: email,password: pass,name:userName,phone: call );
        userManager.userHR = userHR;
        Navigator.popAndPushNamed(context, '/address', arguments: userHR);
//        Navigator.pushNamed(context, '/base');
      } else {
        final snac = SnackBar(
          content: const Text(
            'A senha não confere',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primaryColor,
        );
        Scaffold.of(context).showSnackBar(snac);
      }
    } else {
      final snac = SnackBar(
        content: const Text(
          'alguns campos são inválidos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
      );
      Scaffold.of(context).showSnackBar(snac);

    }

  }



  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);


    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        bottom: true,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Consumer<UserManager>(
            builder: (_,userManager,child){
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  constraints: BoxConstraints(maxWidth: 400),
                  child: LimitedBox(

                    maxHeight: responsive.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Nova Conta",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 24,
                              fontFamily: 'raleway',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: responsive.ip(1),
                        ),
                        InputTextLogin(
                          key: _nameKey,
                          iconPath: 'assets/images/login/icons/avatar.svg',
                          placeholder: "Username",
                          enable: !userManager.loading,
                          validator: (text) {
                            return text.trim().length > 0;
                          },
                        ),
                        SizedBox(
                          height: responsive.ip(1),
                        ),
                        InputTextLogin(
                          key: _emailKey,
                          iconPath: 'assets/images/login/icons/email.svg',
                          placeholder: "Email Address",
                          enable: !userManager.loading,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (!emailValid(email)) {
                              return false;
                            }

                            return true;
                          },
                        ),
                        SizedBox(
                          height: responsive.ip(1),
                        ),
                        InputTextLogin(
                          key: _passKey,
                          iconPath: 'assets/images/login/icons/key.svg',
                          placeholder: "Password",
                          enable: !userManager.loading,
                          obscureText: true,
                          validator: (text) {
                            return text.trim().length >= 6;
                          },
                        ),
                        SizedBox(
                          height: responsive.ip(1),
                        ),
                        InputTextLogin(
                          key: _passConfirKey,
                          iconPath: 'assets/images/login/icons/key.svg',
                          placeholder: "Confirm Password",
                          enable: !userManager.loading,
                          obscureText: true,
                          validator: (text) {
                            return text.trim().length >= 6;
                          },
                        ),
                        SizedBox(
                          height: responsive.ip(0.1),
                        ),
                        InputTextLogin(
                          key: _callKey,
                          iconPath: 'assets/images/login/icons/call.svg',
                          placeholder: "Telefone",
                          enable: !userManager.loading,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          validator: (text) {
                            return text.trim().length >= 6;
                          },
                        ),
                        Row(
                          children: [
                            FlatButton(
                                onPressed: widget.onGoToLogin,
                                child: Text('← Voltar')),
                            RoundedButton(
                              label: 'Continuar',
                              backgroundColor: AppColors.primaryColor,
                              disableColor:AppColors.primaryColor.withAlpha(100) ,
                              onPressed: (){
                                _buscarCEP(userManager);
                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}