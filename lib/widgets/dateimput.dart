import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDate extends StatefulWidget {
  InputDate({
    Key? key,
    this.labelText,
    this.hintText,
    this.obligatorio = false,
    this.txtvalue,
    this.onChanged
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final bool obligatorio;
  final TextEditingController? txtvalue;
  final Function? onChanged;

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: (TextStyle(fontFamily: 'BreeSerif')),
      controller: widget.txtvalue,
      onChanged: (String? txtvalue) => widget.onChanged!(),
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(pickedDate);
                setState(() {
                  widget.txtvalue!.text = formattedDate;
                });
              } else {}
            },
            child: Icon(Icons.date_range),
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      validator: (txtvalue) {
        if (widget.obligatorio) {
          if (txtvalue == null || txtvalue.isEmpty) {
            return 'Este campo es obligatoria';
          }
        }
      },
    );
  }
}
