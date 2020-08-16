import 'package:flutter/material.dart';
import 'package:ventura_rh/common/custom_drawer/custom_drawer.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: Text('Home'),
            centerTitle: true,
          ),

        ),
        Container(
          color: Colors.yellow,
          child: Column(
            children: [
              Text('Amarelo'),
              RaisedButton(
                onPressed: (){
                  pageController.jumpToPage(1);
                },
                child: Text('Proxima Pagina'),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.green,
          child: Column(
            children: [
              Text('Verde'),
              RaisedButton(
                onPressed: (){
                  pageController.jumpToPage(2);
                },
                child: Text('Proxima Pagina'),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.red,
          child: Column(
            children: [
              Text('Vermelho'),
              RaisedButton(
                onPressed: (){
                  pageController.jumpToPage(0);
                },
                child: Text('Proxima Pagina'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
