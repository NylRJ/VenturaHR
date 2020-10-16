import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/helpers/validators.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/dialogs.dart';
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

  final GlobalKey<InputTextLoginState> _namelKey =
  GlobalKey<InputTextLoginState>();

  final GlobalKey<InputTextLoginState> _emailKey =
  GlobalKey<InputTextLoginState>();

  final GlobalKey<InputTextLoginState> _passKey =
  GlobalKey<InputTextLoginState>();

  final GlobalKey<InputTextLoginState> _passConfirKey =
  GlobalKey<InputTextLoginState>();

  _submit() {
    final userName = _namelKey.currentState.value;
    final email = _emailKey.currentState.value;
    final pass = _passKey.currentState.value;
    final passConfirm = _passConfirKey.currentState.value;

    final userNameOk = _namelKey.currentState.isOk;
    final emailOk = _emailKey.currentState.isOk;
    final passOk = _passKey.currentState.isOk;
    final passConfirmOk = _passConfirKey.currentState.isOk;
    if (userNameOk && emailOk && passOk && passConfirmOk) {
      if (_agree) {
      } else {}
    } else {
      Dialogs.alert(context, description: 'alguns campos são inválidos',title: 'Sair');
    }
  }




  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                      Consumer<UserManager>(
                        builder: (_,userManager,child){
                          return                 Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            constraints: BoxConstraints(maxWidth: 400),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Nova Conta",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 25,
                                      fontFamily: 'raleway',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: responsive.ip(1),
                                ),
                                InputTextLogin(
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
                                  iconPath: 'assets/images/login/icons/key.svg',
                                  placeholder: "Password",
                                  enable: !userManager.loading,
                                  obscureText: true,
                                  validator: (text) {
                                    return text.trim().length >= 6;
                                  },
                                ),
                                SizedBox(
                                  height: responsive.ip(2),
                                ),
                                InputTextLogin(
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
                                Container(
                                  height: 78,
                                  child: Column(
                                    children: [
                                      DefaultTextStyle(
                                        style: TextStyle(
                                            fontSize: responsive.ip(1.3),
                                            color: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                .color),
                                        child: Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: <Widget>[
                                            Checkbox(
                                              value: _agree,
                                              onChanged: (isChecked) {
                                                setState(() {
                                                  _agree = isChecked;
                                                });
                                              },
                                            ),
                                            Text("Estou de acordo com "),
                                            InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "Termos de serviços",
                                                style: TextStyle(
                                                    color: AppColors.primaryColor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Text(" & "),
                                            InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "Política de Privacidade",
                                                style: TextStyle(
                                                    color: AppColors.primaryColor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: responsive.ip(0.1),
                                ),
                                Row(
                                  children: [
                                    FlatButton(
                                        onPressed: widget.onGoToLogin,
                                        child: Text('← Voltar')),
                                    RoundedButton(
                                      label: 'Inscrever-se',
                                      backgroundColor: AppColors.button,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: responsive.ip(0.1),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}