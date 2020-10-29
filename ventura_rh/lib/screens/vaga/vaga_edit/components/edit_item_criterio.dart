import 'package:flutter/material.dart';
import 'package:ventura_rh/models/vaga/aggregates/criterio.dart';
class EditItemCriterio extends StatelessWidget {
  final Criterio criterio;

  const EditItemCriterio({Key key, this.criterio}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Expanded(
          child: SingleChildScrollView(
            child: TextFormField(
              maxLines: 3,
              initialValue: criterio.name,
              decoration: const InputDecoration(
                hintText: 'UML',
                labelText: 'Criterio',
              ),
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            maxLines: 3,
            initialValue: criterio.pmd.toString(),
            decoration: const InputDecoration(
              hintText: '02',
              labelText: 'PMD',
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            maxLines: 3,
            initialValue: criterio.weight.toString(),
            decoration: const InputDecoration(
              hintText: '05',
              labelText: 'PESO',
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: TextFormField(
              maxLines: 3,
              initialValue: criterio.description.toString(),
              decoration: const InputDecoration(
                hintText: 'Especialista em projeto',
                labelText: 'Descrição',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
