import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';

import 'image_source_sheet.dart';

class ImagesFormUser extends StatelessWidget {
  final Vaga vaga;

  const ImagesFormUser({Key key, this.vaga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    return FormField<List<dynamic>>(
      initialValue: List.from(vaga.images),
      builder: (state){
        void onImageSelected(File file){
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }
          return AspectRatio(
            aspectRatio: 3,
            child: Carousel(
              images:state.value.map<Widget>((image) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    if(image is String)
                      Image.network(image,fit: BoxFit.cover,)
                    else if(image is! String)
                       Image.file(image as File,fit: BoxFit.cover,),

                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                            Icons.remove
                        ),
                        color: Colors.red,
                        onPressed: (){
                          state.value.remove(image);
                          state.didChange(state.value);
                        },
                      ),

                    ),
                  ],
                );

              }).toList()..add(
                Material(
                  color: Colors.grey[100],
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo,color: AppColors.primaryColor,size: 60,),
                    onPressed: () async{
                      if (Platform.isAndroid) {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                              onImageSelected: onImageSelected,)
                        );
                      } else{
                        showCupertinoModalPopup(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                              onImageSelected: onImageSelected,
                            )
                        );
                      }
                    },
                  ),

                ),
              ),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: AppColors.primaryColor,
              autoplay: false,

            ),
          );
      },
    );
  }
}
