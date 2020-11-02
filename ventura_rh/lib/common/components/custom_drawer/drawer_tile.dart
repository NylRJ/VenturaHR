import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/page_manager.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({this.iconData,this.title,this.page, this.size});
  final IconData iconData;
  final String title;
  final int page;
  final double size;

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page;
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);

      },
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.1,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                iconData,
              size: size==null?30:size,
                color: curPage == page ?primaryColor:Colors.grey[700],
              ),
            ),
            const SizedBox(width: 2,),
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
