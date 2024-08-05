// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class ImageScreen extends StatefulWidget {
//   const ImageScreen({super.key});
//
//   @override
//   State<ImageScreen> createState() => _ImageScreenState();
// }
//
// class _ImageScreenState extends State<ImageScreen> {
//   File? selectedImage;
//   List<File> image = <File>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Image Screen"),
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: (){
//         takeMultiImage();
//       },child: Icon(Icons.add),),
//       body: StreamBuilder(
//         stream: getUploadedImage(),
//         builder: (context, snapshot) {
//           var imageD = snapshot.data?.docs;
//           if (imageD?.isNotEmpty == true) {
//             return ListView.builder(
//               itemCount: imageD?.length,
//               itemBuilder: (context, index) {
//                 return
//                   Container(
//                     height: 800,
//                     width: 100,
//                     color: Colors.blue,
//                     child: Image.network(imageD![index]['url']),
//                     //
//                   );
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
//   takeMultiImage() async {
//     FilePickerResult? pikerImage = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//     );
//     if (pikerImage != null) {
//       var file = pikerImage.files.map((path) => File(path.path!)).toList();
//       for (var multiImage in file) {
//         uploadImage(multiImage);
//         print(multiImage.path);
//       }
//       // setState(() {
//       //   image.addAll(file);
//       // });
//       print(file.first.path);
//     } else {}
//   }
//
//   uploadImage(File file) {
//     var storage = FirebaseStorage.instance;
//     storage
//         .ref("FOLDER-VIDEO")
//         .child(file.path.split("/").last)
//         .putFile(File(file.path))
//         .then((value) async {
//       var videoUrl = await value.ref.getDownloadURL();
//       print(videoUrl);
//       FirebaseFirestore.instance.collection("video").add({"url": videoUrl});
//       Fluttertoast.showToast(msg: "image uploaded");
//     });
//   }
//
//   Stream<QuerySnapshot<Map<String, dynamic>>> getUploadedImage() {
//     var instance = FirebaseFirestore.instance.collection("image");
//     return instance.snapshots();
//   }
// }
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text("Images"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectImageFile();
        },
        child: const Icon(
          Icons.add_a_photo,
          color: Colors.deepOrangeAccent,
        ),
      ),
      body: StreamBuilder(
        stream: getUploadedImages(),
        builder: (context, snapshot) {
          var images = snapshot.data?.docs;
          if (images?.isNotEmpty == true) {
            return ListView.builder(
              itemCount: images?.length,
              itemBuilder: (context, index) {
                return showImageView(images![index].data()['url']);
              },
            );
          } else {
            return const Center(
              child: Text("No image found!", style: TextStyle(color: Colors.white38),),
            );
          }
        },
      ),
    );
  }

  selectImageFile() async {
    var result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image);
    if (result != null) {
      var files = result.files.map((value) => File(value.path!)).toList();
      for (var singleFile in files) {
        uploadImage(singleFile);
        print(singleFile.path);
      }
      print(files.first.path);
    }
  }

  uploadImage(File file) {
    var storage = FirebaseStorage.instance;
    storage
        .ref("Images")
        .child(file.path.split("/").last)
        .putFile(file)
        .then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      print(imageUrl);
      FirebaseFirestore.instance.collection("images").add({"url": imageUrl});
      Fluttertoast.showToast(msg: "Image Uploaded");
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUploadedImages() {
    var instance = FirebaseFirestore.instance.collection("images");
    return instance.snapshots();
  }

  showImageView(String imagePath) {
    return SizedBox(
      height: 480,
      child: Image.network(imagePath),
    );
  }
}