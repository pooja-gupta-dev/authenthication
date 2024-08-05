// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'login.dart';
//
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Center(child: Text("HomePage")),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 20,),
//           Image.network(
//               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOEmJaV1cos8i_dFz4sqZRZh4Pxc1ZVsxSQA&s"
//           ),
//           SizedBox(height: 50),
//           ElevatedButton(onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => Login(),));
//             FirebaseAuth.instance.signOut();
//             var auth = FirebaseAuth.instance;
//             if (auth.currentUser == null) {
//               auth.signOut();
//             }
//           }, child: Text("Sing out")),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.indigo,
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}