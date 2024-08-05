
import 'package:flutter/material.dart';

mixin Class {
  Widget viewTextField(
      TextEditingController controller,
      String hintText,
      Icon icon,
      String labelText,
      String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}