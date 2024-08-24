// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// class SearchScreen extends StatefulWidget {
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(() {
//       setState(() {
//         _searchQuery = _searchController.text;
//       });
//     });
//   }
//   Future<List<Map<String, dynamic>>> _fetchUsersWithPosts() async {
//     List<Map<String, dynamic>> usersWithPosts = [];
//
//     QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('users').get();
//     for (var userDoc in usersSnapshot.docs) {
//       String userId = userDoc.id;
//       QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
//           .collection('videos')
//           .where('userId', isEqualTo: userId)
//           .get();
//       if (postsSnapshot.docs.isNotEmpty) {
//         Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
//         userData['postCount'] = postsSnapshot.docs.length;
//         usersWithPosts.add(userData);
//       }
//     }
//     return usersWithPosts;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: 'Search users...',
//             hintStyle: TextStyle(color: Colors.black),
//             fillColor: Colors.white,
//             filled: true,
//             prefixIcon: Icon(Icons.search, color: Color(0xff71a08b)),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.teal,
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _fetchUsersWithPosts(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           List<Map<String, dynamic>> users = snapshot.data!;
//           if (_searchQuery.isNotEmpty) {
//             users = users.where((user) {
//               final name = user['name']?.toLowerCase() ?? '';
//               return name.contains(_searchQuery.toLowerCase());
//             }).toList();
//           }
//
//           if (users.isEmpty) {
//             return Center(child: Text('No users with posts found.'));
//           }
//           return ListView.builder(
//             padding: EdgeInsets.all(8.0),
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               var user = users[index];
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: CachedNetworkImageProvider(user['imageUrl'] ?? ''),
//                 ),
//                 title: Text(user['name'] ?? 'Unknown'),
//                 subtitle: Text('${user['postCount']} posts'),
//                 onTap: () {
//                   // Handle user profile navigation if needed
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//}

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
        isSearching = _searchQuery.isNotEmpty;
      });
    });
  }

  Future<List<Map<String, dynamic>>> _fetchPostsWithUsers() async {
    List<Map<String, dynamic>> postsWithUsers = [];
    try {
      QuerySnapshot postsSnapshot = await FirebaseFirestore.instance.collection('videos').get();
      for (var postDoc in postsSnapshot.docs) {
        Map<String, dynamic> postData = postDoc.data() as Map<String, dynamic>;
        if (postData.containsKey('userId')) {
          String userId = postData['userId'];
          DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
          if (userDoc.exists) {
            Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
            postData['userName'] = userData['name'] ?? 'Unknown';
            postData['userImageUrl'] = userData['imageUrl'] ?? '';
            postData['videoId'] = postData['videoId'] ?? '';
            postData['thumbnailUrl'] = postData['thumbnailUrl'] ?? '';
            postData['title'] = postData['title'] ?? 'No Title';
            postsWithUsers.add(postData);
          }
        }
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
    return postsWithUsers;
  }

  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    List<Map<String, dynamic>> usersList = [];
    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('users').get();
      for (var userDoc in usersSnapshot.docs) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        usersList.add({
          'userId': userDoc.id,
          'userName': userData['name'] ?? 'Unknown',
          'userImageUrl': userData['imageUrl'] ?? '',
        });
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
    return usersList;
  }

  Future<String?> _generateThumbnail(String videoUrl) async {
    try {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 300,
        quality: 75,
      );
      return thumbnailPath;
    } catch (e) {
      print("Error generating thumbnail: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search users...',
            hintStyle: const TextStyle(color: Colors.black),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.search, color: Color(0xff71a08b)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: isSearching
          ? FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          List<Map<String, dynamic>> users = snapshot.data!;
          if (_searchQuery.isNotEmpty) {
            users = users.where((user) {
              final userName = user['userName']?.toLowerCase() ?? '';
              return userName.contains(_searchQuery.toLowerCase());
            }).toList();
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(user['userImageUrl'] ?? ''),
                  child: user['userImageUrl'] == null ? Icon(Icons.person) : null,
                ),
                title: Text(user['userName'] ?? 'Unknown'),

              );
            },
          );
        },
      )
          : FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchPostsWithUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts found.'));
          }

          List<Map<String, dynamic>> posts = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              var post = posts[index];
              return GridTile(
                header: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(post['userImageUrl'] ?? ''),
                    child: post['userImageUrl'] == null ? Icon(Icons.person) : null,
                  ),
                  title: Text(post['userName'] ?? 'Unknown'),
                ),
                child: FutureBuilder<String?>(
                  future: _generateThumbnail(post['videoUrl'] ?? ''),
                  builder: (context, thumbnailSnapshot) {
                    if (thumbnailSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (thumbnailSnapshot.hasError || !thumbnailSnapshot.hasData) {
                      return Center(child: Icon(Icons.error));
                    }
                    return GestureDetector(
                      onTap: () {
                        // Handle video tap here
                      },
                      child: Image.file(
                        File(thumbnailSnapshot.data!),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}