
import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../comment/comment_screen.dart';
import '../controllers/users_controller.dart';
import '../model/insta_model.dart';


class ReelsScreen extends StatefulWidget {
  @override
  _ReelsScreenState createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  PageController _pageController = PageController();
  List<DocumentSnapshot> videoDocs = [];
  var userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    try {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('videos').get();
      setState(() {
        videoDocs = snapshot.docs;
      });
    } catch (e) {
      print("Error fetching videos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: videoDocs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videoDocs.length,
        itemBuilder: (context, index) {
          final videoData = videoDocs[index];
          final videoUrl = videoData['videoUrl'];
          final userId = videoData['userId'];

          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CupertinoActivityIndicator());
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(child: Text('User data not found'));
              }

              final userData =
              snapshot.data!.data() as Map<String, dynamic>;
              final username = userData['name'] ?? 'Unknown User';
              final profileUrl = userData['imageUrl'] ??
                  'https://www.example.com/default_profile.png';
              var authorData = UserModel.fromJson(userData);

              return VideoPlayerItem(
                videoUrl: videoUrl,
                username: username,
                profileUrl: profileUrl,
                authorId: userId,
                followers: authorData.followers ?? [],
                following: authorData.following ?? [],
                userController: userController,
                videoId: videoData.id,
                description: videoData['description'] ?? 'No description',
              );
            },
          );
        },
      ),
    );
  }

}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String username;
  final String profileUrl;
  final String authorId;
  final List<String> followers;
  final List<String> following;
  final UserController userController;
  final String videoId;
  final String description;

  VideoPlayerItem({
    required this.videoUrl,
    required this.username,
    required this.profileUrl,
    required this.authorId,
    required this.followers,
    required this.following,
    required this.userController,
    required this.videoId,
    required this.description,
  });

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  RxBool isPlaying = true.obs;
  RxBool isLiked = false.obs;
  RxInt likeCount = 0.obs;
  RxInt commentCount = 0.obs;
  RxBool isFollowing = false.obs;
  RxBool isProcessingFollow = false.obs; // To manage follow/unfollow state

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          aspectRatio: _controller.value.aspectRatio,
          autoPlay: true,
          looping: true,
          showControls: false,
        );
        _controller.play();
        fetchLikeStatus();
        fetchLikeCount();
        fetchCommentCount();
        _checkIfFollowing(); // Check follow status on init
      });
  }

  Future<void> _checkIfFollowing() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      setState(() {
        isFollowing.value = widget.following.contains(userId);
      });
    } catch (e) {
      print("Error checking follow status: $e");
    }
  }

  Future<void> toggleFollow() async {
    if (isProcessingFollow.value) return; // Prevent multiple actions

    setState(() {
      isProcessingFollow.value = true; // Start processing
    });

    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      setState(() {
        isProcessingFollow.value = false; // Done processing
      });
      return;
    }

    try {
      if (isFollowing.value) {
        // Unfollow logic
        await widget.userController.removeFromFollowing(widget.authorId);
        setState(() {
          isFollowing.value = false;
        });
      } else {
        // Follow logic
        await widget.userController.addToFollowing(widget.authorId);
        setState(() {
          isFollowing.value = true;
        });
      }
    } catch (e) {
      print("Error toggling follow state: $e");
    } finally {
      setState(() {
        isProcessingFollow.value = false; // Done processing
      });
    }
  }

  Future<void> fetchCommentCount() async {
    try {
      QuerySnapshot commentSnapshot = await FirebaseFirestore.instance
          .collection('videos')
          .doc(widget.videoId)
          .collection('comments')
          .get();

      setState(() {
        commentCount.value = commentSnapshot.size;
      });
    } catch (e) {
      print("Error fetching comment count: $e");
    }
  }

  Future<void> fetchLikeStatus() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      DocumentSnapshot videoSnapshot = await FirebaseFirestore.instance
          .collection('videos')
          .doc(widget.videoId)
          .get();

      List<dynamic> likes = videoSnapshot['likes'] ?? [];
      setState(() {
        isLiked.value = likes.contains(userId);
      });
    } catch (e) {
      print("Error fetching like status: $e");
    }
  }

  Future<void> fetchLikeCount() async {
    try {
      DocumentSnapshot videoSnapshot = await FirebaseFirestore.instance
          .collection('videos')
          .doc(widget.videoId)
          .get();

      setState(() {
        likeCount.value = videoSnapshot['likeCount'] ?? 0;
      });
    } catch (e) {
      print("Error fetching like count: $e");
    }
  }

  Future<void> toggleLike() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    setState(() {
      isLiked.value = !isLiked.value;
    });

    try {
      if (isLiked.value) {
        await widget.userController.addToFollowing(widget.authorId,);
        setState(() {
          likeCount.value++;
        });
      } else {
        await widget.userController.removeFromFollowing(widget.authorId,);
        setState(() {
          likeCount.value--;
        });
      }
    } catch (e) {
      print("Error toggling like status: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      isPlaying.value = !isPlaying.value;
      if (isPlaying.value) {
        _controller.play();
      } else {
        _controller.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: togglePlayPause,
            child: _controller.value.isInitialized
                ? Chewie(controller: _chewieController!)
                : Center(child: CupertinoActivityIndicator(color: Colors.white)),
          ),
          if (!isPlaying.value)
            Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 80.0,
              ),
            ),
          Positioned(
            left: 16.0,
            bottom: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.profileUrl),
                      radius: 20.0,
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.username,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: isProcessingFollow.value ? null : toggleFollow,
                      child: isProcessingFollow.value
                          ? CircularProgressIndicator()
                          : Text(
                        isFollowing.value ? "Following" : "Follow",
                        style: TextStyle(
                          color: isFollowing.value ? Colors.teal : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  widget.description,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            right: 16.0,
            bottom: 60.0,
            child: Column(
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked.value ? Icons.favorite : Icons.favorite_border,
                        color: isLiked.value ? Colors.red : Colors.white,
                      ),
                      onPressed: toggleLike,
                    ),
                    Text(
                      '${likeCount.value}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                IconButton(
                  icon: Icon(Icons.comment, color: Colors.white),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          CommentScreen(videoId: widget.videoId),
                      isScrollControlled: true,
                    );
                  },
                ),
                Text(
                  '${commentCount.value}',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    // Handle share action
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

