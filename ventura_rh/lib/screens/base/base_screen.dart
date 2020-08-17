import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/common/custom_drawer/custom_drawer.dart';
import 'package:ventura_rh/models/page_manager.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text('Home'),
              centerTitle: true,
            ),

          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text('Buscar Vagas'),
              centerTitle: true,
            ),

          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text('Editar Vagas'),
              centerTitle: true,
            ),

          ),

        ],
      ),
    );
  }
}
