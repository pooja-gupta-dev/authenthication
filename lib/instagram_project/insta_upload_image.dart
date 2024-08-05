import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // Changed to Material from Cupertino for better widget compatibility

// Define the controllers
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
File? _image;

Future<String> InstaUploadImage(File image) async {
  try {
    final storageRef = FirebaseStorage.instance.ref().child('user_images/${DateTime.now().toString()}');
    final uploadTask = storageRef.putFile(image);
    final snapshot = await uploadTask;
    final imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  } catch (e) {
    print('Image upload failed: $e');
    return '';
  }
}

Future<void> signUp(BuildContext context) async {
  final name = nameController.text.trim();
  final email = emailController.text.trim();
  final password = passwordController.text.trim();
  final phone = phoneController.text.trim();

  // Basic validation
  if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
    print('All fields must be filled');
    return;
  }

  if (password.length < 6) {
    print('Password should be at least 6 characters');
    return;
  }

  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email, password: password);

    // Upload image if selected
    String imageUrl = '';
    if (_image != null) {
      imageUrl = await InstaUploadImage(_image!);
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': imageUrl,
    });

    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    print('FirebaseAuthException: ${e.message}');
    // Optionally show an error message to the user
  } catch (e) {
    print('Sign up failed: $e');
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () => signUp(context),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}