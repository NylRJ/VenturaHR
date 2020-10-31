
import 'package:flutter/material.dart';

class DataTableCostumer extends StatefulWidget {
  @override
  DataTableCostumerState createState() {
    return new DataTableCostumerState();
  }
}

class DataTableCostumerState extends State<DataTableCostumer> {
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 0,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("First Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");

            setState(() {
              names.sort((a, b) => a.firstName.compareTo(b.firstName));
            });
          },
          tooltip: "To display first name of the Name",
        ),
        DataColumn(
          label: Text("Last Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.lastName.compareTo(b.lastName));
            });
          },
          tooltip: "To display last name of the Name",
        ),
      ],
      rows: names
          .map(
            (name) => DataRow(
            onSelectChanged: (b){},
          cells: [
            DataCell(
              Text(name.firstName),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text(name.lastName),
              showEditIcon: false,
              placeholder: false,
            )
          ],
        ),
      )
          .toList());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: bodyData(),
    );
  }
}

class Name {
  String firstName;
  String lastName;

  Name({this.firstName, this.lastName});
}

var names = <Name>[
  Name(firstName: "Pawan", lastName: "Kumar"),
  Name(firstName: "Aakash", lastName: "Tewari"),
  Name(firstName: "Rohan", lastName: "Singh"),
];
