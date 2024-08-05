
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleMap extends StatelessWidget {
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