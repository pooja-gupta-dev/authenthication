import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../controllers/insta_auth_controller.dart';
import '../controllers/users_controller.dart';
import '../reels/uplaod_video.dart';
import '../settings/setting_screen.dart';
import 'edit_profile.dart';
class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserController userController = Get.put(UserController());
  final InstaAuthController authController = Get.put(InstaAuthController());
  int postCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchPostCount();
  }

  Future<void> _fetchPostCount() async {
    try {
      final videoSnapshot = await FirebaseFirestore.instance
          .collection('videos')
          .where('userId', isEqualTo: userController.user.value.id)
          .get();
      setState(() {
        postCount = videoSnapshot.docs.length;
      });
    } catch (e) {
      print("Error fetching post count: $e");
    }
  }

  Future<String?> _generateThumbnail(String videoUrl) async {
    try {
      final fileName = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 100,
        quality: 75,
      );
      return fileName;
    } catch (e) {
      print("Error generating thumbnail: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userController.userData.name ?? 'Username',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Text("Upload"),
          IconButton(
            onPressed: () {
              Get.to(() => VideoUploadScreen(
                onVideoUploaded: _refreshProfileScreen,
              ));
            },
            icon: Icon(Icons.add_box_outlined),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Obx(() {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: userController.userData.imageUrl != null
                        ? NetworkImage(userController.userData.imageUrl!)
                        : null,
                    child: userController.user.value.imageUrl == null
                        ? Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                   child:

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildProfileStat('Posts', postCount.toString()),
                            _buildProfileStat(
                                'Followers',
                                        userController.userData.followers?.length
                                    .toString() ??
                                    "0"),
                            _buildProfileStat(
                                'Following',
                                     userController.userData.following?.length
                                    .toString() ??
                                    "0"),


                        SizedBox(height: 20),
    ]
                    ),
                  ),
                ],
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.to(() => EditProfileScreen());},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 12),
                  ),
                ),

                SizedBox(width:5),
                // Adjust spacing between buttons
                // Adjust the width as needed
                Padding(
                  padding: const EdgeInsets.only(),
                  child: OutlinedButton(
                    onPressed: () {
                      Get.to(const SettingScreen());
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Account Setting',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),

              ],
            ),
          ),

          // Post Grid
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('videos')
                  .where('userId', isEqualTo: userController.user.value.id)
                  .snapshots(),
              builder: (context, snapshot) {
                final videoDocs = snapshot.data?.docs ?? [];

                if (videoDocs.isEmpty) {
                  return Center(child: Text('No videos uploaded yet.'));
                }

                return GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: videoDocs.length,
                  itemBuilder: (context, index) {
                    final videoData = videoDocs[index];
                    final videoUrl = videoData['videoUrl'];
                    return FutureBuilder<String?>(
                      future: _generateThumbnail(videoUrl),
                      builder: (context, snapshot) {
                        final thumbnailPath = snapshot.data;

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => VideoPlaybackScreen(videoUrl: videoUrl));
                          },
                          child: thumbnailPath != null
                              ? Image.file(File(thumbnailPath), fit: BoxFit.cover)
                              : Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Icon(Icons.play_circle_outline,
                                  size: 50, color: Colors.black),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String title, String count) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  _refreshProfileScreen() {
    _fetchPostCount(); // Refresh the post count when a new video is uploaded
    setState(() {});
  }
}


class VideoPlaybackScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlaybackScreen({required this.videoUrl});

  @override
  _VideoPlaybackScreenState createState() => _VideoPlaybackScreenState();
}

class _VideoPlaybackScreenState extends State<VideoPlaybackScreen> {
  late VideoPlayerController _controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      isPlaying = !isPlaying;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Playback'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
          onTap: _togglePlayPause,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: VideoPlayer(_controller),
          ),
        )
            : CupertinoActivityIndicator(),
      ),
    );
  }
}