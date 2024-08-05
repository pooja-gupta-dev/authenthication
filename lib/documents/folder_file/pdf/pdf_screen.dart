// //
// // import 'dart:io';
// // // import 'dart:js_interop';
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// //
// //
// // class PdfScreen extends StatefulWidget {
// //   const PdfScreen({super.key});
// //
// //   @override
// //   State<PdfScreen> createState() => _PdfScreenState();
// // }
// //
// // class _PdfScreenState extends State<PdfScreen> {
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: StreamBuilder(
// //         stream: getUploadedPdfs(),
// //         builder: (_, snap) {
// //           var pdfs = snap.data?.docs;
// //           if (pdfs?.isNotEmpty == true) {
// //             return ListView.builder(itemCount: pdfs?.length,
// //               itemBuilder: (_, index) {
// //                 return showPdfView(pdfs![index].data()['url']);
// //               },);
// //           } else {
// //             return Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }
// //         },),
// //       appBar: AppBar(
// //         title: Text("PDFS"),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           selectPdfFile();
// //         },
// //         child: Icon(Icons.add),
// //       ),
// //     );
// //   }
// //
// //   selectPdfFile() async {
// //     var rusult = await FilePicker.platform.pickFiles(
// //         allowMultiple: true,
// //         type: FileType.custom,
// //         allowedExtensions: ['PDF', 'Video', 'png']);
// //     if (rusult != null) {
// //       var files = rusult.files.map((path) => File(path.path!)).toList();
// //       for (var singleFile in files) {
// //         uploadPdf(singleFile);
// //         print("singleFile.path");
// //       }
// //       print(files.first.path);
// //     }
// //   }
// //
// //   uploadPdf(File file) {
// //     var storage = FirebaseStorage.instance;
// //     storage.ref("profileImage")
// //         .child(file.path
// //         .split("/")
// //         .last)
// //         .putFile(file)
// //         .then((value) async {
// //       var pdfUrl = await value.ref.getDownloadURL();
// //       print(pdfUrl);
// //       FirebaseFirestore.instance.collection("pdfs").add({"url": pdfUrl});
// //       Fluttertoast.showToast(msg: "Pdf uploaded");
// //     });
// //   }
// //
// //   Stream <QuerySnapshot<Map<String, dynamic>>> getUploadedPdfs() {
// //     var instance = FirebaseFirestore.instance.collection("pdf");
// //     return instance.snapshots();
// //   }
// //
// //   showPdfView(String pdfPath) {
// //     return SizedBox(
// //       height: 400,
// //       child: SfPdfViewer.network(pdfPath),
// //     );
// //   }
// // }
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//
// class PdfScreen extends StatefulWidget {
//   const PdfScreen({super.key});
//
//   @override
//   State<PdfScreen> createState() => _PdfScreenState();
// }
//
// class _PdfScreenState extends State<PdfScreen> {
//   File? selectedPdf;
//   List<File> pdf = <File>[];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Pdf Screen"),
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: (){
//         takeMultiPdf();
//       },child: Icon(Icons.add),),
//       body: StreamBuilder(
//         stream: getUploadedPdf(),
//         builder: (context, snapshot) {
//           var pdf = snapshot.data?.docs;
//           if (pdf?.isNotEmpty == true) {
//             return ListView.builder(itemCount: pdf?.length,
//               itemBuilder: (context, index) {
//                 return showPdfView(pdf![index].data()["url"]);
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
//   takeMultiPdf() async {
//     FilePickerResult? pikerPdf = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['PDF', 'Video', 'png'],
//     );
//     if (pikerPdf != null) {
//       var file = pikerPdf.files.map((path) => File(path.path!)).toList();
//       for (var multiPdf in file) {
//         uploadPdf(multiPdf);
//         print(multiPdf.path);
//       }
//       // setState(() {
//       //   image.addAll(file);
//       // });
//       print(file.first.path);
//     } else {}
//   }
//
//   uploadPdf(File file) {
//     var storage = FirebaseStorage.instance;
//     storage
//         .ref("PDF-IMAGE")
//         .child(file.path.split("/").last)
//         .putFile(File(file.path))
//         .then((value) async {
//       var pdfUrl = await value.ref.getDownloadURL();
//       print(pdfUrl);
//       FirebaseFirestore.instance.collection("pdf").add({"url": pdfUrl});
//       Fluttertoast.showToast(msg: "Pdf uploaded");
//     });
//   }
//
//   Stream<QuerySnapshot<Map<String, dynamic>>> getUploadedPdf() {
//     var instance = FirebaseFirestore.instance.collection("pdf");
//     return instance.snapshots();
//   }
//
//   showPdfView(String pdfpath) {
//     return SizedBox(
//       height: 400,
//       child: SfPdfViewer.network(pdfpath),
//     );
//   }
// }
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text("PDF"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectpdfFile();
        },
        child: const Icon(
          Icons.add_circle,
          color: Colors.deepOrangeAccent,
        ),
      ),
      body: StreamBuilder(
        stream: getUploadPdfs(),
        builder: (context, snapshot) {
          var pdfs = snapshot.data?.docs;
          if (pdfs?.isNotEmpty == true) {
            return ListView.builder(
              itemCount: pdfs?.length,
              itemBuilder: (context, index) {
                return showPdfView(pdfs![index].data()['url']);
              },
            );
          } else {
            return const Center(
              child: Text("No pdf found!",style: TextStyle(color: Colors.white38),),
            );
          }
        },
      ),
    );
  }

  selectpdfFile() async {
    var result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['PDF', 'video', 'image']);
    if (result != null) {
      var files = result.files.map((value) => File(value.path!)).toList();
      for (var singleFile in files) {
        uploadPdf(singleFile);
        print(singleFile.path);
      }
      print(files.first.path);
    }
  }

  uploadPdf(File file) {
    var storage = FirebaseStorage.instance;
    storage
        .ref("PDFs")
        .child(file.path.split(".").last)
        .putFile(file)
        .then((value) async {
      var pdfUrl = await value.ref.getDownloadURL();
      print(pdfUrl);
      FirebaseFirestore.instance.collection("pdfs").add({"url": pdfUrl});
      Fluttertoast.showToast(msg: "Pdf Upload");
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUploadPdfs() {
    var instance = FirebaseFirestore.instance.collection("pdfs");
    return instance.snapshots();
  }

  showPdfView(String pdfPath) {
    return SizedBox(
      height: 480,
      child: SfPdfViewer.network(pdfPath),
    );
  }
}