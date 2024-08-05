// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UploadImageScreen extends StatefulWidget {
//   const UploadImageScreen({super.key});
//
//   @override
//   State<UploadImageScreen> createState() => _UploadImageScreenState();
// }
//
// class _UploadImageScreenState extends State<UploadImageScreen> {
//   XFile? imageFile;
//   List<File>? multipalFile ;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Center(child: Text("Upload Image",style: TextStyle(color: Colors.white),)),
//       ),
//       body: Column(
//         children: [
//           Icon(Icons.camera,size: 100,color: Colors.deepOrange,),
//           Center(child: Padding(padding: EdgeInsets.all(8.0))),
//           ElevatedButton(onPressed: (){
//           }, child: Text(" Take image")),
//           ElevatedButton(onPressed: (){
//
//           }, child: Text("Upload image"))
//         ],
//       ),
//     );
//   }
//   takeFile()async{
//     var fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
//     if(fileResult!= null){
//       var files = fileResult.files.map ((path)=>File(path.path!)).toList();
//       for(var singleFile in files){
//         multipalFile?.add(singleFile);
//         setState(() {
//
//         });
//       }
//     }
//     uploading(File file){
//       var storage = FirebaseStorage.instance;
//       storage.ref("profileImages").child(file.path.split("/").last).putFile(file).then((value)async {
//         var imageUrl = await value.ref.getDownloadURL();
//         print(imageUrl);
//       }
//       );
//     }
//
//
//   }
//   takeImage() async {
//     try {
//       var imagePicker = ImagePicker();
//       var image = await imagePicker.pickImage(source: ImageSource.gallery);
//       setState(() {
//         imageFile = image!;
//       });
//
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error picking image: $e");
//     }
//   }
//   var imageUrl = "";
// }
//
// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// class UploadImageScreen extends StatefulWidget {
//   const UploadImageScreen({super.key});
//
//   @override
//   State<UploadImageScreen> createState() => _UploadImageScreenState();
// }
//
// class _UploadImageScreenState extends State<UploadImageScreen> {
//   File? selectedImage;
//   List<File> image =<File>[];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         title: Text("MultiPal File"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.deepPurpleAccent,
//               height: 200,
//               width: 200,
//               child:selectedImage != null
//              ? Image.file(
//             selectedImage!,
//           fit: BoxFit.cover,
//         )
//       :const Icon(Icons.image,size: 100,color: Colors.white,),
//             ),
//     SizedBox(height: 20,),
//     ElevatedButton(
//     onPressed: (){
//       takeSingleImage();
//     },
//     child: Text("Single Image")),
//     Expanded(child: ListView.builder(
//     itemCount: image.length,
//     itemBuilder: (context,index){
//       return Container(
//       height: 800,
//       width: 100,
//     color: Colors.blue,
//     child: Column(
//     children: [
//       Image.file(
//     image[index],
//     fit: BoxFit.contain,
//     )
//     ],
//     ),
//       );
//     })
//     ),
//     SizedBox(height: 20,),
//             ElevatedButton(
//                 onPressed: (){
//                   takeSingleImage();
//                 },
//                 child: Text("Multipal Image"))
//           ],
//         ),
//       ),
//     );
//   }
//   takeSingleImage()async{
//    FilePickerResult? pikerImage = await FilePicker.platform.pickFiles();
//    if(pikerImage != null){
//      File file = File(pikerImage.files.single.path!);
//      setState(() {
//        selectedImage = file;
//      });
//      uploadImage(file);
//    }else{}
//   }
//   uploadImage(File file){
//     var storage = FirebaseStorage.instance;
//     storage.ref("ProfileImage").child(file.path.split("/").last).putFile(File(file.path)).then((value)async {
//       var imageUrl = await value.ref.getDownloadURL();
//       print("imageUrl");
//       Fluttertoast.showToast(msg: "Image Upload");
//     });
//   }
// }

import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadedImagesScreen extends StatefulWidget {
  const UploadedImagesScreen({super.key});

  @override
  State<UploadedImagesScreen> createState() => _UploadedImagesScreenState();
}

class _UploadedImagesScreenState extends State<UploadedImagesScreen> {
  File? multiImages;
  bool isLoading = false;
  List<File>? multiFiles = <File>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: const Text("~* MultiPal Image *~",style: TextStyle(color: Colors.white),)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: multiImages != null
                  ? Image.file(multiImages!)
                  : Icon(Icons.image,size: 100,color:Colors.purple ,),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                takeImage();
              },
              child: const Text("single Image")),
          const SizedBox(height: 20),
          Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: multiFiles!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Image.file(multiFiles![index]),
                  );
                },
              )),
          ElevatedButton(
              onPressed: () {
                takeMultiFile();
              },
              child: const Text("Multipart Image"))
        ],
      ),
    );
  }

  Future<void> takeImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        setState(() {
          multiImages = file;
        });
        uploadData(file);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error picking image: $e");
    }
  }

  takeMultiFile() async {
    var fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
      var files = fileResult.files.map((path) => File(path.path!)).toList();
      for (var singleFile in files) {
        multiFiles?.add(singleFile);
        setState(() {});
        uploadData(singleFile);
      }
    }
  }

  Future<void> uploadData(File file) async {
    try {
      // Upload image to Firebase Storage
      var storage = FirebaseStorage.instance;

      var storageRef = storage.ref("Images").child(file.path.split("/").last);

      var uploadTask = storageRef.putFile(File(file.path));
      await uploadTask;
      Fluttertoast.showToast(msg: "Data uploaded successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error uploading data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}