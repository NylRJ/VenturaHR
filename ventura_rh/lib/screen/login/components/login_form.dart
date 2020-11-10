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
    final Color primaryColor = Theme.of(context).primaryColor;

    return Positioned(
      bottom: 30,

      child: Container(

        constraints: BoxConstraints(
          //maxWidth: responsive.isTablet? 430: 360,
        ),
        child: Column(
          children: <Widget>[
            Container(

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
           const BoxShadow(color: Colors.black26, blurRadius: 30, offset: Offset(0,10),),
          ]),
              child: Column(
                children: [
                  InputText(
                    sufixIco: Icon(Icons.email,color: Theme.of(context).primaryColor,size:18,),
                    labelText: 'ENDEREÇO DE E-MAIL',
                    keyboardType: TextInputType.emailAddress,

                    //fontSize: responsive.dp(responsive.isTablet? 1.2:1.4) ,
                  ),
                  SizedBox(height: responsive.ip(5),),
                  Container(

                      decoration: const BoxDecoration(
                        border:Border(
                            bottom: BorderSide(
                                color: Colors.black12
                            )
                        ),

                      ),
                      child: Row(
                        children: <Widget>[
                          //TODO: mudando inputText para textFormFild
                          Expanded(
                            child: TextFormField(
                              decoration:  InputDecoration(
                                icon: Icon(Icons.lock,size:18,color: primaryColor,),
                                hintText: 'SENHA',
                                enabledBorder: InputBorder.none,
                              ),
                             
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,

                              
                              validator: (pass){
                                if(pass.isEmpty || pass.length <6){
                                  return'Senha Invalida';
                                }else{
                                  return null;
                                }
                              },
 
                            ),
                          ),
                          FlatButton(
                            padding:const EdgeInsets.symmetric(horizontal: 10),
                            onPressed: (){},
                            child: Text('Esqueceu a senha?',
                              //style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsive.ip(responsive.isTablet? 1.2:1.5) ,),
                            ),
                          ),
                        ],
                      )),
                  //botao entrar
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: (){

                      },
                      child: Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white,
                          fontSize:responsive.ip(1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: responsive.ip(2),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Novo Por Aqui? ',
                  style: TextStyle(
                    fontSize:responsive.ip(1.5),
                  ),
                ),
                FlatButton(
                  onPressed: (){},
                  child: Text(
                      'Inscrever-se',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,fontSize:responsive.ip(1.5),
                      ),
                  ),
                )
              ],
            ),
            SizedBox(height: responsive.ip(10),),
          ],
        ),
      ),
    );
  }
}
