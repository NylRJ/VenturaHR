import 'package:flutter/material.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/screens/vaga/vaga_details/components/vaga_data_source.dart';




class TabelaCriterioPaginado extends StatefulWidget {
  final Vaga vaga;

  const TabelaCriterioPaginado({Key key, this.vaga}) : super(key: key);

  @override
  _TabelaCriterioPaginado createState() => _TabelaCriterioPaginado();
}

class _TabelaCriterioPaginado extends State<TabelaCriterioPaginado> {
  int _sortColumnIndex;
  bool _sortAscending = true;





  @override
  Widget build(BuildContext context) {
    final VagaDataSource _vagaDataSource = VagaDataSource(widget.vaga);

    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(

          header:  Text('${widget.vaga.companyTitle}'),
          rowsPerPage: 3,
          source: _vagaDataSource,
          columnSpacing: 23,
          horizontalMargin: 6,
          dataRowHeight: 60,
          onSelectAll: (b) {},
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
                numeric: false,
                onSort: (i, b) {
                  print("$i $b");
                  setState(() {
                    widget.vaga.criterios
                        .sort((a, b) => a.name.compareTo(b.name));
                  });
                },
                tooltip: "To display first name of the Name",
                label: Text(
                  'Critério',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            DataColumn(
                numeric: true,
                onSort: (i, b) {
                  print("$i $b");
                  setState(() {
                    widget.vaga.criterios
                        .sort((a, b) => a.description.compareTo(b.description));
                  });
                },
                tooltip: "To display first name of the Name",
                label: Text(
                  'PMD',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            DataColumn(
                numeric: true,
                onSort: (i, b) {
                  print("$i $b");
                  setState(() {
                    widget.vaga.criterios.sort((a, b) => a.pmd.compareTo(b.pmd));
                  });
                },
                tooltip: "To display first name of the Name",
                label: const Text('PESO',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
              numeric: false,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  widget.vaga.criterios
                      .sort((a, b) => a.weight.compareTo(b.weight));
                });
              },
              tooltip: "para exibir o primeiro nome do Nome",
              label: const Text(
                'Descrição',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
