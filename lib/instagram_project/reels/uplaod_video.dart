import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

import '../controllers/insta_auth_controller.dart';



class VideoUploadScreen extends StatefulWidget {
  final Function onVideoUploaded;

  VideoUploadScreen({required this.onVideoUploaded});

  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  final InstaAuthController authController = Get.find<InstaAuthController>();
  final ImagePicker _picker = ImagePicker();
  XFile? videoFile;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        videoFile = pickedFile;
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (videoFile != null && _descriptionController.text.isNotEmpty) {
      try {
        final storageRef = FirebaseStorage.instance.ref().child('videos').child('${DateTime.now().toIso8601String()}.mp4');
        final uploadTask = storageRef.putFile(File(videoFile!.path));
        final snapshot = await uploadTask;
        final videoUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('videos').add({
          'userId':FirebaseAuth.instance.currentUser?.uid,
          'videoUrl': videoUrl,
          'description': _descriptionController.text,
          'timestamp': Timestamp.now(),
        });

        widget.onVideoUploaded();

        Get.back();
      } catch (e) {
        print('Failed to upload video: $e');
        Get.snackbar('Error', 'Failed to upload video. Please try again.');
      }
    } else {
      Get.snackbar('Error', 'Please pick a video and enter a description.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Video Post'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: videoFile == null
                  ? Icon(Icons.videocam, size: 100, color: Colors.grey)
                  : Container(
                width: 300,
                height: 300,
                child: VideoPlayer(VideoPlayerController.file(File(videoFile!.path))),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _uploadVideo,
                child: Text('Upload Video'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickVideo,
        child: Icon(Icons.video_library),
      ),
    );
  }
}