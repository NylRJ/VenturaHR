import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'src/features/home/home_page.dart';
import 'src/features/match_demo/match_demo_page.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/match',
      builder: (context, state) => const MatchDemoPage(),
    ),
  ],
);

class VenturaHrApp extends StatelessWidget {
  const VenturaHrApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF4C5BD4),
      brightness: Brightness.light,
    );

    return MaterialApp.router(
      title: 'VenturaHR 2.0',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
      ),
      routerConfig: _router,
    );
  }
}
