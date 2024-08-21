// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import '../screens/home/home_screen.dart';
//
// class AuthController extends GetxController {
//   // Profile details
//   var name = ''.obs;
//   var email = ''.obs;
//   var password = ''.obs;
//   var phoneNumber = ''.obs;
//   var profileImage = Rx<File?>(null);
//   var postCount = 0.obs;
//   var videos = <DocumentSnapshot>[].obs;
//   // RxList<File> selectedVideos = <File>[].obs;
//   RxList<String> descriptions = <String>[].obs;
//
//   // Controllers
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   var isLoading = false.obs;
//
//   // Pick image
//   Future<void> pickImage() async {
//     try {
//       final pickedFile =
//           await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         profileImage.value = File(pickedFile.path);
//       }
//     } catch (e) {
//       Get.showSnackbar(GetSnackBar(
//         titleText: Text("Image Selection Failed"),
//         messageText: Text(e.toString()),
//         duration: Duration(seconds: 3),
//       ));
//     }
//   }
//
//   // Register user
//   Future<void> register() async {
//     try {
//       isLoading.value = true;
//       UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email.value,
//         password: password.value,
//       );
//
//       String? imageUrl;
//       if (profileImage.value != null) {
//         imageUrl = await _uploadProfileImage(userCredential.user!.uid);
//       }
//
//       // Store user data in Firestore
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .set({
//         'name': name.value,
//         'email': email.value,
//         'phoneNumber': phoneNumber.value,
//         'profileImageUrl': imageUrl,
//       });
//
//       // Navigate to HomeScreen after successful registration
//       Get.offAll(() => HomeScreen(
//             name: name.value,
//             image: profileImage.value,
//             phoneNumber: phoneNumber.value,
//           ));
//     } on FirebaseAuthException catch (e) {
//       Get.showSnackbar(GetSnackBar(
//         titleText: Text("Registration Failed"),
//         messageText: Text(e.message ?? "An error occurred"),
//         duration: Duration(seconds: 3),
//       ));
//     } catch (e) {
//       Get.showSnackbar(GetSnackBar(
//         titleText: Text("Registration Failed"),
//         messageText: Text(e.toString()),
//         duration: Duration(seconds: 3),
//       ));
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Login user
//   Future<void> login() async {
//     isLoading.value = true;
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//
//       // Fetch user data from Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .get();
//       name.value = userDoc['name'];
//       phoneNumber.value = userDoc['phoneNumber'];
//       String? profileImageUrl = userDoc['profileImageUrl'];
//       if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
//         var tempDir = await getTemporaryDirectory();
//         File profileImageFile = File('${tempDir.path}/profileImage.jpg');
//         await profileImageFile.writeAsBytes(
//             (await NetworkAssetBundle(Uri.parse(profileImageUrl))
//                     .load(profileImageUrl))
//                 .buffer
//                 .asUint8List());
//         profileImage.value = profileImageFile;
//       }
//
//       // Navigate to HomeScreen after successful login
//       Get.offAll(() => HomeScreen(
//             name: name.value,
//             image: profileImage.value,
//             phoneNumber: phoneNumber.value,
//           ));
//     } on FirebaseAuthException catch (e) {
//       Get.showSnackbar(GetSnackBar(
//         titleText: Text("Login Failed"),
//         messageText: Text(e.message ?? "An error occurred"),
//         duration: Duration(seconds: 3),
//       ));
//     } catch (e) {
//       Get.showSnackbar(GetSnackBar(
//         titleText: Text("Login Failed"),
//         messageText: Text(e.toString()),
//         duration: Duration(seconds: 3),
//       ));
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Upload profile image to Firebase Storage
//   Future<String> _uploadProfileImage(String userId) async {
//     final ref = FirebaseStorage.instance
//         .ref()
//         .child('user_images')
//         .child('$userId.jpg');
//     await ref.putFile(profileImage.value!);
//     return await ref.getDownloadURL();
//   }
//
//   // Update profile functions
//   void updateProfileImage(File? image) {
//     profileImage.value = image;
//   }
//
//   void updateName(String newName) {
//     name.value = newName;
//   }
//
//   void updatePhoneNumber(String newPhoneNumber) {
//     phoneNumber.value = newPhoneNumber;
//   }
//
//   void updateProfile(String newName, String newPhoneNumber, File? newImage) {
//     updateName(newName);
//     updatePhoneNumber(newPhoneNumber);
//     updateProfileImage(newImage);
//   }
//
//   // Video upload
//   var selectedVideos = <File>[].obs;
//   var videoThumbnails = <File, String?>{}.obs;
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   Future<void> takeMultiVideo() async {
//     FilePickerResult? pickerVideo = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.video,
//     );
//
//     if (pickerVideo != null) {
//       var files = pickerVideo.files.map((path) => File(path.path!)).toList();
//       print(
//           "Selected videos: ${files.map((file) => file.path)}"); // Debugging line
//       selectedVideos.value = files;
//       _generateThumbnails();
//     } else {
//       print("No videos selected"); // Debugging line
//     }
//   }
//
//   Future<void> _generateThumbnails() async {
//     for (var file in selectedVideos) {
//       print("Generating thumbnail for: ${file.path}"); // Debugging line
//       await Future.delayed(Duration(milliseconds: 500)); // Add delay if needed
//       final thumbnail = await VideoThumbnail.thumbnailFile(
//         video: file.path,
//         thumbnailPath: null,
//         imageFormat: ImageFormat.JPEG,
//         maxWidth: 128,
//         quality: 75,
//       );
//       if (thumbnail != null) {
//         videoThumbnails[file] = thumbnail;
//         print("Thumbnail generated: $thumbnail"); // Debugging line
//       } else {
//         print(
//             "Failed to generate thumbnail for: ${file.path}"); // Debugging line
//       }
//     }
//   }
//
//
//   Future<void> uploadVideos(List<File> videoFiles, {required String title, required String description}) async {
//     try {
//       for (var videoFile in videoFiles) {
//         String fileName = videoFile.path.split('/').last;
//         Reference ref = _storage.ref().child('videos/$fileName');
//         UploadTask uploadTask = ref.putFile(videoFile);
//
//         TaskSnapshot snapshot = await uploadTask;
//         String videoUrl = await snapshot.ref.getDownloadURL();
//
//         // Save video metadata in Firestore
//         await _firestore.collection('videos').add({
//           'userId': FirebaseAuth.instance.currentUser?.uid,
//           'videoUrl': videoUrl,
//           'title': title,
//           'description': description,
//           'timestamp': FieldValue.serverTimestamp(),
//         });
//       }
//     } catch (e) {
//       print('Error uploading videos: $e');
//     }
//   }
//
//   var currentUser = {}.obs; // Using a map to store user data
//
//   var users = <Map<String, dynamic>>[].obs;
//
//   Future<void> searchUsers(String query) async {
//     isLoading.value = true;
//     try {
//       final result = await FirebaseFirestore.instance
//           .collection('users')
//           .where('name', isGreaterThanOrEqualTo: query)
//           .where('name', isLessThanOrEqualTo: query + '\uf8ff')
//           .get();
//       users.value = result.docs.map((doc) => doc.data()).toList();
//     } catch (error) {
//       Get.snackbar(
//         'Search Failed',
//         'Failed to search users: $error',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   RxString userId = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize user data
//     var user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       userId.value = user.uid;
//       // Load other user info
//     }
//   }
// }



import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../authInsta/instalogin_insta.dart';
import '../insta_home/insta_home_screens.dart';
import '../model/insta_model.dart';

class InstaAuthController extends GetxController {
  static InstaAuthController instance = Get.find();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Rxn<User?> firebaseUser = Rxn<User?>();
  Rxn<UserModel> currentUser = Rxn<UserModel>();

  @override
  void onReady() {
    super.onReady();
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(InstaLoginScreen());
    } else {
      fetchUserProfile(user.uid);
      Get.offAll(InstaHomeScreen());
    }
  }

  Future<void> registerWithEmailAndPassword(String name, String email,
      String password, String phone, File? image) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? imageUrl;
      if (image != null) {
        String fileName = '${userCredential.user!.uid}.png';
        Reference ref = storage.ref().child('user_images/$fileName');
        await ref.putFile(image);
        imageUrl = await ref.getDownloadURL();
      }

      UserModel newUser = UserModel(
        id: userCredential.user!.uid,
        email: email,
        phone: phone,
        name: name,
        imageUrl: imageUrl,
        followers: [],
        following: [],
        like: [],
        comment: [],
      );

      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());

      fetchUserProfile(userCredential.user!.uid);
      Get.offAll(InstaHomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
    }
  }

  loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      fetchUserProfile(userCredential.user!.uid);
      Get.offAll(InstaHomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      Get.offAll(()=>InstaLoginScreen());
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out. Please try again.');
      print('Error during sign out: $e');
    }
  }

  fetchUserProfile(String userId) async {
    try {
      DocumentSnapshot doc =
      await firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        currentUser.value = UserModel.fromJson(jsonDecode(jsonEncode(doc.data())));
        print("User fetched: ${currentUser.value}");
      } else {
        Get.snackbar('Error', 'User not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user profile');
    }
  }

  Future<void> updateProfile({required String name, File? imageFile}) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        final storageRef = FirebaseStorage.instance.ref().child('profile_images').child('${DateTime.now().toIso8601String()}.jpg');
        final uploadTask = storageRef.putFile(imageFile);
        final snapshot = await uploadTask;
        imageUrl = await snapshot.ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('users').doc(currentUser.value?.id).update({
        'name': name,
        if (imageUrl != null) 'imageUrl': imageUrl,
      });
    } catch (e) {
      print('Failed to update profile: $e');
    }
  }



  var isLoading = false.obs;
  var searchedUsers = [].obs;

  void searchUsers(String query) async {
    if (query.isEmpty) {
      searchedUsers.clear();
      return;
    }

    isLoading.value = true;

    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      // Update the searchedUsers list with the results
      searchedUsers.value = usersSnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error searching users: $e");
      searchedUsers.clear();
    } finally {
      isLoading.value = false;
    }
  }

// Future<void> searchUsers(String query) async {
//   isLoading.value = true;
//   try {
//     final result = await FirebaseFirestore.instance
//         .collection('users')
//         .where('name', isGreaterThanOrEqualTo: query)
//         .where('name', isLessThanOrEqualTo: query + '\uf8ff')
//         .get();
//     users.value = result.docs.map((doc) => doc.data()).toList();
//   } catch (error) {
//     Get.snackbar(
//       'Search Failed',
//       'Failed to search users: $error',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   } finally {
//     isLoading.value = false;
//   }
// }
}