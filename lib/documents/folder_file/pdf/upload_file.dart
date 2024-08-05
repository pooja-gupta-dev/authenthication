// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
//
// class UploadFile extends StatefulWidget {
//   const UploadFile({super.key});
//
//   @override
//   State<UploadFile> createState() => _UploadFileState();
// }
//
// class _UploadFileState extends State<UploadFile> {
//   List<File> multiFile =<File>[];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload file"),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//               onPressed: (){
//              takeFile();
//           }, child: Text("take file")),
//     ]),
//     );
//   }
//   takeFile()async{
//     var fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
//     if(fileResult!=null){
//       var files = fileResult.files.map((path)=>File(path.path!)).toList();
//       for (var singleFile in files){
//         var a = singleFile .path.split(".").last;
//         if(a=="jpg"||a=="png"){
//           // add in image list
//         }
//         if(a=="mp4"||a=="mkv"){
//           //add in video list
//         }
//         print("Extensions:a");
//         multiFile.add(singleFile);
//         //uploadImage(singlefile);
//       }
//       setState(() {
//
//       });
//     }
//   }
//   UploadFile(File file){
//     var storage =FirebaseStorage.instance;
//     storage.ref("profileImages").child(file.path.split(".").last)
//         .putFile(file).then((value) async{
//       var imageUrl=await value.ref.getDownloadURL();
//       print(imageUrl);
//
//     });
//   }
// }
