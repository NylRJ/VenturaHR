import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/common/custom_icon_button.dart';
import 'package:ventura_rh/models/address/address.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/utils/app_colors.dart';

import 'package:ventura_rh/widgets/rounded_button.dart';

class CepInputField extends StatelessWidget {

    Address address;
    String cep;
   CepInputField({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();

    if(address.zipCode == null)
    {
      return Column(
        children: [
          TextFormField(
            enabled: !userManager.loading,
            decoration: InputDecoration(
                isDense: true,
                labelText: 'CEP',
                hintText: '12.345-678'
            ),
            inputFormatters: [

              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            validator: (cep){
              if (cep.isEmpty) {
                return 'Campo Obrigatorio';
              } else if(cep.length != 10){
                return 'Campo Invalido';
              }else{
                return null;
              }
            },
            onChanged: (textCep) => cep = textCep,
          ),
          if (userManager.loading)
            LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.primaryColor,),backgroundColor:AppColors.secondaryDarker,),
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
                onPressed:userManager.loading?null:() async{
                  if (Form.of(context).validate()) {
                    try{
                      await context.read<UserManager>().getAddress(cep);
                    }catch(e){
                      Scaffold.of(context).showSnackBar(
                          SnackBar(
                              content: Text('$e',
                              ),
                            backgroundColor: Colors.red,
                          ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ],
      );
    } else{
      return Row(
        children: [
          Text('CEP:${address.zipCode}',
          style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          CustomIconButton(
            iconData: Icons.edit,
            color: AppColors.primaryColor,
            onTap: (){
              context.read<UserManager>().removeAddress();
            },
          ),
        ],
      );
    }
  }
}
