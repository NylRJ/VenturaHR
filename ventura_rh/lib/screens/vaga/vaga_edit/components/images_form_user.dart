import 'dart:io';

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

    return FormField<dynamic>(
      initialValue: vaga.images,
      builder: (state){
          return Image.network(state.value as String ,fit: BoxFit.cover,);
      },
    );
  }
}
