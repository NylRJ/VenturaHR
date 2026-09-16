import 'job_criterion.dart';
import 'match_result.dart';

class PmdEngine {
  static const String algorithmVersion = 'pmd-v2.0.0-alpha.1';

  MatchResult calculate({
    required List<JobCriterion> criteria,
    required List<CandidateCriterionEvidence> evidence,
  }) {
    if (criteria.isEmpty) {
      throw ArgumentError.value(
        criteria,
        'criteria',
        'At least one criterion is required.',
      );
    }

    _ensureUniqueCriterionIds(criteria);
    _ensureUniqueEvidence(evidence);

    final evidenceByCriterion = <String, CandidateCriterionEvidence>{
      for (final item in evidence) item.criterionId: item,
    };

    var totalWeight = 0;
    var weightedPmd = 0;
    var weightedCandidateLevel = 0;
    var weightedFit = 0.0;
    var confirmedCriteria = 0;
    var meetsAllRequired = true;

    final components = <MatchComponent>[];

    for (final criterion in criteria) {
      final candidateEvidence = evidenceByCriterion[criterion.id];
      final isConfirmed = candidateEvidence?.confirmed ?? false;
      final candidateLevel = isConfirmed ? candidateEvidence!.level : 0;
      final meetsPmd = candidateLevel >= criterion.pmd;
      final normalizedFit = candidateLevel == 0
          ? 0.0
          : (candidateLevel / criterion.pmd).clamp(0.0, 1.0).toDouble();

      totalWeight += criterion.weight;
      weightedPmd += criterion.pmd * criterion.weight;
      weightedCandidateLevel += candidateLevel * criterion.weight;
      weightedFit += normalizedFit * criterion.weight;

      if (isConfirmed) {
        confirmedCriteria++;
      }

      if (criterion.isRequired && !meetsPmd) {
        meetsAllRequired = false;
      }

      components.add(
        MatchComponent(
          criterionId: criterion.id,
          criterionName: criterion.name,
          pmd: criterion.pmd,
          weight: criterion.weight,
          candidateLevel: candidateLevel,
          requiredCriterion: criterion.isRequired,
          meetsPmd: meetsPmd,
          normalizedFit: normalizedFit,
          evidenceConfirmed: isConfirmed,
        ),
      );
    }

    return MatchResult(
      algorithmVersion: algorithmVersion,
      jobProfile: weightedPmd / totalWeight,
      candidateProfile: weightedCandidateLevel / totalWeight,
      fitPercentage: (weightedFit / totalWeight) * 100,
      dataCompletenessPercentage: (confirmedCriteria / criteria.length) * 100,
      meetsAllRequired: meetsAllRequired,
      components: components,
    );
  }

  void _ensureUniqueCriterionIds(List<JobCriterion> criteria) {
    final ids = <String>{};
    for (final criterion in criteria) {
      if (!ids.add(criterion.id)) {
        throw ArgumentError('Duplicate criterion id: ${criterion.id}');
      }
    }
  }

  void _ensureUniqueEvidence(List<CandidateCriterionEvidence> evidence) {
    final ids = <String>{};
    for (final item in evidence) {
      if (!ids.add(item.criterionId)) {
        throw ArgumentError(
          'Duplicate evidence for criterion: ${item.criterionId}',
        );
      }
    }
  }
}
