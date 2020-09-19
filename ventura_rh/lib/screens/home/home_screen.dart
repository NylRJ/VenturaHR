import 'package:flutter/material.dart';
import 'package:ventura_rh/common/components/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        drawer: CustomDrawer(),
    appBar: AppBar(
    title: Text('Inicio'),
    centerTitle: true,
    ),
    );
  }
}
