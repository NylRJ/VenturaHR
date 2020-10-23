import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/address/address.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';

class AddressRegisterInputField extends StatefulWidget {
  final Address address;

  const AddressRegisterInputField({Key key, this.address}) : super(key: key);

  @override
  _AddressRegisterInputFieldState createState() =>
      _AddressRegisterInputFieldState();
}

_submit(UserManager userManager, String valueSelected, Address address,BuildContext context) {
  if (valueSelected == 'juridica') {
    UserHR userHR = UserHR.company(
      name: userManager.userHR.name,
      email: userManager.userHR.email,
      password: userManager.userHR.password,
      phone: userManager.userHR.phone,
      cnpj: userManager.userHR.cnpj,
      razaoSocial: userManager.userHR.razaoSocial,
      address: address,
    );
    userManager.signUp(
        user: userHR,
        onSuccess: () {
          Navigator.of(context).pushNamed('/home');

        },
        onFail: (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Falha ao cadastrar: $e'),
            backgroundColor: Colors.red,
          ));
        }

    );
    // print('User: $userHR');

  } else if (valueSelected == 'fisica') {
    UserHR userHR = UserHR.candidate(
      name: userManager.userHR.name,
      email: userManager.userHR.email,
      password: userManager.userHR.password,
      phone: userManager.userHR.phone,
      cpf: userManager.userHR.cpf,
      address: address,
    );

    userManager.signUp(
        user: userHR,
        onSuccess: () {
          Navigator.of(context).pushNamed('/home');

        },
        onFail: (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Falha ao cadastrar: $e'),
            backgroundColor: Colors.red,
          ));
        }

        );
  }
}

Widget subForm(
    UserManager userManager, Responsive responsive, String valueSelected) {
  if (valueSelected == 'juridica') {
    return Container(
      child: Column(
        children: [
          TextFormField(
            enabled: !userManager.loading,
            decoration: const InputDecoration(
                isDense: true, labelText: 'Razão Social', hintText: 'Nunbank'),

            keyboardType: TextInputType.name,
            validator: (razao) {
              if (razao.isEmpty) {
                return 'Campo Obrigatorio';
              } else if (razao.length <3) {
                return 'Campo Invalido';
              } else {
                return null;
              }
            },
            onSaved: (t) => userManager.userHR.razaoSocial = t,
          ),
          SizedBox(
            height: responsive.ip(1),
          ),
          TextFormField(
            enabled: !userManager.loading,
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
              } else if (cnpj.length <3 && cnpj.length > 11) {
                return 'Campo Invalido';
              } else {
                return null;
              }
            },
            onSaved: (t) => userManager.userHR..cnpj = t,
          ),
        ],
      ),
    );
  } else {
    return Container(
      child: Column(
        children: [
          TextFormField(
            enabled: !userManager.loading,
            decoration: const InputDecoration(
                isDense: true, labelText: 'CPF', hintText: '12.345.664-52'),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            validator: (cpf) {
              if (cpf.isEmpty) {
                return 'Campo Obrigatorio';
              } else if (cpf.length < 10 && cpf.length < 11) {
                return 'Campo Invalido';
              } else {
                return null;
              }
            },
            onSaved: (t) => userManager.userHR.cpf = t,
          ),
          SizedBox(
            height: responsive.ip(1),
          ),
        ],
      ),
    );
  }
}

class _AddressRegisterInputFieldState extends State<AddressRegisterInputField> {
  String valueSelected = 'fisica';

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    String emptyValidator(String text) {
      text.isEmpty ? 'Campo Obrigatorio' : null;
    }

    if (widget.address.zipCode != null) {
      return Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            children: [
              TextFormField(
                enabled: !userManager.loading,
                initialValue: widget.address.street,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: "Rua/Avenida",
                    hintText: 'Av. Brasil'),
                validator: emptyValidator,
                onSaved: (t) => widget.address.street = t,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: !userManager.loading,
                      initialValue: widget.address.number,
                      decoration: const InputDecoration(
                          isDense: true, labelText: "Número", hintText: '123'),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.name,
                      validator: emptyValidator,
                      onSaved: (t) => widget.address.number = t,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      enabled: !userManager.loading,
                      initialValue: widget.address.complement,
                      decoration: const InputDecoration(
                          isDense: true,
                          labelText: "Complemento",
                          hintText: 'Opcional'),
                      validator: emptyValidator,
                      onSaved: (t) => widget.address.complement = t,
                    ),
                  ),
                ],
              ),
              TextFormField(
                enabled: !userManager.loading,
                initialValue: widget.address.district,
                decoration: const InputDecoration(
                    isDense: true, labelText: "Bairro", hintText: 'Barra'),
                validator: emptyValidator,
                onSaved: (t) => widget.address.district = t,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      enabled: !userManager.loading,
                      initialValue: widget.address.city,
                      decoration: const InputDecoration(
                          isDense: true,
                          labelText: "Cidade",
                          hintText: 'Rio de Janeiro'),
                      validator: emptyValidator,
                      onSaved: (t) => widget.address.city = t,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      autocorrect: false,
                      enabled: !userManager.loading,
                      textCapitalization: TextCapitalization.characters,
                      initialValue: widget.address.state,
                      decoration: const InputDecoration(
                          isDense: true,
                          labelText: "UF",
                          hintText: 'RJ',
                          counterText: ''),
                      maxLength: 2,
                      validator: (e) {
                        if (e.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (e.length != 2) {
                          return 'Inválido';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (t) => widget.address.state = t,
                    ),
                  )
                ],
              ),
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
              subForm(userManager, responsive, valueSelected),
              const SizedBox(
                height: 8,
              ),
              if (userManager.loading)
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    AppColors.primaryColor,
                  ),
                  backgroundColor: AppColors.secondaryDarker,
                ),
              RoundedButton(
                label: 'Finalizar',
                backgroundColor: AppColors.primaryColor,
                disableColor: AppColors.primaryColor.withAlpha(100),
                onPressed: userManager.loading
                    ? null
                    : () {
                        if (Form.of(context).validate()) {
                          Form.of(context).save();

                          print(userManager.userHR);
                          _submit(userManager, valueSelected, widget.address,context);
                        }
                      },
              ),
            ],
          );
        },
      );
    } else {
      return Container();
    }
  }
}
