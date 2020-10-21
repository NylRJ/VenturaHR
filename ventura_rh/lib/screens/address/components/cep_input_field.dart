import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ventura_rh/utils/app_colors.dart';
import 'package:ventura_rh/widgets/rounded_button.dart';

class CepInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        TextFormField(
          decoration: InputDecoration(
            isDense: true,
            labelText: 'CEP',
            hintText: '12.345-678'
          ),
          inputFormatters: [

            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,

        ),
        Row(
          
          children: [
            FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/login');
                },
                child: Text('← Voltar')),
            RoundedButton(
              label: 'Buscar',
              backgroundColor: AppColors.primaryColor,
              disableColor: AppColors.primaryColor.withAlpha(100),
              onPressed: (){},
            ),
          ],
        ),
      ],
    );
  }
}
