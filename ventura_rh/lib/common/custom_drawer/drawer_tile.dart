import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/page_manager.dart';

class DrawerTile extends StatelessWidget {
   const DrawerTile({this.iconData,this.title,this.page});
  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page;
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);
        debugPrint('toquei $page Atual $curPage');
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
              size: 32,
                color: curPage == page ?primaryColor:Colors.grey[700],
              ),
            ),
            const SizedBox(width: 32,),
            Text(
                title,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page ?primaryColor:Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
