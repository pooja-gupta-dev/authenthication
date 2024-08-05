import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InstaHomeScreen extends StatefulWidget {
  final User user;

  InstaHomeScreen({required this.user});

  @override
  _InstaHomeScreenState createState() => _InstaHomeScreenState();
}

class _InstaHomeScreenState extends State<InstaHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No posts available.'));
          }
          final posts = snapshot.data!.docs;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final videoUrl = post['videoUrl'];
              final likes = post['likes'] as int;
              final comments = List<String>.from(post['comments'] ?? []);

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  children: [
                    // Display video (use a widget to play video or show thumbnail)
                    Container(
                      height: 200,
                      color: Colors.black,
                      child: Center(child: Text('Video placeholder', style: TextStyle(color: Colors.white))),
                    ),
                    SizedBox(height: 8.0),
                    Text('Likes: $likes'),
                    SizedBox(height: 8.0),
                    Text('Comments: ${comments.length}'),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle like functionality
                      },
                      child: Text('Like'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle comment functionality
                      },
                      child: Text('Comment'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}