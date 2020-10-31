import 'package:flutter/material.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';

class TabelaCriterio extends StatefulWidget {


  final Vaga vaga;

  const TabelaCriterio({Key key, this.vaga}) : super(key: key);

  @override
  _TabelaCriterioState createState() => _TabelaCriterioState();
}

class _TabelaCriterioState extends State<TabelaCriterio> {
  @override
  Widget build(BuildContext context) {
    return                 SingleChildScrollView(

      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
            dividerThickness: 2,
            columnSpacing: 23,
            horizontalMargin: 6,
            dataRowHeight: 60,
            onSelectAll: (b) {},
            sortColumnIndex: 0,
            sortAscending: true,
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
                      widget.vaga.criterios
                          .sort((a, b) => a.pmd.compareTo(b.pmd));
                    });
                  },
                  tooltip: "To display first name of the Name",
                  label: const Text('PESO',
                      style:
                      TextStyle(fontWeight: FontWeight.bold))),
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
            rows: widget.vaga.criterios
                .map((e) => DataRow(

              cells:
              [

                DataCell(

                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                        children: [
                          Text(e.name),
                        ],
                      ),
                    ),
                    showEditIcon: false, placeholder: false),

                DataCell(Text('${e.pmd}'),
                    showEditIcon: false, placeholder: false),
                DataCell(Text('${e.weight}'),
                    showEditIcon: false, placeholder: false),
                DataCell(


                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                        children: [
                          Text('${e.description}'),
                        ],
                      ),
                    ),
                    showEditIcon: false, placeholder: false),

              ],
            ))
                .toList()),
      ),
    );
  }
}
