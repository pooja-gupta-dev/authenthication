// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../instagram_project/controllers/users_controller.dart';
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final UserController userController = Get.put(UserController());
//   final AuthController authController = Get.put(AuthController());
//
//   Future<int> _getVideoCount(String userId) async {
//     try {
//       final videoSnapshot = await FirebaseFirestore.instance
//           .collection('videos')
//           .where('userId', isEqualTo: userId)
//           .get();
//       return videoSnapshot.docs.length;
//     } catch (e) {
//       print("Error fetching video count: $e");
//       return 0;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               if (value == 'logout') {
//                 FirebaseAuth.instance.signOut();
//                 Get.offAll(()=>LoginScreen());
//               }
//             },
//             itemBuilder: (BuildContext context) {
//               return {'logout'}.map((String choice) {
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text(choice),
//                 );
//               }).toList();
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
//             ),
//             child: Obx(() {
//               return Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: userController.userData.imageUrl != null
//                         ? NetworkImage(userController.userData.imageUrl!)
//                         : null,
//                     child: userController.user.value.imageUrl == null
//                         ? Icon(Icons.person, size: 50, color: Colors.grey)
//                         : null,
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           userController.userData.name ?? 'Username',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 24,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildProfileStat('Posts', "0"),
//                             _buildProfileStat('Followers', userController.userData.followers?.length.toString() ?? "0"),
//                             _buildProfileStat('Following',  userController.userData.following?.length.toString() ?? "0"),
//                           ],
//                         ),
//                         SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             OutlinedButton(
//                               onPressed: () {
//                                 Get.to(() => EditProfileScreen());
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                               child: Text('Edit Profile'),
//                             ),
//                             OutlinedButton(
//                               onPressed: () {
//                                 Get.to(() => VideoUploadScreen(
//                                   onVideoUploaded: _refreshProfileScreen,
//                                 ));
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                               child: Text('Add Video Post'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//             ),
//           ),
//           // Post Grid
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('videos')
//                   .where('userId', isEqualTo: userController.user.value.id)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 // if (!snapshot.hasData) {
//                 //   return Center(child: CircularProgressIndicator());
//                 // }
//
//                 final videoDocs = snapshot.data?.docs ?? [];
//
//                 if (videoDocs.isEmpty) {
//                   return Center(child: Text('No videos uploaded yet.'));
//                 }
//
//                 return GridView.builder(
//                   padding: EdgeInsets.all(8.0),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 4.0,
//                     mainAxisSpacing: 4.0,
//                   ),
//                   itemCount: videoDocs.length,
//                   itemBuilder: (context, index) {
//                     final videoData = videoDocs[index];
//                     final videoUrl = videoData['videoUrl'];
//                     return GestureDetector(
//                       onTap: () {
//                         Get.to(() => VideoPlaybackScreen(videoUrl: videoUrl));
//                       },
//                       child: Container(
//                         color: Colors.grey[300],
//                         child: Center(
//                           child: Icon(Icons.play_circle_outline,
//                               size: 50, color: Colors.black),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       // body: FutureBuilder<int>(
//       //     future: _getVideoCount(user.id!),
//       //     builder: (context, videoCountSnapshot) {
//       //       if (videoCountSnapshot.connectionState == ConnectionState.waiting) {
//       //         return Center(child: CircularProgressIndicator());
//       //       }
//       //
//       //       if (videoCountSnapshot.hasError) {
//       //         return Center(child: Text('Error fetching video count.'));
//       //       }
//       //
//       //       final videoCount = videoCountSnapshot.data ?? 0;
//       //
//       //       return ;
//       //     },
//       //   );
//     );
//   }
//
//   Widget _buildProfileStat(String title, String count) {
//     return Column(
//       children: [
//         Text(
//           count,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
//
//   _refreshProfileScreen() {
//     setState(() {
//
//     });
//   }
// }