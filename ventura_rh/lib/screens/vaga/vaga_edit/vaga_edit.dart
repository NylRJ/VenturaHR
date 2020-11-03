

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';
import 'components/images_form.dart';
import 'components/vaga_form.dart';
import 'package:provider/provider.dart';

class VagaEdit extends StatelessWidget {


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  VagaEdit({Key key , Vaga v}):
        editing = v != null,
        vaga = v != null ? v.clone() : Vaga();

  final Vaga vaga;
  final bool editing;

  @override
  Widget build(BuildContext context) {

    List<bool> _selections = List.generate(3, (_) => false);

    return ChangeNotifierProvider.value(
      value: vaga,
      child: Scaffold(
        drawer: CustomDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(editing?'Editar Vaga':'Criar Vaga'),
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
                              onSaved: (title) => vaga.titleVacancy = title,
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
                                if (title.length < 1) {
                                  return 'Nome da Empresa é muito Curto!';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (titleC) => vaga.companyTitle = titleC,
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
                            onSaved: (titleNumberOfVacancies) => vaga.numberOfVacancies = int.tryParse(titleNumberOfVacancies),
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
                            onSaved: (titleWorkload) => vaga.workload = int.tryParse(titleWorkload),
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
                          return 'local de trabalhoTitulo é muito Curto!';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (titleWorkplace) => vaga.workplace = titleWorkplace,
                    ),

                    VagaForm(vaga: vaga,),
                    const Text(
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
                      validator: (description){
                        if (!description.isEmpty && description.length > 10 && description.length < 10000 ) {
                          return null;
                        }  else{return 'Invalido';}
                      },
                      onSaved: (titleDescriptionVacancy) => vaga.descriptionVacancy = titleDescriptionVacancy,

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
                      onPressed: !vaga.loading? () async{
                        if (formKey.currentState.validate()) {
                          // ignore: avoid_print
                          vaga.userId = context.read<UserManager>().userHR.id;
                          vaga.address = context.read<UserManager>().userHR.address;
                          formKey.currentState.save();
                          await vaga.save();
                          context.read<VagaManager>().update(vaga);
                          Navigator.of(context).pushNamed('/base');

                        } else {
                          print('invalido');
                        }
                      }:null,
                      progress: vaga.loading?const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ):null,
                      label:'Salvar',
                      backgroundColor: AppColors.primaryColor,
                      disableColor: AppColors.secondaryColorlighter,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
