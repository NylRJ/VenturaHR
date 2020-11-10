import 'package:flutter/material.dart';
import 'package:ventura_rh/models/vaga/aggregates/criterio.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
class VagaDataSource extends DataTableSource {
  final Vaga vaga;
  int _selectedCount = 0;

  VagaDataSource(this.vaga);

  @override
  int get rowCount => vaga.criterios.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  @override
  DataRow getRow(int index) {
    final Criterio criterio = vaga.criterios[index];
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              children: [
                Text(criterio.name),
              ],
            ),
          ),
          showEditIcon: false,
          placeholder: false),
      DataCell(Text('${criterio.pmd}'),
          showEditIcon: false, placeholder: false),
      DataCell(Text('${criterio.weight}'),
          showEditIcon: false, placeholder: false),
      DataCell(
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              children: [
                Text('${criterio.description}'),
              ],
            ),
          ),
          showEditIcon: false,
          placeholder: false),
    ]);
  }
}
