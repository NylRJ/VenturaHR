import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ventura_rh/models/cepaberto/cepabeto_address.dart';


const token = 'f4ed4b91319b8d988dc04bbca0a81a1b';

class CepAbertoService {

  Future<CepAbetoAddress> getAddressFromCep(String cep) async {

    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endPoint = 'https://www.cepaberto.com/api/v3/cep?cep=$cleanCep';
    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';
    try {
      final response = await dio.get<Map<String, dynamic>>(endPoint);
      if (response.data.isEmpty) {
        return Future.error('CEP Inválido!');
      }
      final CepAbetoAddress address =
      CepAbetoAddress.fromMap(response.data);
      print(address);
      return address;
    } on DioError catch (e) {
      return Future.error('Erro ao buscar o CEP');
    }
  }
}
