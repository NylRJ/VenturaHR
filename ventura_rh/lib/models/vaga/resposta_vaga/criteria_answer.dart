class CriteriaAnswer {
  CriteriaAnswer({this.name, this.answer,this.pm});

  CriteriaAnswer.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    answer = map['answer'] as String;
    pm = map['pm'] as double;

  }

  String name;
  String answer;
  double pm;

  CriteriaAnswer clone() {
    return CriteriaAnswer(
      name: name,
      answer: answer,
      pm:pm,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'answer': answer,
      'pm':pm,

    };
  }

  @override
  String toString() {
    return 'Resposta User{name: $name, description: $answer pm: $pm}';
  }
}
