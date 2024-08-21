// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controllers/insta_auth_controller.dart';
//
// mixin ValidationMixin {
//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email is required';
//     }
//     // Add more email validation logic if needed
//     return null;
//   }
//
//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required';
//     }
//     // Add more password validation logic if needed
//     return null;
//   }
// }
//
// class InstaLoginScreen extends StatelessWidget with ValidationMixin {
//   final InstaAuthController authController = Get.find<InstaAuthController>();
//
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.teal, // Changed to blue
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text("Login Here", style: TextStyle(color: Colors.black, fontSize: 40)),
//                 SizedBox(height: 120),
//                 _buildTextField(_emailController, 'Email', Icons.email, false),
//                 SizedBox(height: 20),
//                 _buildTextField(_passwordController, 'Password', Icons.lock, true),
//                 SizedBox(height: 40),
//                 Container(
//                   width: 340,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
//                         authController.loginWithEmailAndPassword(
//                           _emailController.text.trim(),
//                           _passwordController.text.trim(),
//                         );
//                       } else {
//                         Get.snackbar('Error', 'Please fill all fields.');
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       backgroundColor: Colors.teal, // Changed to blue
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                     child: Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text.rich(
//                   TextSpan(
//                     text: 'Don\'t have an account? ',
//                     style: TextStyle(color: Colors.black, fontSize: 20), // Changed to blue
//                     children: [
//                       TextSpan(
//                         recognizer: TapGestureRecognizer()..onTap = () {
//                           Get.toNamed('/register');
//                         },
//                         text: 'Register',
//                         style: const TextStyle(
//                           color: Colors.black, // Register text in black
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String labelText, IconData icon, bool isPassword) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: labelText,
//         prefixIcon: Icon(icon, color: Colors.black), // Changed to blue
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//       ),
//       obscureText: isPassword,
//       validator: isPassword ? validatePassword : validateEmail,
//     );
//   }
// }
