import 'package:flutter/material.dart';

import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(

      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
         padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Text(
              'Endereço',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
           ),
            CepInputField(),
          ],
        ),
      ),
    );
  }
}
