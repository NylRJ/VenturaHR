class Criterio {
  Criterio({this.name, this.pmd, this.weight, this.description});

  Criterio.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    description = map['description'] as String;
    pmd = map['pmd'] as int;
    weight = map['weight'] as int;
  }

  String name;
  String description;
  int pmd;
  int weight;

  Criterio clone() {
    return Criterio(
      name: name,
      pmd: pmd,
      weight: weight,
      description: description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'pmd': pmd,
      'weight': weight
    };
  }

  @override
  String toString() {
    return 'Criterio{name: $name, description: $description, pmd: $pmd, weight: $weight}';
  }
}
