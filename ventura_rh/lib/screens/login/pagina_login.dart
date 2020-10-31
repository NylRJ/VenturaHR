import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ventura_rh/helpers/validators.dart';
import 'package:ventura_rh/models/users/user.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class PaginaLogin extends StatefulWidget {


  const PaginaLogin({Key key}) : super(key: key);
  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController emailController =TextEditingController();
  TextEditingController passController =TextEditingController();





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Colors.white,
      body:Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [

                TextFormField(
                  controller: emailController,
                  decoration:  InputDecoration(
                      suffix: Icon(Icons.check_circle,color:(true)?Colors.green:Colors.grey,),
                      hintText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email){
                    if (!emailValid(email)) {
                      debugPrint('Invalido');
                      return 'E-mail Invalido!';

                    }

                    debugPrint('valido');
                    return null;
                  },

                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: passController,
                  decoration:  InputDecoration(
                      suffix: Icon(Icons.check_circle,),
                      hintText: 'Senha'
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  obscureText: true,
                  validator: (pass){
                    if (pass.isEmpty || pass.length <6) {
                      return 'Senha Invalida!';
                    }
                    return null;
                  },

                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    padding:  EdgeInsets.symmetric(vertical: 15 ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/base');
                    },
                    child:  Text(
                      'Esqueceu a senha',
                      style:
                      TextStyle(fontFamily: 'sans', color: Color(0xff4dd0e1)),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                RoundedButton(
                  label: 'Entrar',
                  backgroundColor: AppColors.secondaryColor,
                  onPressed: (){

                    if (formkey.currentState.validate()) {

                        context.read<UserManager>().signIn(
                            user:UserHR(email: emailController.text,password: passController.text),
                            onSuccess: (){
                              Navigator.pushNamed(context, '/base');

                            },
                          onFail: (e){
                              print(e);
                          },
                        );

                    }

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
