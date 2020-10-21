import 'package:ventura_rh/models/address/address.dart';
import 'package:ventura_rh/models/users/user.dart';

class UserHR {
  UserHR({this.email, this.password, this.name, this.id});

  UserHR.candidate(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.confirmPassword,
        this.phone,
        this.createdAt,
        this.updateAt}) {
    accountType = "fisica";
    createdAt = DateTime.now();
    updateAt = DateTime.now();

  }

  UserHR.company(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.confirmPassword,
        this.phone,
        this.createdAt,
        this.updateAt,
        this.address}) {
    this.accountType = "juridica";
    createdAt = DateTime.now();
    updateAt = DateTime.now();

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
  String accountType;
  DateTime createdAt;
  DateTime updateAt;
  bool admin = false;
  Address address;

  @override
  String toString() {

  }
}