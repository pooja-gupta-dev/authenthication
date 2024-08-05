import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'insta_home_screen.dart';




class InstaVideoUploadScreen extends StatefulWidget {
  final User user;

  InstaVideoUploadScreen({required this.user});

  @override
  _InstaVideoUploadScreenState createState() => _InstaVideoUploadScreenState();
}

class _InstaVideoUploadScreenState extends State<InstaVideoUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Video'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Here you would handle the video upload logic

            // After uploading video, navigate to HomeScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => InstaHomeScreen(user: widget.user),
              ),
            );
          },
          child: Text('Upload Video'),
        ),
      ),
    );
  }
}