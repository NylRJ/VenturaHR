import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventura_domain/ventura_domain.dart';

class MatchDemoPage extends StatefulWidget {
  const MatchDemoPage({super.key});

  @override
  State<MatchDemoPage> createState() => _MatchDemoPageState();
}

class _MatchDemoPageState extends State<MatchDemoPage> {
  final _engine = PmdEngine();

  final List<JobCriterion> _criteria = [
    JobCriterion(
      id: 'uml',
      name: 'UML',
      description: 'Principais diagramas UML',
      pmd: 4,
      weight: 5,
      requirement: CriterionRequirement.required,
    ),
    JobCriterion(
      id: 'english',
      name: 'Inglês',
      description: 'Conversação e leitura técnica',
      pmd: 4,
      weight: 3,
      requirement: CriterionRequirement.required,
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

  final Map<String, int> _levels = {
    'uml': 5,
    'english': 3,
    'fp': 1,
    'experience': 5,
  };

  final Map<String, bool> _confirmed = {
    'uml': true,
    'english': true,
    'fp': true,
    'experience': true,
  };

  MatchResult get _result {
    final evidence = _criteria
        .where((criterion) => (_levels[criterion.id] ?? 0) > 0)
        .map(
          (criterion) => CandidateCriterionEvidence(
            criterionId: criterion.id,
            level: _levels[criterion.id]!,
            confirmed: _confirmed[criterion.id] ?? true,
          ),
        )
        .toList();

    return _engine.calculate(criteria: _criteria, evidence: evidence);
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Match PMD • demonstração'),
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 980;
                final editor = _CriteriaEditor(
                  criteria: _criteria,
                  levels: _levels,
                  confirmed: _confirmed,
                  onLevelChanged: (id, value) {
                    setState(() => _levels[id] = value);
                  },
                  onConfirmedChanged: (id, value) {
                    setState(() => _confirmed[id] = value);
                  },
                );
                final summary = _MatchSummary(result: result);

                return ListView(
                  children: [
                    const _DemoHeader(),
                    const SizedBox(height: 24),
                    if (wide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 3, child: editor),
                          const SizedBox(width: 24),
                          Expanded(flex: 2, child: summary),
                        ],
                      )
                    else ...[
                      editor,
                      const SizedBox(height: 24),
                      summary,
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _DemoHeader extends StatelessWidget {
  const _DemoHeader();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Wrap(
          spacing: 20,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.science_outlined,
              size: 34,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              width: 760,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Experimente o motor original com regras novas de explicabilidade',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Nível 0 representa ausência de evidência. Desmarcar “confirmada” simula '
                    'uma competência sugerida por IA que ainda não pode participar do score oficial.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CriteriaEditor extends StatelessWidget {
  const _CriteriaEditor({
    required this.criteria,
    required this.levels,
    required this.confirmed,
    required this.onLevelChanged,
    required this.onConfirmedChanged,
  });

  final List<JobCriterion> criteria;
  final Map<String, int> levels;
  final Map<String, bool> confirmed;
  final void Function(String id, int value) onLevelChanged;
  final void Function(String id, bool value) onConfirmedChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Critérios e evidências do candidato',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Altere os valores. O motor recalcula o resultado imediatamente.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            for (var i = 0; i < criteria.length; i++) ...[
              _CriterionControl(
                criterion: criteria[i],
                level: levels[criteria[i].id] ?? 0,
                confirmed: confirmed[criteria[i].id] ?? true,
                onLevelChanged: (value) =>
                    onLevelChanged(criteria[i].id, value),
                onConfirmedChanged: (value) =>
                    onConfirmedChanged(criteria[i].id, value),
              ),
              if (i != criteria.length - 1) const Divider(height: 32),
            ],
          ],
        ),
      ),
    );
  }
}

class _CriterionControl extends StatelessWidget {
  const _CriterionControl({
    required this.criterion,
    required this.level,
    required this.confirmed,
    required this.onLevelChanged,
    required this.onConfirmedChanged,
  });

  final JobCriterion criterion;
  final int level;
  final bool confirmed;
  final ValueChanged<int> onLevelChanged;
  final ValueChanged<bool> onConfirmedChanged;

  @override
  Widget build(BuildContext context) {
    final levelLabel = level == 0 ? 'Sem evidência' : 'Nível $level';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          criterion.name,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      if (criterion.isRequired) ...[
                        const SizedBox(width: 8),
                        const Chip(
                          visualDensity: VisualDensity.compact,
                          label: Text('Obrigatório'),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    '${criterion.description} • PMD ${criterion.pmd} • Peso ${criterion.weight}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(levelLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        Slider(
          value: level.toDouble(),
          min: 0,
          max: 5,
          divisions: 5,
          label: levelLabel,
          onChanged: (value) => onLevelChanged(value.round()),
        ),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          value: confirmed,
          onChanged: level == 0 ? null : onConfirmedChanged,
          title: const Text('Evidência confirmada'),
          subtitle: Text(
            confirmed
                ? 'Participa do score oficial.'
                : 'Provisória: não participa do score oficial.',
          ),
        ),
      ],
    );
  }
}

class _MatchSummary extends StatelessWidget {
  const _MatchSummary({required this.result});

  final MatchResult result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resultado explicável',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    '${result.fitPercentage.toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                const Center(child: Text('aderência ponderada à vaga')),
                const SizedBox(height: 24),
                LinearProgressIndicator(
                  value: result.fitPercentage / 100,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(20),
                ),
                const SizedBox(height: 24),
                _MetricRow(
                  label: 'Perfil PMD da vaga',
                  value: result.jobProfile.toStringAsFixed(2),
                ),
                _MetricRow(
                  label: 'Perfil do candidato',
                  value: result.candidateProfile.toStringAsFixed(2),
                ),
                _MetricRow(
                  label: 'Completude dos dados',
                  value: '${result.dataCompletenessPercentage.toStringAsFixed(0)}%',
                ),
                _MetricRow(
                  label: 'Obrigatórios atendidos',
                  value: result.meetsAllRequired ? 'Sim' : 'Não',
                ),
                _MetricRow(
                  label: 'Algoritmo',
                  value: result.algorithmVersion,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explicação por critério',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 14),
                for (final component in result.components)
                  _ComponentRow(component: component),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComponentRow extends StatelessWidget {
  const _ComponentRow({required this.component});

  final MatchComponent component;

  @override
  Widget build(BuildContext context) {
    final missing = component.candidateLevel == 0;
    final provisional = !component.evidenceConfirmed && !missing;
    final icon = missing || !component.meetsPmd
        ? Icons.error_outline
        : Icons.check_circle_outline;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 21,
            color: component.meetsPmd
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  component.criterionName,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  missing
                      ? 'Sem evidência confirmada • PMD ${component.pmd}'
                      : provisional
                          ? 'Evidência provisória ignorada no score'
                          : 'Candidato ${component.candidateLevel} • PMD ${component.pmd} • fit ${(component.normalizedFit * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
