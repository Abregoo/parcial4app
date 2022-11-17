import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  Dropdown({Key? key}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.grey, width: 0.0),
            ),
            border: OutlineInputBorder()),
        items: [
          const DropdownMenuItem(
            child: Text("Masculino"),
            value: 1,
          ),
          const DropdownMenuItem(
            child: Text("Femenino"),
            value: 2,
          )
        ],
        hint: const Text("Sexo"),
        onChanged: (value) {
          setState(() {
            //   measure = value;
            // measureList.add(measure);
          });
        },
        onSaved: (value) {
          setState(() {
            // measure = value;
          });
        });
  }
}
