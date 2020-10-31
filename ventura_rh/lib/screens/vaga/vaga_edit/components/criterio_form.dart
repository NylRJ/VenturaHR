import 'package:flutter/material.dart';
import 'package:ventura_rh/common/custom_icon_button.dart';
import 'package:ventura_rh/models/vaga/aggregates/criterio.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';

import 'edit_item_criterio.dart';

class CriterioForm extends StatelessWidget {
  final Vaga vaga;

  const CriterioForm({Key key, this.vaga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        FormField<List<Criterio>>(
              initialValue: List.from(vaga.criterios),
          builder: (state){
                print(state.value);
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       const Text(
                          'Criterio',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomIconButton(
                          iconData: Icons.add,
                          onTap: (){
                            state.value.add(Criterio());
                            state.didChange(state.value);
                          },
                          color: Colors.black,

                        ),
                      ],
                    ),

                    Column(
                      children: state.value.map((criterio) {
                        return EditItemCriterio(
                          key: ObjectKey(criterio),
                          criterio:criterio,
                          onRemove: (){
                            state.value.remove(criterio);
                            state.didChange(state.value);
                          },
                          onMoveUp:criterio != state.value.first?(){
                            final index = state.value.indexOf(criterio);
                            state.value.remove(criterio);
                            state.value.insert(index - 1, criterio);
                            state.didChange(state.value);
                          }:null,
                          onMoveDown: criterio != state.value.last?(){
                            final index = state.value.indexOf(criterio);
                            state.value.remove(criterio);
                            state.value.insert(index + 1, criterio);
                            state.didChange(state.value);
                          }:null,

                        );
                      }).toList(),
                    ),
                  ],
                );
          },
        ),
      ],
    );
  }
}
