import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/address/address.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/screens/address/components/type_client.dart';

import 'address_register_inputi_feld.dart';
import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Card(

      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
         padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Consumer<UserManager>(
          builder: (_,userManager,__){
            final address = userManager.address ?? Address();
            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Endereço',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  CepInputField(address: address,),
                  AddressRegisterInputField(address: address,),
                  //TypeClient(address: address,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
