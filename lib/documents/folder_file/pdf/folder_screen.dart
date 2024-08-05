// //
// // import 'package:authenthication/documents/folder_file/pdf/pdf_screen.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// //
// // class FolderScreen extends StatefulWidget {
// //   const FolderScreen({super.key});
// //
// //   @override
// //   State<FolderScreen> createState() => _FolderScreenState();
// // }
// //
// // class _FolderScreenState extends State<FolderScreen> {
// //   var folders = <Map> [];
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       floatingActionButton: FloatingActionButton(onPressed: (){
// //         createNewFolderDialog();
// //       },
// //         child: Icon(Icons.add,color: Colors.black,),
// //       ),
// //       body: StreamBuilder(
// //         stream: getFolders(),
// //         builder: (_,snap){
// //           var folders =snap.data ?.docs;
// //           if(snap.hasData) {
// //             return folders!.isNotEmpty ? ListView.separated(
// //                 itemBuilder: (context, index) {
// //                   return ListTile(
// //                     onTap: () {
// //                       gotoNextScreenBaseedOnType(folders[index]
// //                       ['type']);
// //                     },
// //                     leading: Icon(Icons.folder_copy_rounded),
// //                     title: Text(folders[index]['name']),
// //                     subtitle: Text(folders[index]['type']),
// //                   );
// //                 }, separatorBuilder: (context, index) {
// //               return Divider();
// //             },
// //                 itemCount:folders.length):Center(
// //               child: Text(" folder found"),
// //             );
// //
// //           }else{
// //             return Center(
// //               child: Text("No folder found"),
// //             );
// //           }
// //         }
// //       ),
// //     );
// //   }
// //   var folderTypes = ['Image','Video','PDF'];
// //   var selectedTypes="";
// //   TextEditingController folderNameController=TextEditingController();
// //   createNewFolderDialog(){
// //     showDialog(context: context, builder: (context) {
// //       return AlertDialog(
// //         title: Text("Create new folder"),
// //         content: Column(
// //           children: [
// //            DropdownButtonFormField(items: folderTypes.map((type)=>DropdownMenuItem(child: Text(type),
// //              value: type,
// //            ))
// //                .toList(),
// //                onChanged: (type) {
// //                  selectedTypes=type??"";
// //                  setState(() {
// //
// //                  });
// //                }),
// //             SizedBox(height: 20,),
// //             TextFormField(
// //               controller: folderNameController,
// //             )
// //           ],
// //         ),
// //         actions: [
// //           ElevatedButton(
// //               onPressed: (){
// //                 folders.add({
// //             "name" :folderNameController.text,
// //              "type":selectedTypes
// //            });
// //            setState(() {
// //              Navigator.pop(context);
// //            });
// //           }, child: Text("add")),
// //           ElevatedButton(onPressed: (){
// //
// //           }, child: Text("Cancel"))
// //         ],
// //       );
// //     },
// //     );
// //   }
// //   gotoNextScreenBaseedOnType(String type){
// //     if(type ==folderTypes[0]){
// //
// //     }else if(type==folderTypes[1]){
// //       //go to video screen
// //     }else{
// //       gotoNxt(PdfScreen());
// //     }
// //   }
// //   gotoNxt(Widget page){
// //     Navigator.push(context, MaterialPageRoute(builder: (context) => page,));
// //   }
// //  addFolder()async{
// //    await FirebaseFirestore.instance.collection("Folders").add(
// //       {"name": folderNameController.text,"type":selectedTypes
// //       }).then((v){
// //         Fluttertoast.showToast(msg: "Folders created");
// //    }
// //    );
// //   }
// //
// //
// //   Stream<QuerySnapshot<Map<String,dynamic>>>getFolders(){
// //   return FirebaseFirestore.instance.collection("folders").snapshots();
// //   }
// // }
// import 'package:authenthication/documents/folder_file/pdf/pdf_screen.dart';
// import 'package:authenthication/documents/folder_file/pdf/video_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebae_firestore_project/view/screen/storage/folder/pdf_screen.dart';
// // import 'package:firebae_firestore_project/view/screen/storage/folder/video_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'image_screen.dart';
//
// class FolderScreen extends StatefulWidget {
//   const FolderScreen({super.key});
//
//   @override
//   State<FolderScreen> createState() => _FolderScreenState();
// }
//
// class _FolderScreenState extends State<FolderScreen> {
//   var folders = <Map>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Folder Screen"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           createNewFolderDialog();
//         },
//         child: Icon(Icons.add),
//       ),
//       body: StreamBuilder(
//         stream: getFolder(),
//         builder: (context, snapshot) {
//           var folders = snapshot.data?.docs;
//           if (snapshot.hasData) {
//             return folders!.isNotEmpty
//                 ? ListView.separated(
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     onTap: () {
//                       goToNextScreen(folders[index]["type"]);
//                     },
//                     leading: Icon(Icons.folder),
//                     title: Text(folders[index]["name"]),
//                     subtitle: Text(folders[index]["type"]),
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return Divider();
//                 },
//                 itemCount: folders.length)
//                 : const Center(
//               child: Text("No folder Found"),
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
//   goToNextScreen(String type){
//     if(type == folderType[0]){
//       Navigator.push(context, MaterialPageRoute(builder: (context) => ImageScreen(),));
//     }
//     else if(type == folderType[1]){
//       Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(),));
//     } else{
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const PdfScreen(),));
//     }
//   }
//   var folderType = ["Image", "Video", "Pdf"];
//   TextEditingController folderNameController = TextEditingController();
//   var selectType = "";
//
//   createNewFolderDialog() {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: Text("Create new folder"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               DropdownButtonFormField(
//                 items: folderType
//                     .map((type) => DropdownMenuItem(
//                   child: Text(type),
//                   value: type,
//                 ))
//                     .toList(),
//                 onChanged: (type) {
//                   setState(() {
//                     selectType = type ?? '';
//                   });
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: folderNameController,
//                 decoration: InputDecoration(
//                     hintText: "Enter your folder Name",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10))),
//               )
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 addFolder();
//                 folderNameController.clear();
//                 selectType = '';
//                 Navigator.pop(context);
//               },
//               child: Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   addFolder() async {
//     await FirebaseFirestore.instance
//         .collection("folders")
//         .add({"name": folderNameController.text, "type": selectType}).then((value) {
//       Fluttertoast.showToast(msg: "Created Folder");
//     });
//   }
//
//   Stream<QuerySnapshot<Map<String, dynamic>>> getFolder() {
//     return FirebaseFirestore.instance.collection("folders").snapshots();
//   }
// }
import 'package:authenthication/documents/folder_file/pdf/pdf_screen.dart';
import 'package:authenthication/documents/folder_file/pdf/video_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'image_screen.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  var folders = <Map>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: const Center(
            child: Text("Files",)),
        actions: [
          IconButton(onPressed: (){
          }, icon: const Icon(Icons.menu)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewFolderDialog();
        },
        child: const Icon(
          Icons.add_circle_outline,
          color: Colors.green,
        ),
      ),
      body: StreamBuilder(
        stream: getFolders(),
        builder: (context, snapshot) {
          var folders = snapshot.data?.docs;
          if (snapshot.hasData) {
            return folders!.isNotEmpty
                ? ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      gotoNextScreenBasedOnType(folders[index]['type']);
                    },
                    leading: const Icon(
                      Icons.folder,
                      color: Colors.white,
                    ),
                    title: Text(folders[index]['name'],style: const TextStyle(color: Colors.cyan),),
                    subtitle: Text(folders[index]['type'],style: const TextStyle(color: Colors.white70),),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.white38,
                  );
                },
                itemCount: folders.length)
                : const Center(
              child: Text(" No Folders"),
            );

          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error loading folders"),
            );
          }
          else {
            return  Center(
              child: Text("Not Found Folders"),
            );
          }
        },
      ),
    );
  }

  var folderTypes = ['image', 'video', 'PDF'];
  var selectedType = '';
  TextEditingController folderNameController = TextEditingController();

  createNewFolderDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shadowColor: Colors.tealAccent,
            elevation: 5,
            title: const Text("Create new folder"),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                    items: folderTypes
                        .map((type) => DropdownMenuItem(value: type,child: Text(type),))
                        .toList(),
                    onChanged: (type) {
                      selectedType = type ?? "";
                      setState(() {});
                    }),
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: folderNameController,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    addFolder();
                    folderNameController.clear();
                    selectedType = '';

                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Add")),
              ElevatedButton(onPressed: () {}, child: const Text("Cancel")),
            ],
          );
        });
  }

  gotoNextScreenBasedOnType(String type) {
    if (type == folderTypes[0]) {
      gotoImageScreen(ImageScreen());
    } else if (type == folderTypes[1]) {
     gotoImageScreen(VideoScreen());
    } else {
      gotoNext(const PDFScreen());
    }
  }

  gotoImageScreen(Widget pages) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => pages));
  }

  gotoNext(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  addFolder() async {
    await FirebaseFirestore.instance.collection("folders").add({
      "name": folderNameController.text,
      "type": selectedType,
    }).then((value) {
      Fluttertoast.showToast(msg: "Folder Create");
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFolders() {
    return FirebaseFirestore.instance.collection("folders").snapshots();
  }
}