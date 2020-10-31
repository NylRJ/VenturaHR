import 'package:flutter/material.dart';
import 'package:ventura_rh/models/users/user_hr.dart';
import 'package:ventura_rh/models/users/user_manager.dart';
import 'package:ventura_rh/screens/login/components/input_text_login.dart';
import 'package:ventura_rh/utils/responsive.dart';

import 'components/address_card.dart';

class AddressScreen extends StatelessWidget {


  Widget subFormPF(UserManager userManager,Responsive responsive){
    return Container(
      child: Column(
        children: [
          InputTextLogin(
            iconPath: 'assets/images/login/icons/email.svg',
            placeholder: "Razão Social",
            enable: !userManager.loading,
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              if (true) {
                return false;
              }

              return true;
            },
          ),
          SizedBox(
            height: responsive.ip(1),
          ),
          InputTextLogin(
            iconPath: 'assets/images/login/icons/email.svg',
            placeholder: "CNPJ ",
            enable: !userManager.loading,
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              if (true) {
                return false;
              }

              return true;
            },
          ),

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Endereço'),
        centerTitle: true,

      ),
      body: ListView(
        children: [
          AddressCard(),
        ],
      ),
    );
  }
}
