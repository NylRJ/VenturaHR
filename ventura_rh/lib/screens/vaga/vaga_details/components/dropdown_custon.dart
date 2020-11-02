import 'package:flutter/material.dart';

class DropdownCuston extends StatefulWidget {

  @override
  _DropdownCustonState createState() => _DropdownCustonState();
}

class _DropdownCustonState extends State<DropdownCuston> {
    List<DropdownMenuItem<String>> lisDrop = [];
    List<String> drop = ['pouco','médio','todo','top'];

  String selected;

  void loadData(){
    lisDrop = [];
    // lisDrop.add( DropdownMenuItem(child: Text('pouco'),value: 'pouco',));
    // lisDrop.add( DropdownMenuItem(child: Text('médio'),value: 'médio',));
    // lisDrop.add( DropdownMenuItem(child: Text('todo'), value:'todo',));
    lisDrop = drop.map((val) => DropdownMenuItem<String>(
      child: Text(val), value: val,
    )).toList();
  }

  @override
  Widget build(BuildContext context) {

    loadData();
    return Container(
      child: DropdownButton(
          value: selected,
          items: lisDrop,
          hint:const Text('Selecione'),
          onChanged: (value) {
              setState(() {
                selected = value.toString();
              });
            },


      ),

    );
  }
}
