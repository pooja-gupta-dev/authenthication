// import 'dart:async';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
//
// import 'dynamic_link_srevice.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   void initState(){
//     super.initState();
//     Timer(Duration(seconds: 4),(){
//       Navigator.push(context, MaterialPageRoute(builder:
//           (context) =>DynamicLinkScreen(),));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         title: Text("Splash"),
//       ) ,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("welcome",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20,),
//             CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
//   void getLink() async {
//     final PendingDynamicLinkData? getDynamicLink = await
//     FirebaseDynamicLinks.instance.getInitialLink();
//     if (getDynamicLink != null) {
//       final Uri deepLink = getDynamicLink.link;
//       Navigator.pushNamed(context, deepLink.path);
//     }
//
//     FirebaseDynamicLinks.instance.onLink.listen((
//         PendingDynamicLinkData dynamicLinkData) {
//       final Uri deepLink = dynamicLinkData.link;
//       Navigator.pushNamed(context, deepLink.path);
//     }).onError((error) {
//       print('onLink error');
//       print(error.message);
//     });
//   }
// }
//
//
//
//
//
//
//
//
//

import 'package:authenthication/dynamic/product_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'dynamic_link_srevice.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkDynamicLink();
  }

  Future<void> _checkDynamicLink() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay for splash screen

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      if (queryParams.containsKey('productId')) {
        final productId = queryParams['productId'];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => product_screen(id: productId!),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DynamicLinkSrevice(),
        ),
      );
    }
  }
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}