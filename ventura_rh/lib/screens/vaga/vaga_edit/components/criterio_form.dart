import 'package:flutter/material.dart';
import 'package:ventura_rh/models/vaga/aggregates/criterio.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';

import 'edit_item_criterio.dart';

class CriterioForm extends StatelessWidget {
  final Vaga vaga;

  const CriterioForm({Key key, this.vaga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<List<Criterio>>(
          initialValue: vaga.criterios,
      builder: (state){
            return Column(
              children: state.value.map((criterio) {
                return EditItemCriterio(
                  criterio:criterio
                );
              }).toList(),
            );
      },
    );
  }
}
