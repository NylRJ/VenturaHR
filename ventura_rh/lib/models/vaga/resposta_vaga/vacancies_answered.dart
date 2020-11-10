import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:ventura_rh/models/vaga/aggregates/criterio.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';

import 'criteria_answer.dart';

class VacanciesAnswered {

  VacanciesAnswered({this.vaga,this.userHR});

  VacanciesAnswered.fromMapUser(DocumentSnapshot document){
    vagaId = document['vagaId'] as String;
    companyTitle = document['companyTitle'] as String;
    titleVacancy = document['titleVacancy'] as String;
    userImage = document['image'] as String;
    listCriteriaAnswer = (document.data['answerCriteria'] as List<dynamic> ?? [])
        .map((e) => CriteriaAnswer.fromMap(e as Map<String, dynamic>))
        .toList();

  }

  VacanciesAnswered.fromMapCompany(DocumentSnapshot document){
    vagaId = document['vagaId'] as String;
    userId = document['userId'] as String;
    userImage = document['image'] as String;
    companyTitle = document['companyTitle'] as String;
    titleVacancy = document['titleVacancy'] as String;
    score = document['score'] as double;
    listCriteriaAnswer = (document.data['answerCriteria'] as List<dynamic> ?? [])
        .map((e) => CriteriaAnswer.fromMap(e as Map<String, dynamic>))
        .toList();

  }
  VacanciesAnswered.responseVacancyUser({this.vaga, this.userHR}) {
    vagaId = vaga.id;
    userId = userHR.id;
    userImage = userHR.images.first;
    companyTitle = vaga.companyTitle;
    titleVacancy = vaga.titleVacancy;
    listCriteriaAnswer = [];
  }

  VacanciesAnswered.responseVacancyCompany({this.vaga, this.userHR}) {
    vagaId = vaga.id;
    userId = userHR.id;
    userName = userHR.name;
    userImage = userHR.images.first;
    companyTitle = vaga.companyTitle;
    titleVacancy = vaga.titleVacancy;
    score = double.tryParse(calc2(vaga.criterios).toStringAsFixed(2));
    listCriteriaAnswer = [];

  }


  Vaga vaga;
  UserHR userHR;
  String vagaId;
  String userId;
  String userName;
  String companyTitle;
  String titleVacancy;
  String userImage;
  String companyImage;
  double score;

  List<CriteriaAnswer> listCriteriaAnswer;
//  List<RespostaCriterio> respostaCriterios;
  // void toMap(Map<String, dynamic> data1, Map<String, dynamic> data2) {
  //   answeredCriteria = {'name': data1['name'], 'answere': data2['answere']};
  // }



  double calc2(List<Criterio> criterios) {
    double sumProduct = 0.0;
    double sumWeight = 0.0;
    criterios.map((e) {
      sumProduct += e.pmd * e.weight;
      sumWeight += e.weight;
    });


    return sumProduct / sumWeight;
  }

  String toString() {
    return 'Resposta: {vagaId: $vagaId, userId: $userId,companyTitle: $companyTitle, titleVacancy: $titleVacancy Score $score}';
  }
  void updateCriteria(CriteriaAnswer criteriaAnswer){
    listCriteriaAnswer.add(criteriaAnswer);
  }
}


