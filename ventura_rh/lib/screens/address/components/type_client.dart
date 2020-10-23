import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/address/address.dart';
import 'package:ventura_rh/models/users/user.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/screens/login/components/input_text_login.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';

class TypeClient extends StatefulWidget {

  final Address address;

  const TypeClient({Key key, this.address}) : super(key: key);
  @override
  _TypeClientState createState() => _TypeClientState();
}

class _TypeClientState extends State<TypeClient> {
  final cpfC = TextEditingController();

  final razaoC = TextEditingController();

  final cnpjC = TextEditingController();

  String valueSelected = 'fisica';


  Widget subForm(
      UserManager userManager, Responsive responsive, String valueSelected,TextEditingController cpfC, TextEditingController razaoC,TextEditingController cnpjC,) {
    if (valueSelected == 'juridica') {
      return Form(
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: razaoC,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Razão Social',
                    hintText: 'Nunbank'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: (razao) {
                  if (razao.isEmpty) {
                    return 'Campo Obrigatorio';
                  } else if (razao.length != 10) {
                    return 'Campo Invalido';
                  } else {
                    return null;
                  }
                },

              ),
              SizedBox(
                height: responsive.ip(1),
              ),
              TextFormField(
                controller: cnpjC,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'CNPJ',
                    hintText: '12.345.664-52/0011'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: (cnpj) {
                  if (cnpj.isEmpty) {
                    return 'Campo Obrigatorio';
                  } else if (cnpj.length != 10) {
                    return 'Campo Invalido';
                  } else {
                    return null;
                  }
                },

              ),
            ],
          ),
        ),
      );
    } else {
      return Form(
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: cpfC,
                decoration: const InputDecoration(
                    isDense: true, labelText: 'CPF', hintText: '12.345.664-52'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: (cpf) {
                  if (cpf.isEmpty) {
                    return 'Campo Obrigatorio';
                  } else if (cpf.length <10  && cpf.length < 11) {
                    return 'Campo Invalido';
                  } else {
                    return null;
                  }
                },

              ),
              SizedBox(
                height: responsive.ip(1),
              ),
            ],
          ),
        ),
      );
    }
  }

  _submit(UserManager userManager, String valueSelected, String cpf ,String cnpj, String razao ) {
    if (valueSelected == 'juridica') {
        UserHR userHR = UserHR.company(
          name: userManager.userHR.name,
          email: userManager.userHR.email,
          password: userManager.userHR.password,
          phone: userManager.userHR.phone,
          cnpj: cnpj,
          razaoSocial: razao,
          address: userManager.address,
        );
        print('User: $userHR');

    } else if (valueSelected == 'fisica') {

        UserHR userHR = UserHR.candidate(
          name: userManager.userHR.name,
          email: userManager.userHR.email,
          password: userManager.userHR.password,
          phone: userManager.userHR.phone,
          cpf: cpf,
          address: userManager.address,
        );
        print('User: $userHR');

    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    if (widget.address.zipCode != null) {
      return Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            children: [
              Row(
                children: [
                  const Text('Candidato'),
                  Radio(
                      value: 'fisica',
                      groupValue: valueSelected,
                      onChanged: (String value) {
                        setState(() {
                          valueSelected = value;
                        });
                      }),
                  const Text('Empresa'),
                  Radio(
                      value: 'juridica',
                      groupValue: valueSelected,
                      onChanged: (String value) {
                        setState(() {
                          valueSelected = value;
                        });
                      }),
                ],
              ),
              subForm(userManager, responsive, valueSelected,cpfC,razaoC,cnpjC),
              const SizedBox(
                height: 8,
              ),
              RoundedButton(
                label: 'Finalizar',
                backgroundColor: AppColors.primaryColor,
                disableColor: AppColors.primaryColor.withAlpha(100),
                onPressed: () {
                  if (Form.of(context).validate()) {
                    print(' finalizar: ${cpfC.text}');
                    print(' finalizar: ${widget.address}');

                    _submit(userManager, valueSelected,cpfC.text,cnpjC.text,razaoC.text);
                  }
                },
              ),
            ],
          );
        },
      );
    }else{
      return Container();
    }
  }
}
