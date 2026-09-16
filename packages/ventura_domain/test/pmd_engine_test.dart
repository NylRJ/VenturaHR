import 'package:test/test.dart';
import 'package:ventura_domain/ventura_domain.dart';

void main() {
  group('PmdEngine', () {
    test('preserves the original VenturaHR weighted profile calculation', () {
      final criteria = [
        JobCriterion(
          id: 'uml',
          name: 'UML',
          description: 'Principais diagramas UML',
          pmd: 4,
          weight: 5,
        ),
        JobCriterion(
          id: 'english',
          name: 'Inglês',
          description: 'Conversação e leitura técnica',
          pmd: 4,
          weight: 3,
        ),
        JobCriterion(
          id: 'fp',
          name: 'Análise de Pontos de Função',
          description: 'Dimensionamento de sistemas',
          pmd: 1,
          weight: 1,
        ),
        JobCriterion(
          id: 'experience',
          name: 'Experiência Profissional',
          description: 'Experiência em requisitos e análise',
          pmd: 4,
          weight: 2,
        ),
      ];

      final evidence = [
        CandidateCriterionEvidence(criterionId: 'uml', level: 5),
        CandidateCriterionEvidence(criterionId: 'english', level: 3),
        CandidateCriterionEvidence(criterionId: 'fp', level: 1),
        CandidateCriterionEvidence(criterionId: 'experience', level: 5),
      ];

      final result = PmdEngine().calculate(
        criteria: criteria,
        evidence: evidence,
      );

      // Original VenturaHR examples:
      // job = 41 / 11 = 3.7272...
      // candidate = 45 / 11 = 4.0909...
      expect(result.jobProfile, closeTo(41 / 11, 0.000001));
      expect(result.candidateProfile, closeTo(45 / 11, 0.000001));
      expect(result.fitPercentage, closeTo(93.181818, 0.0001));
      expect(result.dataCompletenessPercentage, 100);
      expect(result.algorithmVersion, PmdEngine.algorithmVersion);
    });

    test('required criterion fails when candidate is below PMD', () {
      final criteria = [
        JobCriterion(
          id: 'flutter',
          name: 'Flutter',
          description: 'Desenvolvimento Flutter',
          pmd: 4,
          weight: 5,
          requirement: CriterionRequirement.required,
        ),
      ];

      final result = PmdEngine().calculate(
        criteria: criteria,
        evidence: [
          CandidateCriterionEvidence(criterionId: 'flutter', level: 3),
        ],
      );

      expect(result.meetsAllRequired, isFalse);
      expect(result.requiredGaps, hasLength(1));
      expect(result.requiredGaps.single.criterionId, 'flutter');
      expect(result.fitPercentage, 75);
    });

    test('unconfirmed AI evidence does not affect official score', () {
      final criteria = [
        JobCriterion(
          id: 'firebase',
          name: 'Firebase',
          description: 'Firebase',
          pmd: 4,
          weight: 4,
          requirement: CriterionRequirement.required,
        ),
      ];

      final result = PmdEngine().calculate(
        criteria: criteria,
        evidence: [
          CandidateCriterionEvidence(
            criterionId: 'firebase',
            level: 5,
            confirmed: false,
          ),
        ],
      );

      expect(result.candidateProfile, 0);
      expect(result.fitPercentage, 0);
      expect(result.dataCompletenessPercentage, 0);
      expect(result.meetsAllRequired, isFalse);
      expect(result.components.single.evidenceConfirmed, isFalse);
    });

    test('rejects duplicated evidence for the same criterion', () {
      final criterion = JobCriterion(
        id: 'dart',
        name: 'Dart',
        description: 'Dart',
        pmd: 3,
        weight: 3,
      );

      expect(
        () => PmdEngine().calculate(
          criteria: [criterion],
          evidence: [
            CandidateCriterionEvidence(criterionId: 'dart', level: 3),
            CandidateCriterionEvidence(criterionId: 'dart', level: 4),
          ],
        ),
        throwsArgumentError,
      );
    });
  });

  group('JobCriterion', () {
    test('validates PMD and weight ranges', () {
      expect(
        () => JobCriterion(
          id: 'x',
          name: 'X',
          description: 'X',
          pmd: 0,
          weight: 1,
        ),
        throwsRangeError,
      );

      expect(
        () => JobCriterion(
          id: 'x',
          name: 'X',
          description: 'X',
          pmd: 1,
          weight: 6,
        ),
        throwsRangeError,
      );
    });
  });
}
