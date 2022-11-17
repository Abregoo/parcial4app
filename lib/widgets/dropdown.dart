import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  Dropdown({
    Key? key,
    required this.lstitems,
    required this.hintText,
    required this.onChanged,
    required this.selectedValue,
    this.labelText,
    
  }) : super(key: key);

  final Function(dynamic) onChanged;
  final String? labelText;
  final String hintText;
  final dynamic selectedValue;
  List<DropdownMenuItem<int>> lstitems;
  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        items: widget.lstitems,
        hint: Text(widget.hintText),
        onChanged: widget.onChanged,
        );
  }
}
