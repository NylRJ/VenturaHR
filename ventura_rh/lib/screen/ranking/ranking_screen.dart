import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/screen/ranking/ranking_tile.dart';

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Ranking de Candidatos'),
      ),
      body: ListView.builder(
        itemCount: null,
        itemBuilder: (_, index) {
          return Consumer<UserManager>(
            builder: (_, userManager, __) {
              //TODO:fazer lista de rsposta de vagas
              return RankingTile();
            },
          );
        },
      ),
    );
  }
}
