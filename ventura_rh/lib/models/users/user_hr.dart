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
    this.accountType = "PF";
    this.toString();
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
    this.accountType = "PJ";
    this.toString();
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
    this.accountType = "admin";
    this.toString();
  }

  String id;
  String name;
  String email;
  String phone;
  String password;
  String confirmPassword;
  String accountType;
  DateTime createdAt;
  DateTime updateAt;
  bool admin = false;
  Address address;
}