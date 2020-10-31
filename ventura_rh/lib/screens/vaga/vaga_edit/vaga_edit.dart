import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';
import 'components/images_form.dart';
import 'components/vaga_form.dart';

class VagaEdit extends StatelessWidget {


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  VagaEdit(Vaga v):
        vaga = v != null ? v.clone() : Vaga();

  final Vaga vaga;

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
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,

                          child: TextFormField(
                            initialValue: vaga?.titleVacancy,
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
                      ),
                      SizedBox(width: 5.0,),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,

                          child: TextFormField(
                            initialValue: vaga?.companyTitle,
                            decoration: const InputDecoration(
                              hintText: 'America.ltda',
                              labelText: 'Nome da empresa',
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
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: vaga.numberOfVacancies?.toString(),
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
                          initialValue: vaga.workload?.toString(),
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: "Carga Horária",
                              hintText: '06'),

                        ),
                      ),
                    ],
                  ),

                  TextFormField(
                    initialValue: vaga?.workplace,
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

                  VagaForm(vaga: vaga,),
                  Text(
                    'DESCRIÇÃO DA VAGA',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 12),
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: 3,
                    initialValue: vaga.descriptionVacancy ,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelStyle: TextStyle(fontSize: 12),
                      hintText: 'Descrição da vaga',
                      labelText: 'DESCRIÇÃO',

                      border: OutlineInputBorder(

                      ),
                    ),



                  ),
                  Divider(

                    indent:5,
                    endIndent: 5,
                    height: 20,
                    thickness: 1,
                    color: AppColors.primaryColor,
                  ),
                      Divider(

                        indent:150,
                        endIndent: 150,
                        height: 20,
                        thickness: 1,
                        color: AppColors.primaryColor,
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
