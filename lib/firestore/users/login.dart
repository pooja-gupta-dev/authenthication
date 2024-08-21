// // // import 'package:flutter/material.dart';
// // //
// // // class Login extends StatefulWidget {
// // //   const Login({super.key});
// // //
// // //   @override
// // //   State<Login> createState() => _LoginState();
// // // }
// // //
// // // class _LoginState extends State<Login> {
// // //
// // //   TextEditingController EmailController = TextEditingController();
// // //   TextEditingController PasswordController = TextEditingController();
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("Login "),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //
// // //         ],
// // //       )
// // //     );
// // //
// // //   }
// // // }
// // import 'package:authenthication/firestore/users/registers.dart';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class Login extends StatefulWidget {
// //   @override
// //   _LoginState createState() => _LoginState();
// // }
// //
// // class _LoginState extends State<Login> {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //
// //   Future<void> login() async {
// //     try {
// //       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
// //         email: _emailController.text,
// //         password: _passwordController.text,
// //       );
// //
// //       User? user = userCredential.user;
// //
// //       // Retrieve user data from Firestore
// //       DocumentSnapshot docSnapshot =
// //       await _firestore.collection('users').doc(user!.uid).get();
// //
// //       if (docSnapshot.exists) {
// //         print("User data: ${docSnapshot.data()}");
// //       } else {
// //         print("No such document!");
// //       }
// //
// //       print("User logged in successfully: ${user.email}");
// //     } catch (e) {
// //       print("Error logging in user: $e");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Center(child: Text("Login")),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [SizedBox(height: 20,),
// //           Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJEnRtWT8i0np4on0Ho2OClMItc0NJ52zURw&s"),
// //             TextField(
// //               controller: _emailController,
// //               decoration: InputDecoration(labelText: "Email"),
// //             ),
// //             TextField(
// //               controller: _passwordController,
// //               decoration: InputDecoration(labelText: "Password"),
// //               obscureText: true,
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: (){
// //
// //               },
// //               child: Text("Login"),
// //             ),
// //             SizedBox(height: 30,),
// //             ElevatedButton(onPressed: (){
// //                Navigator.push(context, MaterialPageRoute(builder: (context) => Registers(),));
// //             }, child: Text("Registion"))
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:authenthication/firestore/users/registers.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'class.dart';
// import 'home_screen.dart';
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> with Class {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Login Screen", style: TextStyle(fontSize: 20, color: Colors.white)),
//         backgroundColor: Colors.indigo,
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(6.0),
//               child: Center(
//                 child: ClipOval(
//                   child: Container(
//                     width: width * 0.3,
//                     height: width * 0.3,
//                     child: Image.network(
//                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJEnRtWT8i0np4on0Ho2OClMItc0NJ52zURw&s",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             viewTextField(
//               emailController,
//               "Enter Email",
//               const Icon(Icons.person),
//               "Email",
//                   (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter an email';
//                 }
//                 return null;
//               },
//             ),
//             viewTextField(
//               passwordController,
//               "Enter Password",
//               const Icon(Icons.lock),
//               "Password",
//                   (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a password';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 5),
//             Padding(
//               padding: const EdgeInsets.all(38.0),
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.indigo),
//                 ),
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     String email = emailController.text;
//                     String password = passwordController.text;
//
//                     QuerySnapshot querySnapshot = await _firestore.collection('data').where('email', isEqualTo: email).get();
//
//                     if (querySnapshot.docs.isNotEmpty) {
//                       var user = querySnapshot.docs.first.data() as Map<String, dynamic>;
//                       if (user['password'] == password) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const HomeScreen(),
//                           ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Incorrect password!')),
//                         );
//                       }
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: const Text('Email does not exist, please register!'),
//                           action: SnackBarAction(
//                             label: 'Register',
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Register (),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       );
//                     }
//                   }
//                 },
//                 child:  Text(
//                   "Login",
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }