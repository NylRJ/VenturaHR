import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  final Vaga vaga;

  const ImagesForm({Key key, this.vaga}) : super(key: key);

  Widget imageWidget(String state, BuildContext context,Function(File) onImageSelected){
    bool imageState = false;

    if (state.isEmpty) {
      imageState = true;
    }

      if (state is String) {


          return Center(
            child: Container(
              child: ClipOval(

                  child: Align(
                      heightFactor: imageState?1:1.0,
                      widthFactor: imageState?1:0.5,
                      child:imageState ?Material(
                        color: Colors.grey[100],
                          child: IconButton(
                              icon: const Icon(Icons.add_a_photo),
                              color: AppColors.secondaryColorlighter,
                              iconSize: 60, onPressed: () async{
                                if (Platform.isAndroid) {
                                  File file = await showModalBottomSheet(
                                      context: context,
                                      builder: (_) => ImageSourceSheet(onImageSelected: onImageSelected,) );
                                } else{
                                   File file = await showCupertinoModalPopup(
                                      context: context,
                                      builder: (_) => ImageSourceSheet()
                                  );
                                }
                          })
                      ) :Image.network(state,fit: BoxFit.cover,))),
            ),
          );


    }else {
      return Center(
        child: Container(
          child: ClipOval(

              child: Align(
                  heightFactor: 1.0,
                  widthFactor: 0.5,
                  child: Image.file(state as File, fit: BoxFit.cover),
              ),
          ),
        ),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    return FormField<dynamic>(
      initialValue: vaga.images,
      builder: (state){
  //TODO: erro
        void onImageSelected(File file){
          state.value.add(file);
          state.didChange(vaga.images);
          Navigator.of(context).pop();
        }
        return Container(
          height: 250,
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              imageWidget(state.value as String,context,onImageSelected),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.red,

                  ),
                  onPressed: (){
                    vaga.images =[];

                    state.didChange(vaga.images);
                  },
                ),
              ),

            ],
          ),
        );
      },
    );
  }

}





