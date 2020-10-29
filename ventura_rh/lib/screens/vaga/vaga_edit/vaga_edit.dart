import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/screens/vaga/vaga_edit/components/images_form_user.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';

import 'components/criterio_form.dart';
import 'components/images_form.dart';

class VagaEdit extends StatelessWidget {
  final Vaga vaga;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  VagaEdit(this.vaga);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Editar Vaga'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            ImagesForm(
              vaga: vaga,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Divider(

                    indent: 10,
                    height: 10,
                    thickness: 2,
                    color: AppColors.primaryColor,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextFormField(
                      initialValue: vaga.titleVacancy,
                      decoration: const InputDecoration(
                        hintText: 'Titulo Vaga',
                        labelText: 'Titulo Vaga',
                      ),
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                      validator: (title) {
                        if (title.length < 6) {
                          return 'Titulo é muito Curto!';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                 CriterioForm(vaga: vaga,),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: vaga.numberOfVacancies.toString(),
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'Numero de Vagas',
                              hintText: '10'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: vaga.workload.toString(),
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: "Carga Horária",
                              hintText: '06'),

                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.characters,
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

                  ),
                  TextFormField(
                    initialValue: vaga.workplace,
                    decoration: const InputDecoration(
                        hintText: 'Ambiente de trabalho',
                        labelText: "Home Office"),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    validator: (title) {
                      if (title.length < 6) {
                        return 'Titulo é muito Curto!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  RoundedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        // ignore: avoid_print
                        print('valido');
                      } else {
                        print('invalido');
                      }
                    },
                    label: 'Salvar',
                    backgroundColor: AppColors.primaryColor,
                    disableColor: AppColors.secondaryColorlighter,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
