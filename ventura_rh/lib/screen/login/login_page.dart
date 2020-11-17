import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/icon_container.dart';

import 'components/forgot_password_form.dart';
import 'components/login_page_form.dart';
import 'components/register_form.dart';
import 'components/welcome.dart';

class LoginFormType {
  static final int login = 0;

  static final int register = 1;

  static final int forgotPassword = 2;
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin {
  final PageController _pageController =
      PageController(initialPage: LoginFormType.login);

  @override
  void afterFirstLayout(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    if (!isTablet) {
      //Se estiver no SmartPhone Blouqeio a rotação do dispositivo
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _switchForm(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  Widget _getForm(){
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        LoginPageForm(
          onGoToForgotPassword: (){
            _switchForm(LoginFormType.forgotPassword);
          }  ,
          onGoToRegister: () {
            _switchForm(LoginFormType.register);
          },
        ),
        RegisterForm(
          onGoToLogin: () {
            _switchForm(LoginFormType.login);
          },
        ),
        ForgotPasswordForm(
          onGoToLogin: (){
            _switchForm(LoginFormType.login);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final bool isPortrait = responsive.width < responsive.height;
    final bool _isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,

          child: OrientationBuilder(builder: (_, Orientation orientation) {
            if (isPortrait) {
              return SingleChildScrollView(
                child: Container(
                  height: responsive.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Welcome(),

                            if (_isTablet)
                              Transform.translate(
                                  offset: Offset(
                                      responsive.wp(38.05), responsive.hp(35)),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 80,
                                        child: IconContainer(
                                          size: responsive.ip(6),
                                        ),
                                      ),

                                    ],
                                  ),
                              )
                            else
                              Transform.translate(
                                  offset: Offset(
                                      responsive.wp(35), responsive.hp(30.5)),
                                child: Column(
                                  children: [
                                    IconContainer(
                                      size: responsive.ip(7),
                                    ),


                                  ],
                                ),
                              ),

                          ],
                        ),
                      ),

                      Expanded(
                        child: _getForm(),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                     //TODO: physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        height: responsive.height,
                        child:  Center(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 100,),
                                  IconContainer(
                                    size: responsive.ip(7),
                                  ),
                                  SizedBox(height: 20,),
                                  Welcome(),
                                ],
                              )


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: responsive.height,
                        child: Wrap(
                          children: [
                            Center(
                                child: LimitedBox(
                                  maxHeight: responsive.height -10,
                                  child: Expanded(child: _getForm()),
                                ))
                          ],
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
