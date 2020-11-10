import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:ventura_rh/models/page_manager.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/screen/home/home_screen.dart';
import 'package:ventura_rh/screen/vaga/vaga_edit/vaga_edit.dart';
import 'package:ventura_rh/screen/vaga/vaga_screen.dart';
import 'package:ventura_rh/screen/vaga/vagas_publicadas/vagas_publicadas.dart';
import 'package:ventura_rh/screen/vaga/vagas_respondidas/vagas_respondidas_screen.dart';

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
          VagaEdit(Vaga()),
          VagasPublicadas(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Rankign'),
              centerTitle: true,
            ),
          ),
          VagasRespondidas(),
        ],
      ),
    );
  }
}
