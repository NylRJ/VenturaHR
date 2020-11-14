class CriteriaAnswer {
  CriteriaAnswer({this.name, this.answer, this.weight}) {
    switch (answer) {
      case 'Júnior':
        pm = 2;
        break;
      case 'Pleno':
        pm = 3;
        break;
      case 'Sênior':
        pm = 4;
        break;
      case 'Master':
        pm = 5;
        break;
      default:
        pm = 1;
    }
  }

  CriteriaAnswer.fromMap(Map<String, dynamic> doc) {
    name = doc['name'] as String;
    answer = doc['answer'] as String;
    weight = doc['weight'] as int;
    pm = doc['pm'] as int;
  }

  String name;
  String answer;
  int pm;
  int weight;

  CriteriaAnswer clone() {
    return CriteriaAnswer(
      name: name,
      answer: answer,
      weight: weight,
    );
  }

  void updatePm(){
    switch (answer) {
      case 'Júnior':
        pm = 2;
        break;
      case 'Pleno':
        pm = 3;
        break;
      case 'Sênior':
        pm = 4;
        break;
      case 'Master':
        pm = 5;
        break;
      default:
        pm = 1;
    }
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'answer': answer, 'pm': pm, 'weight': weight};
  }

  @override
  String toString() {
    return 'Resposta User{name: $name, resposta: $answer pm: $pm Peso: $weight}';
  }
}
