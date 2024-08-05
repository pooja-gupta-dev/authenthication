import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MultipleScreen extends StatefulWidget {
  const MultipleScreen({super.key});

  @override
  State<MultipleScreen> createState() => _MultipleScreenState();
}

class _MultipleScreenState extends State<MultipleScreen> {
  File? multiImages;
  List<File>? multiFiles = <File>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload file",style: TextStyle(fontSize: 18,color: Colors.white),),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Container(
                height: 200,
                width: 200,
                child: multiImages != null? Image.file(multiImages!):Icon(Icons.image)
            ),


            Expanded(child:
            ListView.builder(
              itemCount: multiFiles?.length,
              itemBuilder: (context, index) {
                return Image.file(multiFiles![index]);
              },)
            ),

            ElevatedButton(onPressed: () {
              takeSingleFile();
            }, child: Text("Take Single File")),

            ElevatedButton(onPressed: () {
              takeMultipleFile();
            }, child: Text("Take Multiple File")),


          ],
        )
    );
  }



  takeSingleFile()async{
    FilePickerResult? fileResult = await  FilePicker.platform.pickFiles();
    if(fileResult != null){
      var  file = File(fileResult.files.single.path!);
      setState(() {
        multiImages = file;
      });
      uploadImage(file);
    }
  }

  takeMultipleFile()async{
    FilePickerResult? fileResult = await  FilePicker.platform.pickFiles(allowMultiple: true);
    if(fileResult != null){
      var files = fileResult.files.map((path) => File(path.path!)).toList();
      for(var singleFile in files){
        multiFiles?.add(singleFile);
      }
      setState(() {

      });
    }
  }

  uploadImage(File file){
    var storage = FirebaseStorage.instance;
    storage.ref("files").child(file.path.split("/").last).putFile(file).then((value)async {
      var imageUrl = await value.ref.getDownloadURL();
      print(imageUrl);
      Fluttertoast.showToast(msg:"Image uploaded");
    });
  }

}