import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:ventura_rh/models/page_manager.dart';
import 'package:ventura_rh/screens/home/home_screen.dart';
import 'package:ventura_rh/screens/vaga/vaga_screen.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          VagaScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Publicar Vagas'),
              centerTitle: true,
            ),
          ),
        ],
      ),
    );
  }
}
