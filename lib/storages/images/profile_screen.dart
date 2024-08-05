// // import 'dart:ffi';
// // import 'dart:io';
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// //
// // class profileScreen extends StatefulWidget {
// //   const profileScreen({super.key});
// //
// //   @override
// //   State<profileScreen> createState() => _profileScreenState();
// // }
// //
// // class _profileScreenState extends State<profileScreen> {
// //
// //   XFile? imageFile;
// //   final TextEditingController nameController=TextEditingController();
// //   final TextEditingController emailController=TextEditingController();
// //   final TextEditingController phoneController=TextEditingController();
// //   final TextEditingController ageController=TextEditingController();
// //   bool isLoading = false;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.cyan,
// //       appBar: AppBar(title: Text("PROFILE"),
// //       ),
// //       body: isLoading?Center(
// //         child: CircularProgressIndicator(),):SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.all(20),
// //           child: Column(
// //             children: [
// //               GestureDetector(
// //                 onTap: takeImage,
// //                 child:CircleAvatar(
// //                   radius: 50,
// //                   backgroundColor: Colors.cyan,
// //                   backgroundImage:imageFile==null?null :FileImage(File(imageFile?.path??"")),
// //                   child: imageFile==null?Icon(Icons.photo_camera_back,size: 50,color: Colors.white,):null
// //                 ),
// //               ),
// //               SizedBox(height: 30,),
// //               TextField(
// //                 controller: nameController,
// //                 decoration: InputDecoration(
// //
// //                 ),
// //               ),
// //               SizedBox(height: 30,),
// //               TextField(
// //                 controller: emailController,
// //                 decoration: InputDecoration(
// //
// //                 ),
// //               ),
// //               SizedBox(height: 30,),
// //               TextField(
// //                 controller: phoneController,
// //                 decoration: InputDecoration(
// //
// //                 ),
// //               ),
// //               // MaterialButton(
// //               //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
// //               //     onPressed: (){
// //               //   Text("image");
// //               // }),
// //               // MaterialButton(
// //               //      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// //               //
// //               //     onPressed: (){
// //               //       Text(" uploaded");
// //               //     }),
// //               ElevatedButton(onPressed: (){
// //
// //               }, child: Text("image"))
// //             ],
// //           ),
// //         )
// //         ),
// //
// //     );
// //   }
// //   takeImage()async{
// //     var imagePicker = ImagePicker();
// //     var image = await imagePicker.pickImage(source: ImageSource.gallery);
// //     setState(() {
// //       imageFile = image!;
// //     });
// //   }
// //   uploadImage(){
// //     if(imageFile==null||nameController.text.isEmpty||emailController.text.isEmpty||phoneController.text.isEmpty||ageController.text.isEmpty){
// //       Fluttertoast.showToast(msg: "pleace complete all firlds and upload image");
// //       return;
// //     }
// //     setState(() {
// //       isLoading = true;
// //     });
// //     try {
// //       var storage =FirebaseFirestore.instance;
// //       var styorageRef =storage.ref("images").child(Image)
// //
// //
// //     }
// //   }
// //
// // //     var  storage = FirebaseStorage.instance;
// // //     storage.ref("profileImage").child(imageFile?.name??"").putFile(File(imageFile?.path??"")).then ((value)async{
// // //    var imageUrl= await value.ref.getDownloadURL();
// // //    print("imageUrl");
// // //    var docId =FirebaseFirestore.instance.collection("profile").doc().id;
// // //    FirebaseFirestore.instance.collection("profile").add({"imageUrl":imageUrl});
// // //    Fluttertoast.showToast(msg: "Image uploaded");
// // //     });
// // //   }
// // // }
// //
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class profileScreen extends StatefulWidget {
//   const profileScreen({super.key});
//
//   @override
//   State<profileScreen> createState() => _profileScreenState();
// }
//
// class _profileScreenState extends State<profileScreen> {
//   XFile? imageFile;
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Center(child: Text("PROFILE")),
//         ),
//         body: isLoading ? Center(child: CircularProgressIndicator(),):SingleChildScrollView(
//           child: Padding(padding: EdgeInsets.all(19.0),
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: takeImage,
//                   child: CircleAvatar(
//                     radius: 60,
//                     backgroundColor: Colors.teal,
//                     backgroundImage: imageFile == null? null : FileImage(File(imageFile?.path??"")),
//                     child: imageFile== null? Icon(Icons.photo_camera_back,size: 50,color: Colors.white,):null,
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(controller: nameController,
//                   decoration: InputDecoration(labelText: "name"),
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(controller: emailController,
//                   decoration: InputDecoration(labelText: "email"),
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(controller: phoneController,
//                   decoration: InputDecoration(labelText: "phone"),
//                 ),
//                 SizedBox(height: 20,),
//                 ElevatedButton(
//                     onPressed: uploadImage,
//                     child: Text("Submit"))
//               ],
//
//             ),
//           ),
//         )
//     );
//   }
//   takeImage()async{
//     try {
//       var imagePicker = ImagePicker();
//       var image = await imagePicker.pickImage(source: ImageSource.gallery);
//       setState(() {
//         imageFile = image!;
//       });
//     }catch(e){
//       Fluttertoast.showToast(msg: "Error picking image$e");
//     }
//   }
//   var imageUrl = "";
//
//   uploadImage()async{
//     if(imageFile == null || nameController.text.isEmpty||emailController.text.isEmpty||phoneController.text.isEmpty){
//       Fluttertoast.showToast(msg: "please complete all fields and upload images");
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//     });
//     try{
//       var storage =FirebaseStorage.instance;
//       var storageRef = storage.ref("image").child(imageFile?.name??"");
//       storageRef.putFile(File(imageFile!.path)).then((p0)async{
//         imageUrl = await p0.ref.getDownloadURL();
//         setState(() {
//
//         });
//       });
//
//       var firestor = FirebaseFirestore.instance;
//       await firestor.collection("users").add({
//         "name": nameController.text,
//         "email":emailController.text,
//         "phone":phoneController.text,
//         "imageUrl":imageUrl
//       });
//       Fluttertoast.showToast(msg: "data Upload successfully");
//     } catch(e){
//       Fluttertoast.showToast(msg: "Error Uploading data$e");
//     }finally{
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
// }
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? imageFile;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  String? uploadedImageUrl;
  String? uploadedName;
  String? uploadedEmail;
  String? uploadedPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: takeImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  backgroundImage: imageFile == null
                      ? null
                      : FileImage(File(imageFile!.path)),
                  child: imageFile == null
                      ? const Icon(Icons.camera_alt,
                      size: 50, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: uploadData,
                child: const Text("Submit"),
              ),
              const SizedBox(height: 20),
              if (uploadedImageUrl != null) ...[
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(uploadedImageUrl!),
                ),
                const SizedBox(height: 20),
                Text('Name: $uploadedName'),
                Text('Email: $uploadedEmail'),
                Text('Phone: $uploadedPhone'),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> takeImage() async {
    try {
      var imagePicker = ImagePicker();
      var image = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        imageFile = image;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error picking image: $e");
    }
  }

  Future<void> uploadData() async {
    if (imageFile == null || nameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please complete all fields and upload an image");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Upload image to Firebase Storage
      var storage = FirebaseStorage.instance;
      var storageRef = storage.ref("Images").child(imageFile?.name??"");
      var uploadTask = storageRef.putFile(File(imageFile!.path));
      await uploadTask;
      String imageUrl = await storageRef.getDownloadURL();

      // Store data in Firestore
      var firestore = FirebaseFirestore.instance;
      await firestore.collection("users").add({
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "imageUrl": imageUrl,

      });

      // Update state to display uploaded data
      setState(() {
        uploadedImageUrl = imageUrl;
        uploadedName = nameController.text;
        uploadedEmail = emailController.text;
        uploadedPhone = phoneController.text;
      });

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