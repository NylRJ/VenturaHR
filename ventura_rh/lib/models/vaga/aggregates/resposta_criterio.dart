class RespostaCriterio {
  RespostaCriterio({this.name, this.answer});

  RespostaCriterio.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    answer = map['answer'] as String;

  }

  String name;
  String answer;


  RespostaCriterio clone() {
    return RespostaCriterio(
      name: name,
      answer: answer,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'answer': answer,

    };
  }

  @override
  String toString() {
    return 'Criterio{name: $name, answer: $answer}';
  }
}
