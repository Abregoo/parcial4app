import 'package:flutter/material.dart';


class Input extends StatelessWidget {
  const Input({
    Key? key,
    this.labelText,
    this.hintText,
    this.obligatorio = false,
    this.txtvalue 
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final bool obligatorio;
  final TextEditingController? txtvalue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: txtvalue,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      validator: (txtvalue) {
        if (obligatorio) {
          if (txtvalue == null || txtvalue.isEmpty) {
            return 'Este campo es obligatorio';
          }
        }
      },
    );
  }
}