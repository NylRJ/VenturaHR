import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/input_text.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,

      child: Container(

        constraints: BoxConstraints(
          maxWidth: responsive.isTablet? 430: 360,
        ),
        child: Column(
          children: <Widget>[
            Container(

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
          BoxShadow(
          color: Colors.black26,
          blurRadius: 30,
          offset: Offset(0,10),
        ),
          ]),
              child: Column(
                children: [
                  InputText(
                    sufixIco: Icon(Icons.email,color: Theme.of(context).primaryColor,size:18,),
                    labelText: 'ENDEREÇO DE E-MAIL',
                    keyboardType: TextInputType.emailAddress,
                    borderEnabled: false,
                    fontSize: responsive.dp(responsive.isTablet? 1.2:1.4) ,
                  ),
                  SizedBox(height: responsive.dp(5),),
                  Container(

                      decoration: BoxDecoration(
                        border:Border(
                            bottom: BorderSide(
                                color: Colors.black12
                            )
                        ),

                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: InputText(
                              sufixIco: Icon(Icons.lock,color: Theme.of(context).primaryColor,size:18,),
                              labelText: 'SENHA',
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              borderEnabled: false,
                              fontSize: responsive.dp(responsive.isTablet? 1.2:1.4) ,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            onPressed: (){},
                            child: Text('Esqueceu a senha?',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsive.dp(responsive.isTablet? 1.2:1.5) ,),
                            ),
                          ),
                        ],
                      )),

                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: FlatButton(
                      child: Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white,
                          fontSize:responsive.dp(1.5),
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: (){

                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: responsive.dp(2),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Novo Por Aqui? ',
                  style: TextStyle(
                    fontSize:responsive.dp(1.5),
                  ),
                ),
                FlatButton(
                  onPressed: (){},
                  child: Text(
                      'Inscrever-se',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,fontSize:responsive.dp(1.5),
                      ),
                  ),
                )
              ],
            ),
            SizedBox(height: responsive.dp(10),),
          ],
        ),
      ),
    );
  }
}
