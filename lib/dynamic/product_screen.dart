// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// class ProductScreen extends StatefulWidget {
//    final  String productId;
//    ProductScreen({super.key, required this.productId, });
//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }
//
// class _ProductScreenState extends State<ProductScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("*Product Screen*"),
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: FutureBuilder(
//         future: getProductData(widget.productId),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             var product = snapshot.data?.data();
//             return Padding(
//               padding: EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 550),
//                     child: CircleAvatar(
//                       radius: 40,
//                       backgroundImage: NetworkImage(product?["image"] ?? ''),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 12,
//                   ),
//                   Expanded(
//                       child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         product?['title'] ?? '',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         product?['description'] ?? '',
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         'Price:\$${product?['price'] ?? ''}',
//                         style:
//                             TextStyle(fontSize: 14, color: Colors.greenAccent),
//                       ),
//                       SizedBox(
//                         height: 25,
//                       ),
//                       ElevatedButton(
//                           onPressed: () {
//                             createDynamicLink(product!["Id"].toString());
//                           },
//                           child: Text("Share item"))
//                     ],
//                   ))
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//      // backgroundColor: Colors.pinkAccent,
//     );
//   }
//
//   Future<void> createDynamicLink(String id) async {
//     var parameters = DynamicLinkParameters(
//       link:
//           Uri.parse("https://authenthication.com/?productId=$id"),
//       uriPrefix: "https://firebaefirestoreproject.page.link",
//       androidParameters: const AndroidParameters(
//         packageName: "com.example.authenthication",
//       ),
//     );
//
//     final dynamicLink =
//         await FirebaseDynamicLinks.instance.buildLink(parameters);
//     await Share.share(dynamicLink.toString());
//   }
//
//   Future<DocumentSnapshot<Map<String, dynamic>>> getProductData(
//       String id) async {
//     var product = FirebaseFirestore.instance;
//     return await product.collection("product").doc(id).get();
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
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';
import 'add_card_screen.dart';

class product_screen extends StatefulWidget {
  final String id;

  const product_screen({Key? key, required this.id}) : super(key: key);

  @override
  _product_screenState createState() => _product_screenState();
}

class _product_screenState extends State<product_screen> {
  late DocumentSnapshot<Map<String, dynamic>> product;
  bool isInCart = false;

  @override
  void initState() {
    super.initState();
    checkIfInCart();
  }

  void checkIfInCart() async {
    final cart = await FirebaseFirestore.instance.collection('cart').doc(widget.id).get();
    setState(() {
      isInCart = cart.exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff187654),
        title: const Center(child: Text("Product Details", style: TextStyle(color: Colors.white))),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              createDynamicLink(widget.id);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getProductDetails(),
        builder: (context,  snapshot) {

          product = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                height: 480,
                child: Card(
                  elevation: 12,
                  shadowColor: Color(0xff187654),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Image.network("${product['image']}"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          "Product ${product['title']}",
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(Icons.attach_money, size: 16),
                          ),
                          Text("${product['price']}"),
                        ],
                      ),
                      // const SizedBox(height: 16),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20),
                      //   child: Text("Description: ${product['desc']}"),
                      // ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: isInCart
                              ? null
                              : () {
                            addToCart();
                          },
                          child: Text(isInCart ? "Already in Cart" : "Add to Cart"),
                        ),

                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),

    );
  }

  Future<void> createDynamicLink(String id) async {
    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: 'https://authenthication.page.link',
      link: Uri.parse('https://authenthication.page.link/product?id=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.authenthication',
      ),
    );

    final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance
        .buildShortLink(dynamicLinkParams, shortLinkType: ShortDynamicLinkType.short);

    final Uri shortUrl = shortLink.shortUrl;

    Share.share(shortUrl.toString());
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProductDetails() async {
    final firebase = FirebaseFirestore.instance;
    var productData = await firebase.collection("product").doc(widget.id).get();
    setState(() {
      product = productData;
    });
    return productData;
  }

  Future<void> addToCart() async {
    final firebase = FirebaseFirestore.instance;
    await firebase.collection("card").doc(widget.id).set(product.data()!);
    setState(() {
      isInCart = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddToCartScreen(id: widget.id)),
    );
  }

}