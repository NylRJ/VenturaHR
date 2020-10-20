import 'package:flutter/material.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';

import 'package:ventura_rh/screens/vaga/components/vaga_list_tile.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Inicio'),
        centerTitle: true,
      ),
      body: Consumer<VagaManager>(
        builder: (_, vagaManager, __) {
          final filteredVagas = vagaManager.filteredVagas;
          return ListView.builder(
              padding: EdgeInsets.all(4),
              itemCount: filteredVagas.length,
              itemBuilder: (_, index) {
                return LimitedBox(
                  maxHeight: 150,

                  child: VagaListTile(
                    vaga: filteredVagas[index],
                  ),
                );
              });
        },
      ),
    );
  }
}
