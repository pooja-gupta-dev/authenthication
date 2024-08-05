// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//
//   Future<User?> _signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//
//     if (googleUser != null) {
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       final UserCredential userCredential =
//       await _auth.signInWithCredential(credential);
//
//
//       User? user = userCredential.user;
//       if (user != null) {
//       }
//
//       return user;
//     }
//
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         centerTitle: true,
//         title: Text('Google Sign-In', style: TextStyle(color: Colors.white)),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             User? user = await _signInWithGoogle();
//             if (user != null) {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Profile Information'),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (user.photoURL != null)
//                         Image.network(user.photoURL!),
//                       SizedBox(height: 8),
//                       Text('Name: ${user.displayName ?? "No name"}'),
//                       SizedBox(height: 4),
//                       Text('Email: ${user.email ?? "No email"}'),
//                     ],
//                   ),
//                   actions:[
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Sign_out'),
//
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               print('Login failed.');
//             }
//           },
//           child: Text('Sign in with Google'),
//         ),
//
//       ),
//     );
//   }
// }
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// //
// // class GoogleScreen extends StatelessWidget {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final GoogleSignIn googleSignIn = GoogleSignIn();
// //
// //   Future<User?> _signInWithGoogle() async {
// //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
// //
// //     if (googleUser != null) {
// //       final GoogleSignInAuthentication googleAuth =
// //       await googleUser.authentication;
// //
// //       final credential = GoogleAuthProvider.credential(
// //         accessToken: googleAuth.accessToken,
// //         idToken: googleAuth.idToken,
// //       );
// //
// //       final UserCredential userCredential =
// //       await _auth.signInWithCredential(credential);
// //
// //       User? user = userCredential.user;
// //       return user;
// //     }
// //
// //     return null;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.deepPurple,
// //         centerTitle: true,
// //         title: Text('Google Sign-In', style: TextStyle(color: Colors.white)),
// //       ),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: () async {
// //             User? user = await _signInWithGoogle();
// //             if (user != null) {
// //               showDialog(
// //                 context: context,
// //                 builder: (context) => AlertDialog(
// //                   title: Text('Profile Information'),
// //                   content: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Image.network(
// //                         'https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_2013_Google.png',
// //                         height: 100,
// //                         width: 100,
// //                       ),
// //                       SizedBox(height: 8),
// //                       if (user.photoURL != null)
// //                         Image.network(user.photoURL!, height: 100, width: 100),
// //                       SizedBox(height: 8),
// //                       Text('Name: ${user.displayName ?? "No name"}'),
// //                       SizedBox(height: 4),
// //                       Text('Email: ${user.email ?? "No email"}'),
// //                     ],
// //                   ),
// //                   actions: [
// //                     TextButton(
// //                       onPressed: () {
// //                         Navigator.of(context).pop();
// //                       },
// //                       child: Text('Close'),
// //                     ),
// //                     TextButton(
// //                       onPressed: () async {
// //                         await _auth.signOut();
// //                         await googleSignIn.signOut();
// //                         Navigator.of(context).pop();
// //                       },
// //                       child: Text('Sign out'),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             } else {
// //               print('Login failed.');
// //             }
// //           },
// //           child: Text('Sign in with Google'),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//
//   Future<User?> _signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//
//     if (googleUser != null) {
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       final UserCredential userCredential =
//           await _auth.signInWithCredential(credential);
//
//       User? user = userCredential.user;
//       return user;
//     }
//
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         centerTitle: true,
//         title:
//             const Text('Google Sign-In', style: TextStyle(color: Colors.white)),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             User? user = await _signInWithGoogle();
//             if (user != null) {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Profile Information'),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.network(
//                         'https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_2013_Google.png',
//                         height: 100,
//                         width: 100,
//                       ),
//                       const SizedBox(height: 8),
//                       if (user.photoURL != null)
//                         Image.network(user.photoURL!, height: 100, width: 100),
//                       const SizedBox(height: 8),
//                       Text('Name: ${user.displayName ?? "No name"}'),
//                       const SizedBox(height: 4),
//                       Text('Email: ${user.email ?? "No email"}'),
//                     ],
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Close'),
//                     ),
//                     TextButton(
//                       onPressed: () async {
//                         await _auth.signOut();
//                         await googleSignIn.signOut();
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Sign out'),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               print('Login failed.');
//             }
//           },
//           child: Text('Sign in with Google'),
//         ),
//       ),
//     );
//   }
// }
//



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignandout extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;


        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);


        User? user = userCredential.user;
        return user;
      }


      return null;
    } catch (e) {

      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
      print('Signed out successfully');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff898222999), // Adjust color as needed
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: <Color>[Colors.white, Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            'Google Sign-In',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(240, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () async {
            var user = await _signInWithGoogle();
            if (user != null) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Profile Information'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user.photoURL != null)
                        Image.network(user.photoURL!),
                      SizedBox(height: 8),
                      Text('Name: ${user.displayName ?? "No name"}'),
                      SizedBox(height: 4),
                      Text('Email: ${user.email ?? "No email"}'),
                    ],
                  ),
                  actions: [
                    OutlinedButton(
                      onPressed: () async {
                        await _signOut();
                        Navigator.of(context).pop();
                      },
                      child: Text('Sign Out'),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            } else {
              print('Sign in failed');
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqjph0aZTXAApY940gnEDRx-wjIZuCRF97KBANoTrIVDqcUCYmgeFTiZ25ZUxxznkhtZg&usqp=CAU',
                height: 24.0,
              ),
              SizedBox(width: 10),
              Text('Sign in with Google'),
            ],
          ),
        ),
      ),
    );
  }
}