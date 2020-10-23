import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ventura_rh/models/address/address.dart';
import 'package:ventura_rh/models/users/user.dart';

class UserHR {



  UserHR({this.email, this.password, this.name, this.id});




  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');


  UserHR.fromDocument(DocumentSnapshot document){
    id = document.documentID;
     name = document.data['name'] as String;
     email = document.data['email'] as String;
     accountType = document.data['accountType'] as String;
     if (document.data['accountType'] == 'juridica') {
       cnpj = document.data['cnpj'] as String;
       razaoSocial = document.data['razaoSocial'] as String;
     } else  if (document.data['accountType'] == 'fisica'){
       cpf = document.data['cpf'] as String;
     }
     if(document.data.containsKey('address')){
       address = Address.fromMap(document.data['address'] as Map<String,dynamic>);
     }
  }

  UserHR.candidate(
      {this.id,
        this.name,
        this.email,
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

  }

  UserHR.company(
      {this.id,
        this.name,
        this.email,
        this.phone,
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

  }


  UserHR.admin(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.confirmPassword,
        this.phone,
        this.createdAt,
        this.updateAt,
        this.address}) {
    accountType = "admin";
    createdAt = DateTime.now();
    updateAt = DateTime.now();

  }

  UserHR.createCep(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.confirmPassword,
        this.phone,

       }) {



  }

  String id;
  String name;
  String email;
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

  Future<void> saveData(String accountType) async {
    if (accountType == 'fisica') {

      await firestoreRef.setData(toMapCandidate());
    }  else if (accountType == 'juridica'){
      await firestoreRef.setData(toMapcompany());
    }
  }


  Map<String, dynamic> toMapCandidate(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      if(address != null)
        'address': address.toMap(),
        'cpf': cpf,
      if(createdAt != null)
        'createdAt': createdAt,
      if(updateAt != null)
        'updateAt': updateAt,
      if(accountType != null)
      'accountType':accountType
    };
  }

  Map<String, dynamic> toMapcompany(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      if(address != null)
        'address': address.toMap(),
        'razaoSocial': razaoSocial,
        'cnpj': cnpj,
      if(createdAt != null)
        'createdAt': createdAt,
      if(updateAt != null)
        'updateAt': updateAt,
      if(accountType != null)
      'accountType':accountType
    };
  }





  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      if(address != null)
        'address': address.toMap(),
      if(cpf != null)
        'cpf': cpf
    };
  }
  Future<void> setAddress(Address address, String accountType) async {
    this.address = address;
    saveData(accountType);
  }



  String tempoAgora(){
    DateTime tempo = new DateTime.now();
    String hora ='${tempo.hour}:${tempo.minute}:${tempo.second}:${tempo.millisecond}';

    return hora;
  }

  @override
  String toString() {

  }
}