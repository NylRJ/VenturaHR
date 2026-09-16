enum CriterionRequirement { optional, required }

class JobCriterion {
  JobCriterion({
    required this.id,
    required this.name,
    required this.description,
    required this.pmd,
    required this.weight,
    this.requirement = CriterionRequirement.optional,
  }) {
    if (id.trim().isEmpty) {
      throw ArgumentError.value(id, 'id', 'Criterion id cannot be empty.');
    }
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'Criterion name cannot be empty.');
    }
    if (pmd < 1 || pmd > 5) {
      throw RangeError.range(pmd, 1, 5, 'pmd');
    }
    if (weight < 1 || weight > 5) {
      throw RangeError.range(weight, 1, 5, 'weight');
    }
  }

  final String id;
  final String name;
  final String description;
  final int pmd;
  final int weight;
  final CriterionRequirement requirement;

  bool get isRequired => requirement == CriterionRequirement.required;
}

class CandidateCriterionEvidence {
  CandidateCriterionEvidence({
    required this.criterionId,
    required this.level,
    this.confirmed = true,
  }) {
    if (criterionId.trim().isEmpty) {
      throw ArgumentError.value(
        criterionId,
        'criterionId',
        'Criterion id cannot be empty.',
      );
    }
    if (level < 1 || level > 5) {
      throw RangeError.range(level, 1, 5, 'level');
    }
  }

  final String criterionId;
  final int level;
  final bool confirmed;
}
