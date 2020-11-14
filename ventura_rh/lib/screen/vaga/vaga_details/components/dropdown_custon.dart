import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/vaga/aggregates/criterio.dart';
import 'package:ventura_rh/models/vaga/resposta_vaga/criteria_answer.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';

class DropdownCuston extends StatefulWidget {
  final Criterio criterio;
  final VagaManager vagaManager;

  //final VacanciesAnswered vacanciesAnsweredUser;
  //final VacanciesAnswered vacanciesAnsweredCompany;

  const DropdownCuston({Key key, this.criterio, this.vagaManager})
      : super(key: key);

  @override
  _DropdownCustonState createState() => _DropdownCustonState();
}

class _DropdownCustonState extends State<DropdownCuston> {
  List<DropdownMenuItem<String>> lisDrop = [];
  List<String> drop = ['Trainee', 'Júnior', 'Pleno', 'Sênior', 'Master'];
  int cont = 0;
  String selected = 'Trainee';

  void loadData() {
    lisDrop = [];
    lisDrop = drop
        .map((val) => DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    //final vagaManager = context.watch<VagaManager>();
    int value = 0;
    CriteriaAnswer criteriaAnswer;
    if (value <1) {
      criteriaAnswer = CriteriaAnswer(
        name: widget.criterio.name,
        answer: selected,
        weight: widget.criterio.weight,
      );
      value++;
      widget.vagaManager.vacanciesAnsweredUser.updateListCriteriaAnswer(criteriaAnswer);
    }

    loadData();
    return Container(
      child: DropdownButton(
        value: selected,
        items: lisDrop,
        hint: Text(selected),

        onChanged: (value) {
          setState(() {
            selected = value.toString();
          });


                  criteriaAnswer.name = widget.criterio.name;
                  criteriaAnswer.answer = selected;
                  criteriaAnswer.weight = widget.criterio.weight;
                  criteriaAnswer.updatePm();


          widget.vagaManager.vacanciesAnsweredUser.updateListCriteriaAnswer(criteriaAnswer);

          print('Depois');
          print(widget.vagaManager.vacanciesAnsweredUser.listCriteriaAnswer);
        },
      ),
    );
  }
}
