import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';

import 'components/search_dialog.dart';
import 'components/vaga_list_tile.dart';

class VagaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<VagaManager>(
          builder: (_,vagaManager,__){
            if (vagaManager.search.isEmpty) {
              return Text('Vaga');
            }else{
              return LayoutBuilder(
                builder: (_,constrains){
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                          context: context, builder: (_) => SearchDialog());

                      if (search != null) {
                        context.read<VagaManager>().search = search;
                      }
                    },
                    child: Container(
                        width: constrains.biggest.width,
                        child: Text(vagaManager.search,
                        textAlign: TextAlign.center,
                        )),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<VagaManager>(
            builder: (_, vagaManager, __) {
              if (vagaManager.search.isEmpty) {
                return IconButton(
                    icon:const Icon(
                      Icons.search,
                    ),
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context, builder: (_) => SearchDialog());

                      if (search != null) {
                        context.read<VagaManager>().search = search;
                      }
                    });
              } else {
                return IconButton(
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: () async {
                      vagaManager.search = '';
                    });
              }
            },
          ),
        ],
      ),
      body: Consumer<VagaManager>(
        builder: (_, vagaManager, __) {
          final filteredVagas = vagaManager.filteredVagas;
          return ListView.builder(
              padding: EdgeInsets.all(4),
              itemCount: filteredVagas.length,
              itemBuilder: (_, index) {
                return VagaListTile(
                  vaga: filteredVagas[index],
                );
              });
        },
      ),
    );
  }
}
