import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText, borderEnabled;
  final double fontSize;
  final Icon sufixIco;
  final Function validator2;



  const InputText({Key key,this.labelText = '',this.keyboardType = TextInputType.text, this.obscureText = false, this.borderEnabled = true,this.fontSize = 15,this.sufixIco,this.validator2}):super(key: key);

  @override
  Widget build(BuildContext context) {

    return  TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: sufixIco,
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        enabledBorder: !borderEnabled
            ?InputBorder.none
            :const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12
          )
        ),
        labelStyle: const TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w400,

        ),
      ),
      
    );
  }
}
