import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ventura_rh/helpers/validators.dart';
import 'package:ventura_rh/models/users/user.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/dialogs.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/circle_button.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';
import 'input_text_login.dart';
import 'package:provider/provider.dart';

class LoginPageForm extends StatefulWidget {
  final VoidCallback onGoToRegister, onGoToForgotPassword;

  LoginPageForm(
      {Key key,
        @required this.onGoToRegister,
        @required this.onGoToForgotPassword})
      : super(key: key);

  @override
  _LoginPageFormState createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  final GlobalKey<InputTextLoginState> _emailKey =
  GlobalKey<InputTextLoginState>();

  final GlobalKey<InputTextLoginState> _passKey =
  GlobalKey<InputTextLoginState>();


  @override
  Widget build(BuildContext context) {

    _submit() {
      final userName = _emailKey.currentState.value;
      final pass = _passKey.currentState.value;

      final userNameOk = _emailKey.currentState.isOk;
      final passOk = _passKey.currentState.isOk;
      if (userNameOk && passOk) {
        context.read<UserManager>().signin(
            user: User(
                email: userName,
                password: pass,
              ),
            onSuccess: (){
              Navigator.pushNamed(context, '/base');
            },
            onFail: (e){
              final snac =   SnackBar(content: Text('Falha ao entrar $e',style: TextStyle(color: Colors.white),),
                backgroundColor: AppColors.primaryColor,
              );
              Scaffold.of(context).showSnackBar(snac);
            }

        );
      }else{
        Dialogs.alert(context, description: 'alguns campos são inválidos',title: 'ok2');
      }
    }


    final Responsive responsive = Responsive.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: Container(
          width: 330,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTextLogin(
                key: _emailKey,
                initValue: 'moises.souza@gmail',
                iconPath: 'assets/images/login/icons/email.svg',
                placeholder: 'Endereço de E-mail',
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
                placeholder: 'Senha',
                validator: (pass) {
                  if (pass.isEmpty || pass.trim().length < 6) {
                    return false;
                  }
                  return true;
                },
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  onPressed: widget.onGoToForgotPassword,
                  child: Text(
                    'Esqueceu a senha',
                    style:
                    TextStyle(fontFamily: 'sans', color: Color(0xff4dd0e1)),
                  ),
                ),
              ),
              SizedBox(
                height: responsive.ip(0.2),
              ),
              RoundedButton(

                onPressed: _submit,

                label: 'Entrar',
                backgroundColor: AppColors.button,
              ),
              SizedBox(
                height: responsive.ip(0.2),
              ),
              Text(
                'ou continue com',
                style: TextStyle(
                    fontFamily: 'sans', color: AppColors.secondaryColor),
              ),
              SizedBox(
                height: responsive.ip(1),
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
                    width: responsive.wp(3),
                  ),
                  CircleButton(
                    size: 55,
                    iconPath: 'assets/images/rede_social/google.svg',
                    backgroundColor: Color(0xffFF1744),
                  ),
                ],
              ),
              SizedBox(
                height: responsive.ip(0.5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Não tem conta?'),
                  SizedBox(
                    width: 10,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    onPressed: widget.onGoToRegister,
                    child: Text(
                      'Inscrever-se',
                      style: TextStyle(
                          fontFamily: 'sans',
                          color: Color(0xff4dd0e1),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
