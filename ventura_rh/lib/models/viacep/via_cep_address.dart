class ViaCepAddress {


  final String cep;
  final String logradouro;
  final String bairro;
  final Cidade localidade;
  final Estado uf;


  ViaCepAddress.fromMap(Map<String, dynamic> map):

        cep = map['cep'] as String,
        logradouro = map['logradouro'] as String,
        bairro = map['bairro'] as String,
        localidade = Cidade.fromMap(map['localidade'] as Map<String, dynamic>),
        uf = Estado.fromMap(map['uf'] as Map<String, dynamic>);


  @override
  String toString() {
    return 'CepAbetoAddress{ cep: $cep,logradouro: $logradouro, bairro: $bairro, cidade: $localidade, estado: $uf}';
  }
}


class Cidade {
  final int ddd;
  final String ibge;
  final String name;

  Cidade.fromMap(Map<String, dynamic> map)
      :
        ddd = map['ddd'] as int,
        ibge = map['ibge'] as String,
        name = map['nome'] as String;

  @override
  String toString() {
    return 'Cidade{ddd: $ddd, ibge: $ibge, name: $name}';
  }
}

class Estado {
  final String sigla;

  Estado.fromMap(Map<String, dynamic> map)
      : sigla = map['sigla'] as String;

  @override
  String toString() {
    return 'Estado{sigla: $sigla}';
  }
}