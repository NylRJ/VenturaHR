import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth >= 850;
                  final intro = _IntroPanel(
                    onOpenDemo: () => context.go('/match'),
                  );
                  const status = _StatusPanel();

                  return ListView(
                    children: [
                      const _TopBar(),
                      const SizedBox(height: 40),
                      if (wide)
                        const SizedBox.shrink()
                      else
                        const SizedBox(height: 4),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: intro),
                            const SizedBox(width: 28),
                            const Expanded(flex: 2, child: status),
                          ],
                        )
                      else ...[
                        intro,
                        const SizedBox(height: 24),
                        status,
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.hub_outlined, color: Colors.white),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VenturaHR 2.0',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Text('Foundation • Web-first • Matching explicável'),
            ],
          ),
        ),
        const Chip(label: Text('ventura-2.0')),
      ],
    );
  }
}

class _IntroPanel extends StatelessWidget {
  const _IntroPanel({required this.onOpenDemo});

  final VoidCallback onOpenDemo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'O VenturaHR voltou como uma plataforma de inteligência de talentos.',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w900,
                height: 1.05,
              ),
        ),
        const SizedBox(height: 18),
        Text(
          'Nesta primeira versão executável, o PMD original foi preservado e modernizado. '
          'Você já pode simular uma vaga, alterar o nível do candidato e entender exatamente '
          'como o match foi calculado — sem Firebase e sem IA escondendo a regra.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 28),
        FilledButton.icon(
          onPressed: onOpenDemo,
          icon: const Icon(Icons.analytics_outlined),
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Text('Abrir demonstração do Match PMD'),
          ),
        ),
        const SizedBox(height: 16),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(label: Text('Dart 3')),
            Chip(label: Text('Flutter Web')),
            Chip(label: Text('Deep links')),
            Chip(label: Text('Domínio isolado')),
            Chip(label: Text('PMD determinístico')),
          ],
        ),
      ],
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estado da V2',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 20),
            const _StatusItem(
              icon: Icons.check_circle_outline,
              title: 'Domínio Dart puro',
              subtitle: 'Sem dependência de Flutter ou Firebase.',
            ),
            const _StatusItem(
              icon: Icons.calculate_outlined,
              title: 'PMD Engine V2',
              subtitle: 'Algoritmo versionado e testado.',
            ),
            const _StatusItem(
              icon: Icons.language_outlined,
              title: 'Web como primeira classe',
              subtitle: 'Rotas navegáveis diretamente por URL.',
            ),
            const _StatusItem(
              icon: Icons.psychology_outlined,
              title: 'IA vem depois do núcleo',
              subtitle: 'Evidência sugerida por IA não altera score sem confirmação.',
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  const _StatusItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(
                  subtitle,
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
