import 'package:flutter/material.dart';
import 'package:ventura_rh/screens/login/components/welcome.dart';

import 'components/login_page_form.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xffeeeeee),
      body: Container(
        width: double.infinity,
        height:double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Welcome(),
            LoginPageForm(),
          ],
        ),
      ),
    );
  }
}
