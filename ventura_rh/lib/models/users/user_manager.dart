import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ventura_rh/helpers/firebase_errors.dart';
import 'package:ventura_rh/models/address/address.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:ventura_rh/services/cep_aberto_service.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Address address;
  UserHR userHR;

  static String ACCOUNT_TYPE_FISICA = 'fisica';
  static String ACCOUNT_TYPE_JURIDICA = 'juridica';

  bool _loading = false;

  bool get loading => _loading;

  bool get isLoggedIn => userHR != null;

  Future<void> signIn(
      {UserHR user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      // userHR.id = result.user.uid;
      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signUp(
      {UserHR user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      userHR = user;
      userHR.id = result.user.uid;
      await userHR.saveData(user.accountType);

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    userHR = null;
    notifyListeners();
  }

  bool isCompany() {
    if (userHR.accountType == ACCOUNT_TYPE_JURIDICA) {
      return true;
    } else {
      return false;
    }
  }

  bool isCandidate() {
    if (userHR.accountType == ACCOUNT_TYPE_FISICA) {
      return true;
    } else {
      return false;
    }
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
        userHR.accountType = 'juridica';
      } else {
        final docCandidate =
            await firestore.collection('candidate').document(userHR.id).get();
        if (docCandidate.exists) {
          userHR.accountType = 'fisica';
        } else {
          final docAdmin =
              await firestore.collection('admins').document(userHR.id).get();
          if (docAdmin.exists) {
            userHR.admin = true;
          }
        }
      }

      notifyListeners();
    }
  }

  bool get adminEnabled => userHR != null && userHR.admin;

  Future<void> getAddress(String cep) async {
    loading = true;
    final cepAbertpoSevice = CepAbertoService();

    try {
      final cepAbertoaddress = await cepAbertpoSevice.getAddressFromCep(cep);
      if (cepAbertoaddress != null) {
        address = Address(
            street: cepAbertoaddress.logradouro,
            district: cepAbertoaddress.bairro,
            zipCode: cepAbertoaddress.cep,
            city: cepAbertoaddress.cidade.name,
            state: cepAbertoaddress.estado.sigla,
            lat: cepAbertoaddress.latitude,
            long: cepAbertoaddress.longitude);
      }
      loading = false;
    } catch (e) {
      loading = false;
      return Future.error('CEP Inválido');
    }
  }

  void removeAddress() {
    address = null;
    notifyListeners();
  }
}
