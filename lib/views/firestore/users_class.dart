import 'package:flutter/material.dart';

//  mixin class FirestoreClass{
//   viewTextField(TextEditingController controller ,String hintTexts ,Icon prefixIcons , String labelTexts){
//     return Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: TextFormField(controller: controller,
//         decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),hintText:hintTexts ,prefixIcon: prefixIcons ,labelText: labelTexts),
//       ),
//     );
//   }
// }

mixin class UsersClass {
  viewTextField(TextEditingController controller, String hintText,
      Icon prefixIcon, String labelText, String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: hintText,
          prefixIcon: prefixIcon,
          labelText: labelText,
        ),
        validator: validator,
      ),
    );
  }
}