// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:video_player/video_player.dart';
// // import 'package:video_player/video_player.dart';
//
// class VideoScreen extends StatefulWidget {
//   VideoScreen({super.key});
//
//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   File? selectedVideo;
//   List<File> video = <File>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("VIDEO Screen"),
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: (){
//         takeMultiVideo();
//       },child: Icon(Icons.add),),
//       body: StreamBuilder(
//         stream: getUploadedVideo(),
//         builder: (context, snapshot) {
//           var video = snapshot.data?.docs;
//           if (video?.isNotEmpty == true) {
//             return ListView.builder(
//               itemCount: video?.length,
//               itemBuilder: (context, index) {
//                 return  Container(
//                   height: 800,
//                   width: 100,
//                   color: Colors.blue,
//                   child: VideoApp(videoUrl: video![index]['url'],),
//                   //
//                 );
//
//               },
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   takeMultiVideo() async {
//     FilePickerResult? pikerVideo = await FilePicker.platform.pickFiles(
//         allowMultiple: true,
//         type: FileType.video
//     );
//     if (pikerVideo != null) {
//       var file = pikerVideo.files.map((path) => File(path.path!)).toList();
//       for (var multiVideo in file) {
//         uploadVideo(multiVideo);
//         print(multiVideo.path);
//       }
//       // setState(() {
//       //   image.addAll(file);
//       // });
//       print(file.first.path);
//     } else {}
//   }
//
//   uploadVideo(File file) {
//     var storage = FirebaseStorage.instance;
//     storage
//         .ref("FOLDER-Video")
//         .child(file.path.split("/").last)
//         .putFile(File(file.path))
//         .then((value) async {
//       var imageUrl = await value.ref.getDownloadURL();
//       print(imageUrl);
//       FirebaseFirestore.instance.collection("video").add({"url": imageUrl});
//       Fluttertoast.showToast(msg: "video uploaded");
//     });
//   }
//
//   Stream<QuerySnapshot<Map<String, dynamic>>> getUploadedVideo() {
//     var instance = FirebaseFirestore.instance.collection("video");
//     return instance.snapshots();
//   }
//
//
// }
//
//
//
// class VideoApp extends StatefulWidget {
//   final String videoUrl;
//   const VideoApp({super.key, required this.videoUrl});
//
//   @override
//   _VideoAppState createState() => _VideoAppState();
// }
//
// class _VideoAppState extends State<VideoApp> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(
//         widget.videoUrl))
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Demo',
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: _controller.value.isInitialized
//               ? AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           )
//               : Container(),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _controller.value.isPlaying
//                   ? _controller.pause()
//                   : _controller.play();
//             });
//           },
//           child: Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Videos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectVideoFile();
        },
        child: const Icon(
          Icons.video_collection,
          color: Colors.deepOrangeAccent,
        ),
      ),
      body: StreamBuilder(
        stream: getUploadedVideos(),
        builder: (context, snapshot) {
          var videos = snapshot.data?.docs;
          if (videos?.isNotEmpty == true) {
            return ListView.builder(
              itemCount: videos?.length,
              itemBuilder: (context, index) {
                return showVideoView(videos![index].data()['url']);
              },
            );
          } else {
            return const Center(
              child: Text("No video found!", style: TextStyle(color: Colors.white38),),
            );
          }
        },
      ),
    );
  }

  selectVideoFile() async {
    var result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.video);
    if (result != null) {
      var files = result.files.map((value) => File(value.path!)).toList();
      for (var singleFile in files) {
        uploadVideo(singleFile);
        print(singleFile.path);
      }
      print(files.first.path);
    }
  }

  uploadVideo(File file) {
    var storage = FirebaseStorage.instance;
    storage
        .ref("Videos")
        .child(file.path.split("/").last)
        .putFile(file)
        .then((value) async {
      var videoUrl = await value.ref.getDownloadURL();
      print(videoUrl);
      FirebaseFirestore.instance.collection("videos").add({"url": videoUrl});
      Fluttertoast.showToast(msg: "Video Uploaded");
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUploadedVideos() {
    var instance = FirebaseFirestore.instance.collection("videos");
    return instance.snapshots();
  }

  showVideoView(String videoPath) {
    return SizedBox(
      height: 480,
      child: VideoPlayerWidget(url: videoPath),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  const VideoPlayerWidget({required this.url, Key? key}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Center(child: CircularProgressIndicator());
  }
}