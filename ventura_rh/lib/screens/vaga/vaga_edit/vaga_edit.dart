import 'package:flutter/material.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/screens/vaga/vaga_edit/components/images_form_user.dart';

import 'components/images_form.dart';

class VagaEdit extends StatelessWidget {
  final Vaga vaga;

  const VagaEdit( this.vaga) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Vaga'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ImagesFormUser(vaga: vaga,),

        ],
      ),
    );
  }
}
