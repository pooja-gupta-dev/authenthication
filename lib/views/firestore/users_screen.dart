import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'users_firestore.dart';
import 'users_class.dart';
import 'users_show_data.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> with UsersClass {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController villController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController postController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Users Add Data",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: ClipOval(
                  child: Container(
                    width: width * 0.3,  // 30% of the screen width
                    height: width * 0.3,  // 30% of the screen width (to keep it circular)
                    child: Image.network(
                      "https://i.pinimg.com/736x/49/2b/0a/492b0a39a1c9202cdff4682a1ac6225d.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            viewTextField(
              nameController,
              "Enter Name",
              Icon(Icons.person),
              "Name",
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            viewTextField(
              ageController,
              "Enter Age",
              Icon(Icons.support_agent_outlined),
              "Age",
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an age';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid age';
                }
                return null;
              },
            ),
            viewTextField(
              emailController,
              "Enter Email",
              Icon(Icons.email_outlined),
              "Email",
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
            ),
            viewTextField(
              phoneController,
              "Enter Phone",
              Icon(Icons.phone),
              "Phone",
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Address",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.orangeAccent,
                  fontSize: 20,
                ),
              ),
            ),
            viewTextField(
              villController,
              "Enter Vill",
              Icon(Icons.home),
              "Vill",
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a vill';
                }
                return null;
              },
            ),
            viewTextField(
              pinCodeController,
              "Enter PinCode",
              Icon(Icons.pin_drop),
              "PinCode",
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a pinCode';
                }
                return null;
              },
            ),
            viewTextField(
              postController,
              "Enter Post",
              Icon(Icons.post_add),
              "Post",
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a post';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    UsersFireStore().addUsersData(
                      nameController.text,
                      ageController.text,
                      emailController.text,
                      phoneController.text,
                      villController.text,
                      pinCodeController.text,
                      postController.text,
                    );
                    // Clear the fields after adding the data
                    nameController.clear();
                    ageController.clear();
                    emailController.clear();
                    phoneController.clear();
                    villController.clear();
                    pinCodeController.clear();
                    postController.clear();
                  }
                },
                child: const Text(
                  "Add Data",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UsersShowData(),
                    ),
                  );
                },
                child: const Text(
                  "Get Data",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}