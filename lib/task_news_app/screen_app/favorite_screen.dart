// import 'package:flutter/material.dart';
// import 'package:like_button/like_button.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class FavouriteScreen extends StatefulWidget {
//   const FavouriteScreen({super.key});
//
//   @override
//   State<FavouriteScreen> createState() => _FavouriteScreenState();
// }
//
// class _FavouriteScreenState extends State<FavouriteScreen> {
//   Future<List<Map<String, String>>> getData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? favourites = prefs.getStringList('favourites');
//     if (favourites == null) {
//       return [];
//     }
//     return favourites.map((item) {
//       var parts = item.split('|');
//       return {'name': parts[0], 'description': parts[1]};
//     }).toList();
//   }
//
//   Future<void> removeFavourite(String name) async {
//     var prefs = await SharedPreferences.getInstance();
//     List<String>? favourites = prefs.getStringList('favourites');
//     favourites?.removeWhere((item) => item.split('|')[0] == name);
//     await prefs.setStringList('favourites', favourites ?? []);
//     setState(() {}); // Update the UI after removal
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.blue,
//           title: const Text('Favourites')),
//       body: FutureBuilder<List<Map<String, String>>>(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No data available'));
//           } else {
//             var data = snapshot.data!;
//             return ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 var item = data[index];
//                 return Card(
//                     child: ListTile(
//                         title: Text(item['name']!),
//                         subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(item['description']!),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   LikeButton(
//                                     isLiked: true,
//                                     onTap: (isLiked) async {
//                                       await removeFavourite(item['name']!);
//                                       return !isLiked;
//                                     },
//                                     size: 30,
//                                   ),
//                                 ],
//                               ),
//                             ]
//                         )
//                     )
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'news_service_class.dart';


class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff71a8980900),
        title: const Text('Favourite', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, value, child) {
          var data = value.favourites;
          if (data.isEmpty) {
            return const Center(child: Text('No favorites found.'));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var item = data[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    item['image']!.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : Image.network(item['image']!),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item['name'] ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(item['description'] ?? ""),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          value.deleteData(index);
                        },
                        icon: const Icon(Icons.thumb_down),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}