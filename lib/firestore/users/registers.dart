//
// import 'package:flutter/material.dart';
//
// class Registers extends StatefulWidget {
//   const Registers({super.key});
//
//   @override
//   State<Registers> createState() => _RegistersState();
// }
//
// class _RegistersState extends State<Registers> {
//   TextEditingController EmailController = TextEditingController();
//   TextEditingController PasswordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Center(child: Text("registration")),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(100),
//           child: Column(
//
//             children: [
//               Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZVTNyADJRltPovqtAWscor1Cm0SQ386uA9w&s"),
//
//               SizedBox(
//                 height: 10,
//               ),
//               TextField(
//                 controller: EmailController,
//                 decoration: InputDecoration(
//                     hoverColor: Colors.deepOrange,
//                     prefixIcon: Icon(Icons.app_registration,),
//                     border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(18)
//                     )
//                 ),
//                ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 controller: PasswordController,
//
//                 decoration: InputDecoration(
//
//                      hoverColor: Colors.deepOrange,
//                      prefixIcon: Icon(Icons.login),
//                      border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(18),
//                     )),
//                ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                   onPressed: () {
//                   },
//                   child: Text("Rgistration",
//                   )),
//               SizedBox(height: 20,),
//
//               ElevatedButton(onPressed: (){
//
//               }, child: Text("Login"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'class.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}
class _RegisterState extends State<Register> with Class {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Register Screen", style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.indigo,
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
                    width: width * 0.3,
                    height: width * 0.3,
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZVTNyADJRltPovqtAWscor1Cm0SQ386uA9w&s",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            viewTextField(
              emailController,
              "Enter Email",
              const Icon(Icons.person),
              "Email",
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
            ),
            viewTextField(
              passwordController,
              "Enter Password",
              const Icon(Icons.lock),
              "Password",
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String email = emailController.text;
                    String password = passwordController.text;

                    QuerySnapshot querySnapshot = await _firestore
                        .collection('data')
                        .where('email', isEqualTo: email)
                        .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email already exists')),
                      );
                    } else {
                      await _firestore.collection('data').add({
                        'email': email,
                        'password': password,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registration Successful!')),
                      );

                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text(
                  "Register",
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