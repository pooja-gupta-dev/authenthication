import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/insta_auth_controller.dart';
import '../controllers/mixin_class.dart';


class InstaRegistrationScreen extends StatefulWidget {
  @override
  _InstaRegistrationScreenState createState() => _InstaRegistrationScreenState();
}

class _InstaRegistrationScreenState extends State<InstaRegistrationScreen>
    with ValidationMixin {
  final InstaAuthController authController = Get.find<InstaAuthController>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  File? _image;

  final _formKey = GlobalKey<FormState>(); // Added a form key for validation

  Future<void> pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        //  title: Text('Register'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                    ),
                    color: Colors.grey,
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.teal.withOpacity(0.2),
                    backgroundImage:
                    _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? InkWell(onTap: pickImage,
                        child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 50))
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  'Upload Profile Picture',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 30),
                buildTextField(_nameController, 'Name', Icons.person, false),
                SizedBox(height: 20),
                buildTextField(_emailController, 'Email', Icons.email, false),
                SizedBox(height: 20),
                buildTextField(
                    _passwordController, 'Password', Icons.lock, true),
                SizedBox(height: 20),
                buildTextField(_phoneController, 'Phone', Icons.phone, false),
                SizedBox(height: 40),
                Container(
                  width: 340,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _image != null) {
                        authController.registerWithEmailAndPassword(
                          _nameController.text.trim(),
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          _phoneController.text.trim(),
                          _image!,
                        );
                        Get.toNamed('/home');
                      } else {
                        Get.snackbar('Error',
                            'Please fill all fields and pick an image.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Register',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
                SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed('/login');
                          },
                        text: 'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      IconData icon, bool isPassword) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }
}