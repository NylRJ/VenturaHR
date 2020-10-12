import 'package:flutter/material.dart';
import 'package:ventura_rh/helpers/validators.dart';
import 'package:ventura_rh/screens/login/components/welcome.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';
import 'input_text_login.dart';

class ForgotPasswordForm extends StatefulWidget {
  final VoidCallback onGoToLogin;
  final Alignment alignment;
  const ForgotPasswordForm(
      {Key key,
        @required this.onGoToLogin,
        this.alignment = Alignment.bottomCenter})
      : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool _agree = false;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Align(
      alignment: Alignment.center ,
      child: SafeArea(
          top: false,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();

            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              constraints: BoxConstraints(
                maxWidth: 400
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Redefinir Senha",
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
                          iconPath: 'assets/images/login/icons/email.svg',
                          placeholder: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validator: (email){
                            if (!emailValid(email)) {

                              return false;

                            }

                            return true;
                          },
                        ),
                        SizedBox(
                          height: responsive.ip(1),
                        ),

                        Row(
                          children: [
                            FlatButton(
                                onPressed: widget.onGoToLogin ,
                                child: Text('← Voltar')),
                            RoundedButton(
                              label: 'Enviar',
                              backgroundColor: AppColors.button,
                              onPressed: (){},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: responsive.ip(0.1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
}
