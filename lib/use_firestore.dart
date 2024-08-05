// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
//
// class UseFirestore extends StatefulWidget {
//   const UseFirestore({super.key});
//
//   @override
//   State<UseFirestore> createState() => _UseFirestoreState();
// }
//
// class _UseFirestoreState extends State<UseFirestore> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firestore"),
//       ),
//       body:Column(
//         children: [
//           ElevatedButton(onPressed: (){
//
//           }, child: Text("Register")),
//           ElevatedButton(onPressed: (){
//
//           }, child:Text("Login")),
//           ])
//     );
//   }
//   registerUser()async{
//     var firestore =FirebaseFirestore.instance;
//     var already= await firestore.collection("users").where("email",isEqualTo: "pk@gmail.com");
//     if (already.docs.isNotEmpty){
//       Fluttertoast.showToast("Email already exisst");
//     }else{
//       await firestore.collection("Users").add({
//         "email":"a@gmail.com",
//         "password":"123456"
//       });
//     }
//   }
//   LoginUser()async {
//    var firestore =FirebaseFirestore.instance;
//    var existUser= await firestore.collection("users").where("email",isEqualTo: "pk@gmail.com");
//    if (existUser.dacs.isNotEmpty){
//      Fluttertoast.showToast("Email already exisst");
//    }else{
//      await firestore.collection("Users").add({
//        "email":"p@gmail.com",
//        "password":"123456"
//      });
//    }
//   }
// }
