// // //
// // // import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:share_plus/share_plus.dart';
// // //
// // //
// // // class DynamicLinkService extends StatefulWidget {
// // //   const DynamicLinkService({super.key});
// // //
// // //   @override
// // //   State<DynamicLinkService> createState() => _DynamicLinkServiceState();
// // // }
// // //
// // // class _DynamicLinkServiceState extends State<DynamicLinkService> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //         appBar: AppBar(
// // //           backgroundColor: Colors.purple,
// // //           title: const Center(
// // //               child: Text(
// // //                 "~* Share Link *~",
// // //                 style: TextStyle(color: Colors.white),
// // //               )
// // //           ),
// // //         ),
// // //         // body: SafeArea(
// // //         //   child: FutureBuilder(
// // //         //     future: getProductDetails(),
// // //         //     builder: (context,snapshot){
// // //         //       var data =snapshot.data?.doce;
// // //         //       return ListView.builder(
// // //         //           itemCount:data?.length,
// // //         //         itemBuilder: (context,index){
// // //         //             var product = data![index].id;
// // //         //             return Card(
// // //         //               child: ListTile(
// // //         //                 leading: Image.network("${data[index]['imageUrl']}"),
// // //         //                 title: Text("${data }"),
// // //         //               ),
// // //         //             );
// // //         //         },
// // //         //       );
// // //         //     },
// // //         //   ),
// // //         // ),
// // //
// // //         body: Padding(
// // //           padding: EdgeInsets.all(10.0),
// // //           child: Column(
// // //             children: [
// // //               Padding(
// // //                 padding:  EdgeInsets.only(left: 15),
// // //                 child: ElevatedButton(
// // //                     onPressed: () {
// // //
// // //                       createDynamicLink();
// // //                     },
// // //                     child: Center(child: Text("CREATE DYNIMIC LINK"))),
// // //               ),
// // //               SizedBox(
// // //                 height: 20,
// // //               )
// // //             ],
// // //           ),
// // //         )
// // //     );
// // //   }
// // //
// // //   createDynamicLink() async {
// // //     final dynamicLinkParams = DynamicLinkParameters(
// // //       link: Uri.parse("https://authenthication.page"),
// // //       uriPrefix: "https://authenthication.page.link",
// // //       androidParameters:
// // //       const AndroidParameters(packageName: "com.example.firebase_project"),
// // //     );
// // //
// // //     final dynamicLink =
// // //     await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
// // //     await Share.share(dynamicLink.toString());
// // //
// // //     // Future<QuerySnapshot<Map<String,dynamic>>> getProdactDetails(){
// // //     //   final firebase = FirebaseFirestore.instance;
// // //     //   var getData =firebase.collection("").get();
// // //     //   return getData;
// // //     //
// // //     // }
// // //   }
// // // }
// //
// //
// //
// import 'package:authenthication/dynamic/product_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'package:flutter/material.dart';
//
//
// class DynamicLinkScreen extends StatefulWidget {
//
//   const DynamicLinkScreen({super.key});
//
//   @override
//   State<DynamicLinkScreen> createState() => _DynamicLinkScreenState();
// }
//
// class _DynamicLinkScreenState extends State<DynamicLinkScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text("~~Dynamic Link Screen~~",),
//         backgroundColor: Colors.lightGreen,
//       ),
//       body: FutureBuilder(
//         future: getProductData(),
//         builder: (context, snapshot) {
//           var data = snapshot.data?.docs;
//           if (data?.isNotEmpty == true) {
//             return ListView.builder(
//               itemCount: data?.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {
//                    Navigator.push(context, MaterialPageRoute(builder:
//                        (context) => ProductScreen(productId:  data[index].id,),));
//                   },
//                   child: Card(
//                     margin: const EdgeInsets.all(10),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 40,
//                             backgroundImage:
//                             NetworkImage(data![index]['image']),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   data[index].id,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   data[index]['title'],
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   data[index]['description'],
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   'Price: \$${data[index]['price']}',
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//       backgroundColor: Colors.lightGreen,
//     );
//   }
//
//   Future<QuerySnapshot<Map<String, dynamic>>> getProductData() async {
//     var product = FirebaseFirestore.instance;
//     return await product.collection("product").get();
//   }
// }
//
//
//
//
//
//
//
//
import 'package:authenthication/dynamic/product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkSrevice extends StatefulWidget {
  const DynamicLinkSrevice ({super.key});

  @override
  State<DynamicLinkSrevice> createState() => _DynamicLinkSreviceState();
}

class _DynamicLinkSreviceState extends State<DynamicLinkSrevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xff985293),
        title: const Text("~Dynamic Link Srevice~"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getProductDetails(),
          builder: (context, snapshot) {
            var data = snapshot.data?.docs;
            return ListView.builder(
              itemCount: data?.length ?? 0,
              itemBuilder: (context, index) {
                var product = data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => product_screen(id: product.id),
                    ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shadowColor: Color(0xff985293),
                    child: ListTile(
                      leading: Image.network("${product['image']}"),
                      title: Text("${product['title']}"),
                      subtitle: Row(
                        children: [
                          Text("${product['price']}"),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () {
                              createDynamicLink(product.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },

        ),

      ),
      backgroundColor:  Color(0xff985293),
    );
  }

  Future<void> createDynamicLink(String id) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://authenthication.page.link.com?productId=$id"),
      uriPrefix: "https://authenthication.page.link",
      androidParameters: const AndroidParameters(packageName: "com.example.authenthication"),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    await Share.share(dynamicLink.toString());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getProductDetails() {
    final firebase = FirebaseFirestore.instance;
    var getData = firebase.collection("product").get();
    return getData;
  }

}