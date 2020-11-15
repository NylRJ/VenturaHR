import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';

import 'dropdown_custon.dart';

class TabelaCriterio extends StatefulWidget {


  final Vaga vaga;

  const TabelaCriterio({Key key, this.vaga}) : super(key: key);


  @override
  _TabelaCriterioState createState() => _TabelaCriterioState();
}

class _TabelaCriterioState extends State<TabelaCriterio> {

  @override
  Widget build(BuildContext context) {
 final vagaManager = context.watch<VagaManager>();
 print(widget.vaga.criterios,);

    return SingleChildScrollView(

      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<UserManager>(
          builder: (_,userManager,__){

            vagaManager.addVacanciesAnsweredUser(userManager.userHR,widget.vaga);
            print(vagaManager.vacanciesAnsweredCompany);

        //    print(widget.vaga.criterios,);

            return FormField<List<dynamic>>(
              initialValue: widget.vaga.criterios,
              builder: (state){
                return DataTable(
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

                            setState(() {
                              widget.vaga.criterios
                                  .sort((a, b) => a.name.compareTo(b.name));
                            });
                          },
                          tooltip: "To display first name of the Name",
                          label: const Text(
                            'Critério',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      if (userManager.isLoggedIn)
                        if(userManager.isCompany() )
                          DataColumn(
                              numeric: true,
                              onSort: (i, b) {

                                setState(() {
                                  widget.vaga.criterios
                                      .sort((a, b) => a.description.compareTo(b.description));
                                });
                              },
                              tooltip: "To display first name of the Name",
                              label:const Text(
                                'PMD',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),


                      if (userManager.isLoggedIn)
                        if(userManager.isCompany() )
                          DataColumn(
                              numeric: true,
                              onSort: (i, b) {

                                setState(() {
                                  widget.vaga.criterios
                                      .sort((a, b) => a.pmd.compareTo(b.pmd));
                                });
                              },
                              tooltip: "To display first name of the Name",
                              label: const Text('PESO',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                      if (userManager.isLoggedIn)
                        if(!userManager.isCompany() )
                          const DataColumn(
                            numeric: false,
                            tooltip: "para exibir o primeiro nome do Nome",
                            label:  Text(
                              'Conhecimento',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),


                          ),
                      DataColumn(
                        numeric: false,
                        onSort: (i, b) {

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
                              child: Wrap(
                                children: [
                                  Text(e.name),
                                ],
                              ),
                            ),
                            showEditIcon: false, placeholder: false),
                        if (userManager.isLoggedIn)
                          if(userManager.isCompany() )

                            DataCell(Text('${e.pmd}'),
                                showEditIcon: false, placeholder: false),
                        if (userManager.isLoggedIn)
                          if(userManager.isCompany() )
                            DataCell(Text('${e.weight}'),
                                showEditIcon: false, placeholder: false),
                        if (userManager.isLoggedIn)
                          if(!userManager.isCompany() )
                            DataCell(
                                DropdownCuston(criterio: e,vagaManager:vagaManager),
                                showEditIcon: false,
                                placeholder: false
                            ),
                        DataCell(
                            SingleChildScrollView(
                              child: Container(
                                width: 150,
                                child: Text(e.description,
                                  maxLines: 4,
                                ),
                              ),
                            ),
                            showEditIcon: false, placeholder: false),



                      ],
                    ))
                        .toList());
              },

            );
          },
        ),
      ),
    );
  }
}
