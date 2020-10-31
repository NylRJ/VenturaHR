import 'package:flutter/material.dart';
import 'package:ventura_rh/common/custom_icon_button.dart';
import 'package:ventura_rh/models/vaga/aggregates/criterio.dart';

class EditItemCriterio extends StatelessWidget {
  final Criterio criterio;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  const EditItemCriterio(
      {Key key, this.criterio, this.onRemove, this.onMoveUp, this.onMoveDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 20,
          child: SingleChildScrollView(
            child: TextFormField(
              maxLines: 3,
              initialValue: criterio?.name,
              decoration: const InputDecoration(
                labelText: 'CRITERIO',
                labelStyle: TextStyle(fontSize: 12),
                isDense: true,
              ),
              validator: (name) {
                if (name.isEmpty) {
                  return 'Inválido';
                } else {
                  return null;
                }
              },
              onChanged: (name) => criterio.name = name ,
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 15,
          child: TextFormField(
            maxLines: 3,
            initialValue: criterio.pmd?.toString(),
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'PMD',
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (pmd){
              if (int.tryParse(pmd) == null) {
                return 'Inválido';
              }  else{
                return null;
              }
            },
            onChanged: (pmd) => criterio.pmd = int.tryParse(pmd) ,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 15,
          child: TextFormField(
            maxLines: 3,
            initialValue: criterio.weight?.toString(),
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'PESO',
              labelStyle: TextStyle(fontSize: 12),
            ),
           validator: (peso){
              if (int.tryParse(peso) == null) {
                return 'Inválido';
              }  else{
                return null;
              }
           },
            onChanged: (peso) => criterio.weight = int.tryParse(peso) ,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 50,
          child: SingleChildScrollView(
            child: TextFormField(
              style: TextStyle(fontSize: 12),
              textAlignVertical: TextAlignVertical.top,
              maxLines: 4,
              initialValue: criterio.description?.toString(),
              decoration: const InputDecoration(
                isDense: true,
                labelStyle: TextStyle(fontSize: 12),
                labelText: 'DESCRIÇÃO',
              ),
              validator: (description) {
                if (description.isEmpty) {
                  return 'Inválido';
                } else {
                  return null;
                }
              },
              onChanged: (description) => criterio.description = description ,
            ),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}
