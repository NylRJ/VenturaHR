import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:ventura_rh/models/vaga/resposta_vaga/vacancies_answered.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';

class VagaManager extends ChangeNotifier {

  VagaManager() {
     _loadCurrentUser();
    _loadVagas();


  }

  final Firestore firestore = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  DocumentReference get firestoreRef =>
      firestore.document('users/${userHR.id}');

  //vagas respondidas
  DocumentReference get firestoreRefVacanciesAnswered =>
      firestore.document('users/${userHR.id}');

  //resposta das vagas
  DocumentReference get firestoreRefVacancyResponse =>
      firestore.document('users/${userHR.id}');

  UserHR userHR;


  static String ACCOUNT_TYPE_FISICA = 'fisica';
  static String ACCOUNT_TYPE_JURIDICA = 'juridica';

  bool _loading = false;

  bool get loading => _loading;

  bool get isLoggedIn => userHR != null;

  List<Vaga> allVagas = [];

  List<VacanciesAnswered> allVacanciesAnswered = [];


  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Vaga> get filteredVagas {
    final List<Vaga> filteredVagas = [];
    if (search.isEmpty) {
      filteredVagas.addAll(allVagas);
    } else {
      //comparando titulo da vaga com palavraa chave para fazer a busca ambas em letra minuscula
      filteredVagas.addAll(allVagas.where(
              (v) =>
              v.titleVacancy.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredVagas;
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if (currentUser != null) {
      final DocumentSnapshot docUser =
      await firestore.collection('users').document(currentUser.uid).get();
      userHR = UserHR.fromDocument(docUser);

      final docCompany =
      await firestore.collection('company').document(userHR.id).get();
      if (docCompany.exists) {
        userHR.accountType = ACCOUNT_TYPE_JURIDICA;
        notifyListeners();
      } else {
        final docCandidate =
        await firestore.collection('candidate').document(userHR.id).get();

        if (docCandidate.exists) {
          userHR.accountType = ACCOUNT_TYPE_FISICA;
          notifyListeners();
        } else {
          final docAdmin =
          await firestore.collection('admins').document(userHR.id).get();
          if (docAdmin.exists) {
            userHR.admin = true;
          }
        }
      }

      _loadAnsweredVacancies();
    }
  }

  Future<void> _loadAnsweredVacancies() async {

    if (userHR.accountType.contains(ACCOUNT_TYPE_FISICA)  ) {
      final QuerySnapshot snapVacancies =
      await firestoreRefVacanciesAnswered.collection('vacanciesAnswered')
          .getDocuments();
      allVacanciesAnswered =
          snapVacancies.documents.map((e) => VacanciesAnswered.fromMapUser(e))
              .toList();

      notifyListeners();
    }else if (userHR.accountType.contains(ACCOUNT_TYPE_JURIDICA)) {
    final QuerySnapshot snapVacancies =
    await firestoreRefVacanciesAnswered.collection('vacancyResponse')
        .getDocuments();
    allVacanciesAnswered =
    snapVacancies.documents.map((e) => VacanciesAnswered.fromMapCompany(e))
        .toList();


    notifyListeners();
    }
  }

    Future<void> _loadVagas() async {
      final QuerySnapshot snapVagas =
      await firestore.collection('vaga').getDocuments();

      allVagas = snapVagas.documents.map((d) => Vaga.fromDocument(d)).toList();

      notifyListeners();
    }

    void update(Vaga vaga) {
      allVagas.removeWhere((v) => v.id == vaga.id);
      allVagas.add(vaga);
      notifyListeners();
    }

    void delete(Vaga vaga) {
      vaga.delete();
      allVagas.removeWhere((p) => p.id == vaga.id);
      notifyListeners();
    }
    // void saveResposta(){
    //   vacanciesAnswered.add();
    // }
  }
