import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:ventura_rh/models/address/address.dart';
import 'package:ventura_rh/models/users/user_hr.dart';

import 'aggregates/criterio.dart';

class Vaga extends ChangeNotifier {
  Vaga.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    userId = document['userId'] as String;
    companyTitle = document['companyTitle'] as String;
    titleVacancy = document['titleVacancy'] as String;
    descriptionVacancy = document['descriptionVacancy'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
    workplace = document['workplace'] as String;
    workload = document['workload'] as int;
    numberOfVacancies = document['numberOfVacancies'] as int;
    address = Address.fromMap(document.data['address'] as Map<String, dynamic>);
    criterios = (document.data['criteria'] as List<dynamic> ?? [])
        .map((e) => Criterio.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Vaga(
      {this.id,
        this.userId,
        this.user,
        this.companyTitle,
        this.titleVacancy,
        this.descriptionVacancy,
        this.images,
        this.workplace,
        this.workload,
        this.numberOfVacancies,
        this.address,
        this.criterios,
        this.newImages,
        this.deleted = false}) {
    images = images ?? [];
    criterios =  criterios ?? [];
    newImages = newImages ?? [];
  }



  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('vaga/$id');

  StorageReference get storageRef => storage.ref().child('vagas').child(id);

  String id;
  String userId;
  UserHR user;
  String companyTitle;
  String titleVacancy;
  String descriptionVacancy;
  List<String> images;
  String workplace;
  int workload;
  int numberOfVacancies;
  Address address;
  List<Criterio> criterios;
  List<String> newImages;
  File file;
  bool deleted;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }


  List<Map<String, dynamic>> exportSizeList(){
    return criterios.map((c) => c.toMap()).toList();
  }

  Future<void> save() async {
    loading = true;

    final Map<String, dynamic> data = {
      'id': id,
      'userId': userId,
      'address': address.toMap(),
      'companyTitle': companyTitle,
      'titleVacancy':titleVacancy,
      'descriptionVacancy':descriptionVacancy,
      'image':images,
      'workplace':workplace,
      'workload':workload,
      'numberOfVacancies':numberOfVacancies,
      'criterio':exportSizeList()
    };

     List<String> updateImages = [] ;


    for(final newImage in newImages)
    { if(!images.contains(newImage)){

        final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }}



    if(id == null){
      final doc = await firestore.collection('vaga').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }


      //removendo do firebase imagem
         for(final image in images)
         {if(!newImages.contains(image) && images.contains('firebase')){
      try {
        final ref = await storage.getReferenceFromUrl(image);
        await ref.delete();
      } catch (e){
        debugPrint('Falha ao deletar $image');
      }
    }}


    await firestoreRef.updateData({'images': updateImages});

    images = updateImages;

    loading = false;
  }


  void delete(){
    firestoreRef.updateData({'deleted': true});
  }


  Vaga clone(){
    return Vaga(
      id: id,
      userId: userId,
      companyTitle:companyTitle,
      titleVacancy:titleVacancy,
      descriptionVacancy:descriptionVacancy,
      workplace:workplace,
      workload:workload,
      numberOfVacancies:numberOfVacancies,
      images: List.from(images),
      criterios: criterios.map((c) => c.clone()).toList(),
      address: address,

    );
  }
}
