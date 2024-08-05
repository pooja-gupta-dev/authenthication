import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddToCartScreen extends StatefulWidget {
  final String id;
  const AddToCartScreen({super.key, required this.id});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.cyan,
      ),
      body: FutureBuilder(
        future: getCartDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("An error occurred"));
          }
          var data = snapshot.data?.docs;
          return ListView.builder(
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) {
              var product = data![index];
              return Card(
                elevation: 4,
                shadowColor: Colors.cyan,
                child: ListTile(
                  leading: Image.network("${product['image']}"),
                  title: Text("${product['title']}"),
                  subtitle: Text("${product['price']}"),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.cyan,
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCartDetails() {
    final firebase = FirebaseFirestore.instance;
    return firebase.collection("cart").get();
  }
}