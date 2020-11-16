import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';

import 'criteria_answer.dart';

class VacanciesAnswered extends ChangeNotifier {
  VacanciesAnswered({this.vaga, this.userHR});

  VacanciesAnswered.fromMapUser(DocumentSnapshot document) {
    id = document.documentID;
    vagaId = document['vagaId'] as String;
    companyTitle = document['companyTitle'] as String;
    titleVacancy = document['titleVacancy'] as String;
    companyImage = document['companyImage'] as String;
    firestore
        .document('vaga/$vagaId')
        .get()
        .then((doc) => vaga = Vaga.fromDocument(doc));
    listCriteriaAnswer =
        (document.data['answerCriteria'] as List<dynamic> ?? [])
            .map((e) => CriteriaAnswer.fromMap(e as Map<String, dynamic>))
            .toList();
  }

  VacanciesAnswered.fromMapCompany(DocumentSnapshot document) {
    id = document.documentID;
    vagaId = document['vagaId'] as String;
    userId = document['userId'] as String;
    userName = document['userName'] as String;
    userImage = document['userImage'] as String;
    companyTitle = document['companyTitle'] as String;
    titleVacancy = document['titleVacancy'] as String;
    score = document['score'] as double;
    firestore
        .document('users/$userId')
        .get()
        .then((doc) => userHR = UserHR.fromDocument(doc));
    listCriteriaAnswer =
        (document.data['answerCriteria'] as List<dynamic> ?? [])
            .map((e) => CriteriaAnswer.fromMap(e as Map<String, dynamic>))
            .toList();
  }

  VacanciesAnswered.responseVacancyUser({this.vaga, this.userHR}) {
    vagaId = vaga.id;
    userId = userHR.id;
    companyImage = vaga.images.first;
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
    listCriteriaAnswer = [];
    score = 0;
  }

  Firestore firestore = Firestore.instance;

  DocumentReference get firestoreUser =>
      firestore.document('users/${userHR.id}');

  DocumentReference get firestoreCompany =>
      firestore.document('users/${vaga.userId}');


  Vaga vaga;
  String id;
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

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // void toMap(Map<String, dynamic> data1, Map<String, dynamic> data2) {
  //   answeredCriteria = {'name': data1['name'], 'answere': data2['answere']};
  // }

  double calc2() {
    double sumProduct = 0.0;
    double sumWeight = 0.0;
    listCriteriaAnswer.forEach((e) {
      sumProduct += e.pm * e.weight;
      sumWeight += e.weight;
    });

    final scor = (sumProduct / sumWeight).toStringAsFixed(1);

    return double.tryParse(scor) ;
  }

  String toString() {
    return 'Resposta da vaga: {vagaId: $vagaId, userId: $userId,companyTitle: $companyTitle, titleVacancy: $titleVacancy Score $score criterios: $listCriteriaAnswer}';
  }

  void updateListCriteriaAnswer(CriteriaAnswer criteriaAnswer) {
    List<CriteriaAnswer> listCriteriaAnswerNew = List.from(listCriteriaAnswer);
    int index;

    if (listCriteriaAnswerNew.isNotEmpty) {

        if (!listCriteriaAnswerNew.contains(criteriaAnswer)) {
          listCriteriaAnswer.add(criteriaAnswer);
        } else {
          //mudar listCriteriaAnswer por listCriteriaAnswerNew
          index = listCriteriaAnswer
              .indexWhere((element) => element.name == criteriaAnswer.name);
          listCriteriaAnswer.removeAt(index);
          listCriteriaAnswer.insert(index, criteriaAnswer);

        }

    } else {
      listCriteriaAnswer.add(criteriaAnswer);

    }
    notifyListeners();
  }



  List<Map<String, dynamic>> exportSizeList() {
    return listCriteriaAnswer.map((c) => c.toMap()).toList();
  }

  Future<void> saveCompany() async {
    loading = true;

    final Map<String, dynamic> data = {
      'id':id,
      'vagaId': vagaId,
      'userId': userId,
      'userName': userName,
      'titleVacancy': titleVacancy,
      'companyTitle': companyTitle,
      'userImage': userImage,
      'score': calc2(),
      'answerCriteria': exportSizeList()
    };

    if (id == null) {
      final doc = await firestoreCompany.collection('vacancyResponse').add(data);
      id = doc.documentID;
      firestoreCompany.collection('vacancyResponse').document('$id').updateData({'id': id});
    } else {
      await firestoreCompany
          .collection('vacancyResponse')
          .document('$id')
          .updateData(data);
    }

    loading = false;
  }

  Future<void> saveUser() async {
    loading = true;
    final Map<String, dynamic> data = {
      'id':id,
      'vagaId': vagaId,
      'titleVacancy': titleVacancy,
      'companyTitle': companyTitle,
      'companyImage': companyImage,
      'answerCriteria': exportSizeList()
    };

    if (id == null) {
      final doc = await firestoreUser.collection('vacanciesAnswered').add(data);
      id = doc.documentID;
      firestoreUser.collection('vacanciesAnswered').document('$id').updateData({'id': id});
    } else {
      await firestoreUser
          .collection('vacanciesAnswered')
          .document('$id')
          .updateData(data);
    }

     loading = false;


    }
}
