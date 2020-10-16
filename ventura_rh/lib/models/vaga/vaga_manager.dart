
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';

class VagaManager extends ChangeNotifier{


  VagaManager(){
    _loadVagas();
  }

  final Firestore firestore = Firestore.instance;

  List<Vaga> _allVagas = [];

  Future<void> _loadVagas()async {
    final QuerySnapshot snapVagas = await firestore.collection('vaga').getDocuments();

      _allVagas = snapVagas.documents.map((d) => Vaga.fromDocument(d)).toList();



      notifyListeners();




  }

}