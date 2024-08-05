import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'eshop_home_screen.dart';
import 'eshop_registration.dart';


class EshopLogin extends StatefulWidget {
  const EshopLogin({super.key});

  @override
  State<EshopLogin> createState() => _EshopLoginState();
}

class _EshopLoginState extends State<EshopLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Padding(
              padding: EdgeInsets.only(right: 200),
              child: Text(
                "e-Shop",
                style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 100),
            ViewTextFild.viewTextFild("Email", _emailController),
            ViewTextFild.viewTextFild("Password", _passwordController),
            const SizedBox(height: 150),
            ViewTextFild.viewButton(
              "Login",
              onPressed: () {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                // Validate fields before logging in
                if (email.isEmpty || password.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please fill all fields",
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.white,
                    textColor: Colors.red,
                    fontSize: 16.0,
                  );
                } else {
                  loginUser(email, password, context);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New here? ", style: TextStyle(color: Colors.black)),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EshopRegisterScreen(),));
                    },
                    child: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser(String email, String password, BuildContext context) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      var userQuery = await _firestore.collection("usersauth").where("usersEmail", isEqualTo: email).get();

      if (userQuery.docs.isNotEmpty) {
        bool passwordMatches = userQuery.docs.any((doc) => doc.data()['usersPassword'] == password);
        if (passwordMatches) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EshopHome()));
        } else {
          Fluttertoast.showToast(
            msg: "Incorrect email or password. Try again.",
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.white,
            textColor: Colors.red,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Incorrect email or password. Try again.",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error logging in user: $e",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 16.0,
      );
      print("Error logging in user: $e");
    }
  }
}

class ViewTextFild {
  static Widget viewTextFild(String name, TextEditingController controller) {
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

  static Widget viewButton(String name, {required void Function()? onPressed}) {
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