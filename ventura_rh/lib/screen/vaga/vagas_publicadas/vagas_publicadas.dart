import 'package:flutter/material.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';
import 'package:ventura_rh/screen/vaga/components/vaga_list_tile.dart';

class VagasPublicadas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final userManager = context.watch<UserManager>();
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    return  Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title:const Text('Vaga Publicada'),
        centerTitle: true,
      ),
      body: Consumer<VagaManager>(
        builder: (_, vagaManager, __) {
          final List<Vaga>filteredVagas = [];
          vagaManager.allVagas.map((v) {
            if(v.userId == userManager.userHR.id) {
               filteredVagas.add(v);
            }
          } ).toList();
          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: filteredVagas.length,
              itemBuilder: (_, index) {
                return LimitedBox(
                  maxHeight: isTablet?200:160,

                  child: VagaListTile(
                    isTablet: isTablet,
                    vaga: filteredVagas[index],
                  ),
                );
              });
        },
      ),
    );
  }
}
