class MatchComponent {
  const MatchComponent({
    required this.criterionId,
    required this.criterionName,
    required this.pmd,
    required this.weight,
    required this.candidateLevel,
    required this.requiredCriterion,
    required this.meetsPmd,
    required this.normalizedFit,
    required this.evidenceConfirmed,
  });

  final String criterionId;
  final String criterionName;
  final int pmd;
  final int weight;
  final int candidateLevel;
  final bool requiredCriterion;
  final bool meetsPmd;

  /// Fit for this criterion from 0.0 to 1.0, capped when the candidate
  /// exceeds the PMD. This keeps excess proficiency from compensating for
  /// a completely unrelated gap in another criterion.
  final double normalizedFit;

  /// AI-extracted or otherwise provisional evidence does not affect the
  /// official deterministic score until it is confirmed.
  final bool evidenceConfirmed;
}

class MatchResult {
  MatchResult({
    required this.algorithmVersion,
    required this.jobProfile,
    required this.candidateProfile,
    required this.fitPercentage,
    required this.dataCompletenessPercentage,
    required this.meetsAllRequired,
    required List<MatchComponent> components,
  }) : components = List.unmodifiable(components);

  final String algorithmVersion;

  /// Original VenturaHR weighted PMD baseline, on the 1..5 scale.
  final double jobProfile;

  /// Candidate weighted profile using confirmed evidence only.
  /// Missing/unconfirmed criteria contribute 0 until confirmed.
  final double candidateProfile;

  /// Explainable weighted coverage of PMD requirements, from 0..100.
  final double fitPercentage;

  /// Percentage of criteria with confirmed candidate evidence, from 0..100.
  final double dataCompletenessPercentage;

  /// False when at least one required criterion is missing or below its PMD.
  final bool meetsAllRequired;

  final List<MatchComponent> components;

  List<MatchComponent> get requiredGaps => components
      .where((component) =>
          component.requiredCriterion && !component.meetsPmd)
      .toList(growable: false);
}
