// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'api_service_screen.dart';
// import 'eshop_login_screen.dart';
//
// class EshopHome extends StatefulWidget {
//   const EshopHome({super.key});
//
//   @override
//   State<EshopHome> createState() => _EshopHomeState();
// }
//
// class _EshopHomeState extends State<EshopHome> {
//   void _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).popUntil((route) => route.isFirst);
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => EshopLogin()),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Logout failed. Please try again.')),
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.blueAccent,
//           title: const Text(
//             "e-shop",
//             style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.logout, color: Colors.white),
//               onPressed: _logout,
//             ),
//           ],
//         ),
//         body: FutureBuilder(
//             future: ApiServices().getEShopApi(),
//             builder: (context, snapshot) {
//               var data = snapshot.data!;
//                 return GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 200,
//                     crossAxisSpacing: 13.0,
//                     mainAxisSpacing: 16.0,
//                     childAspectRatio: 0.65,
//                   ),
//                   itemCount: data.products?.length,
//                   itemBuilder: (context, index) {
//                     var product = data.products![index];
//                     return Card(
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: Image.network(
//                               "${product.thumbnail}",
//                               fit: BoxFit.cover,
//                               loadingBuilder: (context, child, progress) {
//                                 if (progress == null) {
//                                   return child;
//                                 } else {
//                                   return const Center(child: CircularProgressIndicator());
//                                 }
//                               },
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Center(child: Icon(Icons.error, color: Colors.red));
//                               },
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("${product.brand}", style: const TextStyle(fontWeight: FontWeight.bold)),
//                                 Text("${product.meta}"),
//                                 Text("${product.category}", style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.red)),
//                                 const SizedBox(height: 4),
//                                 Text("${product.price}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               }
//
//         ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'eshop_provider.dart';

class EshopHome extends StatefulWidget {
  const EshopHome({super.key});

  @override
  State<EshopHome> createState() => _EshopHomeState();
}

class _EshopHomeState extends State<EshopHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<EshopProvider>(context, listen: false).fetchEshopData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "e-shop",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<EshopProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          } else if (provider.eshopModel == null ||
              provider.eshopModel!.products == null ||
              provider.eshopModel!.products!.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            var data = provider.eshopModel!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 13.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.65,
              ),
              itemCount: data.products?.length,
              itemBuilder: (context, index) {
                var product = data.products![index];
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          "${product.thumbnail}",
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) {
                              return child;
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Icon(Icons.error, color: Colors.red));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${product.brand}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text("${product.meta}"),
                            Text("${product.category}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.red)),
                            const SizedBox(height: 4),
                            Text("${product.price}",
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
