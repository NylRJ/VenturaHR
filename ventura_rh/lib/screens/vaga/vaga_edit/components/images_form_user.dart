import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/utils/responsive.dart';

import 'image_source_sheet.dart';

class ImagesFormUser extends StatelessWidget {
  final UserHR user;

  const ImagesFormUser({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    return FormField<List<dynamic>>(
      initialValue: List.from(user.images),
      validator: (images){
        if (images.isEmpty) {

          return 'Insira ao menos imagem';
        }else{
          return null;
        }
      },
      onSaved: (images) => context.read<UserManager>().userHR.newImages = images,
      builder: (state){
        void onImageSelected(File file){
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }
          return Column(
            children: [
              AspectRatio(
                aspectRatio: 4/2,
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
              ),
              if (state.hasError)
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 16,left: 16),
                    child: Text(state.errorText,style: TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.bold),)),

            ],
          );
      },
    );
  }
}
