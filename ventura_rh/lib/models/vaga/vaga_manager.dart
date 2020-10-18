
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';

class VagaManager extends ChangeNotifier{


  VagaManager(){
    _loadVagas();
  }

  final Firestore firestore = Firestore.instance;

  List<Vaga> allVagas = [];
  String _search = '';
String  get search => _search;

  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Vaga> get filteredVagas{
    final List<Vaga> filteredVagas = [];
    if (search.isEmpty) {
      filteredVagas.addAll(allVagas);
    } else{
      //comparando titulo da vaga com palavraa chave para fazer a busca ambas em letra minuscula
      filteredVagas.addAll(allVagas.where((v) => v.titleVacancy.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredVagas;
  }

  Future<void> _loadVagas()async {
    final QuerySnapshot snapVagas = await firestore.collection('vaga').getDocuments();

      allVagas = snapVagas.documents.map((d) => Vaga.fromDocument(d)).toList();



      notifyListeners();




  }

}