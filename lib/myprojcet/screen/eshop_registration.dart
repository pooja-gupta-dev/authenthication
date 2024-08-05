
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'eshop_home_screen.dart';
import 'eshop_login_screen.dart';


class EshopRegisterScreen extends StatefulWidget {
  const EshopRegisterScreen({super.key});

  @override
  State<EshopRegisterScreen> createState() => _EshopRegisterScreenState();
}

class _EshopRegisterScreenState extends State<EshopRegisterScreen> with ViewTextFild {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Padding(
              padding: EdgeInsets.only(right: 200),
              child: Text(
                "e-Shop",
                style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 100),
            viewTextFild("Name", _nameController),
            viewTextFild("Email", _emailController),
            viewTextFild("Password", _passwordController),
            const SizedBox(height: 150),
            viewButton(
              "Sign Up",
              onPressed: () {
                String name = _nameController.text.trim();
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                if (name.isEmpty || email.isEmpty || password.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please fill all fields",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.red,
                    fontSize: 16.0,
                  );
                } else if (password.length < 8) {
                  Fluttertoast.showToast(
                    msg: "Password must be at least 8 characters long",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.red,
                    fontSize: 16.0,
                  );
                } else {
                  registerUser(name, email, password);
                }
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ", style: TextStyle(color: Colors.black)),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EshopLogin()));
                  },
                  child: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser(String name, String email, String password) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      var userData = await _firestore.collection("usersauth").where("usersEmail", isEqualTo: email).get();
      if (userData.docs.isNotEmpty) {
        Fluttertoast.showToast(
          msg: "Already exists",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0,
        );
      } else {
        await _firestore.collection("usersauth").add({
          "usersName": name,
          "usersEmail": email,
          "usersPassword": password,
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EshopHome()));
      }
    } catch (e) {
      print("Error registering user: $e");
      Fluttertoast.showToast(
        msg: "Error registering user",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

mixin ViewTextFild {
  Widget viewTextFild(String name, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            width: 330,
            height: 38,
            child: TextField(
              controller: controller,
              obscureText: name == "Password", // Hide text for password
              decoration: InputDecoration(
                hintText: name,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget viewButton(String name, {required void Function()? onPressed}) {
    return MaterialButton(
      height: 40,
      minWidth: 200,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.indigo),
      ),
      color: Colors.indigo,
      onPressed: onPressed,
      child: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

