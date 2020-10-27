import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:ventura_rh/models/address/address.dart';

class UserHR extends ChangeNotifier {
  UserHR({this.email, this.password, this.name, this.id}) {
    newImages = [];
    images ??
        [
          'https://firebasestorage.googleapis.com/v0/b/venturahr-e2021.appspot.com/o/userDefault%2Fperfil.png?alt=media&token=ebaea627-a9a8-421a-8ba9-d1524df5ef63'
        ];
  }

  UserHR.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
    accountType = document.data['accountType'] as String;
    if (document.data['accountType'] == 'juridica') {
      cnpj = document.data['cnpj'] as String;
      razaoSocial = document.data['razaoSocial'] as String;
    } else if (document.data['accountType'] == 'fisica') {
      cpf = document.data['cpf'] as String;
    }
    if (document.data.containsKey('address')) {
      address =
          Address.fromMap(document.data['address'] as Map<String, dynamic>);
    }
  }

  String id;
  String name;
  String email;
  List<String> images;

  String phone;
  String password;
  String confirmPassword;
  String cep;
  String cnpj;
  String razaoSocial;
  String cpf;
  String accountType;
  DateTime createdAt;
  DateTime updateAt;
  bool admin = false;
  Address address;
  List<dynamic> newImages;
  String imageDefault =
      'https://firebasestorage.googleapis.com/v0/b/venturahr-e2021.appspot.com/o/userDefault%2Fperfil.png?alt=media&token=ebaea627-a9a8-421a-8ba9-d1524df5ef63';

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  UserHR.candidate(
      {this.id,
      this.name,
      this.email,
      this.images,
      this.newImages,
      this.phone,
      this.password,
      this.cpf,
      this.address,
      this.createdAt,
      this.updateAt}) {
    accountType = "fisica";
    createdAt = DateTime.now();
    updateAt = DateTime.now();
    address = address;
    images ??= [];
  }

  UserHR.company(
      {this.id,
      this.name,
      this.email,
      this.images,
      this.phone,
      this.newImages,
      this.password,
      this.razaoSocial,
      this.cnpj,
      this.createdAt,
      this.updateAt,
      this.address}) {
    accountType = "juridica";
    createdAt = DateTime.now();
    updateAt = DateTime.now();
    address = address;
    images ??= [];
  }

  UserHR.admin(
      {this.id,
      this.name,
      this.email,
      this.images,
      this.newImages,
      this.password,
      this.confirmPassword,
      this.phone,
      this.createdAt,
      this.updateAt,
      this.address}) {
    accountType = "admin";
    createdAt = DateTime.now();
    updateAt = DateTime.now();
    images ??= [];
  }

  UserHR.createCep(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.confirmPassword,
      this.phone,
      this.images,
      this.newImages}) {
    newImages = [];
    images = [
      'https://firebasestorage.googleapis.com/v0/b/venturahr-e2021.appspot.com/o/userDefault%2Fperfil.png?alt=media&token=ebaea627-a9a8-421a-8ba9-d1524df5ef63'
    ];
  }

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  DocumentReference get firestoreCandidate =>
      Firestore.instance.document('candidate/$id');

  DocumentReference get firestoreCompany =>
      Firestore.instance.document('company/$id');

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  StorageReference get storageRefCandidate =>
      storage.ref().child('candidate').child(id);

  StorageReference get storageRefCompany =>
      storage.ref().child('company').child(id);

  Future<void> saveData(String accountType) async {
    if (accountType == 'fisica') {
      //cria doc users
      await firestoreRef.setData(await toMapCandidate());

      // tipa users
      await firestoreCandidate.setData({'user': '$id'});
    } else if (accountType == 'juridica') {
      //cria doc users
      await firestoreRef.setData(await toMapCompany());

      // tipa users
      await firestoreCompany.setData({'user': '$id'});
    }
  }

  Future<Map<String, dynamic>> toMapCandidate() async {
    loading = true;

    for (final newImage in newImages) {
      if (!images.contains(newImage)) {
        final StorageUploadTask task =
            storageRefCandidate.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        images.clear();
        images.add(url);
      }
    }

    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'images': images,
      if (address != null) 'address': address.toMap(),
      'cpf': cpf,
      if (createdAt != null) 'createdAt': createdAt,
      if (updateAt != null) 'updateAt': updateAt,
    };

    loading = false;

    return data;
  }

  Future<Map<String, dynamic>> toMapCompany() async {
    for (final newImage in newImages) {
      if (!images.contains(newImage)) {
        final StorageUploadTask task =
            storageRefCompany.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        images.clear();
        images.add(url);
      }
    }

    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'images': images,
      if (address != null) 'address': address.toMap(),
      'razaoSocial': razaoSocial,
      'cnpj': cnpj,
      if (createdAt != null) 'createdAt': createdAt,
      if (updateAt != null) 'updateAt': updateAt,
    };

    loading = false;

    return data;
  }

  /*
  * Future<void> save() async {



    List<String> updateImages = [] ;


    for(final newImage in newImages)
    { if(!images.contains(newImage)){

      final StorageUploadTask task = storageRefCandidate.child(Uuid().v1()).putFile(newImage as File);
      final StorageTaskSnapshot snapshot = await task.onComplete;
      final String url = await snapshot.ref.getDownloadURL() as String;
      updateImages.add(url);
    }}



    if(id == null){
      final doc = await firestore.collection('users').add(data);
      id = doc.documentID;
    } else {
      await firestoreCandidate.updateData(data);
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


    await firestoreCandidate.updateData({'images': updateImages});

    images = updateImages;

    loading = false;

    return data;
  }*/

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if (address != null) 'address': address.toMap(),
      if (cpf != null) 'cpf': cpf
    };
  }

  Future<void> setAddress(Address address, String accountType) async {
    this.address = address;
    saveData(accountType);
  }

  String tempoAgora() {
    DateTime tempo = new DateTime.now();
    String hora =
        '${tempo.hour}:${tempo.minute}:${tempo.second}:${tempo.millisecond}';

    return hora;
  }

  @override
  String toString() {
    return 'UserHR{id: $id, name: $name, email: $email, phone: $phone, password: $password, confirmPassword: $confirmPassword, cep: $cep, cnpj: $cnpj, razaoSocial: $razaoSocial, cpf: $cpf, accountType: $accountType, createdAt: $createdAt, updateAt: $updateAt, admin: $admin, address: $address}';
  }
}
