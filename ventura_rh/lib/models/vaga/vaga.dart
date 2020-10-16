import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ventura_rh/models/address/address.dart';
import 'package:ventura_rh/models/users/user_hr.dart';

import 'aggregates/criterio.dart';


class Vaga {
  Vaga.fromDocument(DocumentSnapshot document) {

    id = document.documentID;
    userId = document['user'] as String;
    titleVacancy = document['titleVacancy'] as String;
    descriptionVacancy = document['titleVacancy'] as String;
    image = document['image'] as String;
    address = Address.fromMap(document.data['address'] as Map<String,dynamic>);
    criterio = (document.data['criteria'] as List<  dynamic> ?? []).map(
            (e) => Criterio.fromMap(e as Map<String,dynamic>)).toList();



  }

  String id;
  String userId;
  UserHR user;
  String titleVacancy;
  String descriptionVacancy;
  String image;
  Address address;
  List<Criterio> criterio;



}
