import 'package:flutter/material.dart';

import '../../../database/model/model.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.labelText,
    this.textInputType = TextInputType.text,
    required this.controller,
    this.check = 1,
    this.studentData,
    required this.controllerOption,
  });
  final String labelText;

  final TextInputType textInputType;

  final int check;

  final TextEditingController controller;

  final StudentData? studentData;

  final int controllerOption;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.white),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
