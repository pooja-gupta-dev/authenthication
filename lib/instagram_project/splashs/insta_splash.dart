// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../authInsta/instalogin_insta.dart';
// import '../insta_home/insta_home_screens.dart';
//
//
// class InstaSplashScreen extends StatefulWidget {
//   const InstaSplashScreen({super.key});
//
//   @override
//   State<InstaSplashScreen> createState() => _InstaSplashScreenState();
// }
//
// class _InstaSplashScreenState extends State<InstaSplashScreen> {
//   @override
//   void initState() {
//     Timer(
//       Duration(seconds: 2),
//           () {
//         checkUser();
//       },
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 290),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(),
//                 child: Text("KriCent", style: TextStyle(color: Colors.black,fontSize: 20),),
//               ),
//               CupertinoActivityIndicator(),
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
//
//   void checkUser() async {
//     bool isLogin = FirebaseAuth.instance.currentUser?.uid != null;
//     if (isLogin) {
//       Get.offAll(() => InstaHomeScreen());
//     } else {
//       Get.offAll(() => InstaLoginScreen());
//     }
//   }
// }

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../authInsta/instalogin_insta.dart';
import '../insta_home/insta_home_screens.dart';

class InstaSplashScreen extends StatefulWidget {
  const InstaSplashScreen({super.key});

  @override
  State<InstaSplashScreen> createState() => _InstaSplashScreenState();
}

class _InstaSplashScreenState extends State<InstaSplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 2),
          () {
        checkUser();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Optionally handle back button press
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100), // Adjust the top padding as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Network image
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRELARAxKBuNvQqiwSLRoDVZqGwikIyKhc7gg&s', // Replace with your network image URL
                width: 100, // Adjust width as needed
                height: 100, // Adjust height as needed
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              CupertinoActivityIndicator(),
              SizedBox(height: 20),
              Text(
                "KriCent",
                style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkUser() async {
    bool isLogin = FirebaseAuth.instance.currentUser?.uid != null;
    if (isLogin) {
      Get.offAll(() => InstaHomeScreen());
    } else {
      Get.offAll(() => InstaLoginScreen());
    }
  }
}
