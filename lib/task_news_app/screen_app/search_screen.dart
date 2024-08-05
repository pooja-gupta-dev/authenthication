// //
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'package:provider/provider.dart';
// // import 'details.dart';
// // import 'news_provider.dart';
// //
// // class NewsSearch extends StatefulWidget {
// //   const NewsSearch({super.key});
// //
// //   @override
// //   State<NewsSearch> createState() => _NewsSearchState();
// // }
// //
// // class _NewsSearchState extends State<NewsSearch> {
// //   final TextEditingController _searchController = TextEditingController();
// //   String _selectedCategory = 'business';
// //
// //   final List<String> _categories = [
// //     'business',
// //     'entertainment',
// //     'general',
// //     'health',
// //     'science',
// //     'sports',
// //     'technology'
// //   ];
// //   final Set<int> _favoriteArticles = {};
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchNews(_selectedCategory);
// //   }
// //
// //   Future<void> _fetchNews(String category, [String? query]) async {
// //     await Provider.of<NewsProvider>(context, listen: false).fetchNews(category, query);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xf9098740),
// //         centerTitle: true,
// //         elevation: 50,
// //         title: const Text("News Search", style: TextStyle(color: Colors.white)),
// //         bottom: PreferredSize(
// //           preferredSize: const Size.fromHeight(60),
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //             child: TextField(
// //               controller: _searchController,
// //               onSubmitted: (value) {
// //                 _fetchNews(_selectedCategory, value);
// //               },
// //               decoration: InputDecoration(
// //                 hintText: 'Search...',
// //                 fillColor: Colors.white,
// //                 filled: true,
// //                 prefixIcon: const Icon(Icons.search),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(20),
// //                   borderSide: BorderSide.none,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
// //             child: DropdownButtonFormField(
// //               value: _selectedCategory,
// //               items: _categories.map((String category) {
// //                 return DropdownMenuItem(
// //                   value: category,
// //                   child: Text(category),
// //                 );
// //               }).toList(),
// //               onChanged: (value) {
// //                 setState(() {
// //                   _selectedCategory = value!;
// //                   _fetchNews(_selectedCategory, _searchController.text);
// //                 });
// //               },
// //               decoration: InputDecoration(
// //                 labelText: "Choose Category",
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(20),
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           Expanded(
// //             child: Consumer<NewsProvider>(
// //               builder: (context, newsProvider, child) {
// //                 if (newsProvider.loading) {
// //                   return const Center(child: CircularProgressIndicator());
// //                 } else if (newsProvider.newsSearchModel == null || newsProvider.newsSearchModel!.articles == null || newsProvider.newsSearchModel!.articles!.isEmpty) {
// //                   return const Center(child: Text('No articles found'));
// //                 } else {
// //                   var articles = newsProvider.newsSearchModel!.articles!;
// //                   return ListView.builder(
// //                     itemCount: articles.length,
// //                     itemBuilder: (_, index) {
// //                       var article = articles[index];
// //                       return InkWell(
// //                         onTap: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) =>NewsDetailsScreen(article:article,),
// //                             ),
// //                           );
// //                         },
// //                         child: Card(
// //                           margin: const EdgeInsets.all(10),
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               if (article.urlToImage != null)
// //                                 Container(
// //                                   height: 200,
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
// //                                     image: DecorationImage(
// //                                       image: NetworkImage(article.urlToImage!),
// //                                       fit: BoxFit.cover,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               Padding(
// //                                 padding: const EdgeInsets.all(10),
// //                                 child: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Row(
// //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                       children: [
// //                                         Expanded(
// //                                           child: Text(
// //                                             article.title ?? 'No title',
// //                                             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
// //                                             overflow: TextOverflow.ellipsis,
// //                                           ),
// //                                         ),
// //                                         IconButton(
// //                                           icon: Icon(
// //                                             _favoriteArticles.contains(index)
// //                                                 ? Icons.favorite
// //                                                 : Icons.favorite_border,
// //                                             color: _favoriteArticles.contains(index)
// //                                                 ? Colors.red
// //                                                 : Colors.grey,
// //                                           ),
// //                                           onPressed: () {
// //                                             setState(() {
// //                                               if (_favoriteArticles.contains(index)) {
// //                                                 _favoriteArticles.remove(index);
// //                                               } else {
// //                                                 _favoriteArticles.add(index);
// //                                               }
// //                                             });
// //                                           },
// //                                         ),
// //                                       ],
// //                                     ),
// //                                     const SizedBox(height: 10),
// //                                     Text(article.description ?? 'No description'),
// //                                     const SizedBox(height: 10),
// //                                     Text(
// //                                       'Source: ${article.source?.name ?? 'Unknown'}',
// //                                       style: const TextStyle(fontStyle: FontStyle.normal),
// //                                     ),
// //                                     Text(
// //                                       'Published at: ${article.publishedAt != null ? DateFormat('yyyy-MM-dd – kk:mm').format(article.publishedAt!) : 'Unknown date'}',
// //                                       style: const TextStyle(fontStyle: FontStyle.normal),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //
// //                             ],
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 }
// //               },
// //             ),
// //           ),
// //
// //         ],
// //       ),
// //      // backgroundColor: const Color(0xf9098740),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:like_button/like_button.dart';
// import 'package:provider/provider.dart';
// import 'details.dart';
// import 'favorite_screen.dart';
// import 'news_service_class.dart';
//
//
// class NewsSearchScreen extends StatefulWidget {
//   const NewsSearchScreen({super.key});
//
//   @override
//   State<NewsSearchScreen> createState() => _NewsSearchScreenState();
// }
//
// class _NewsSearchScreenState extends State<NewsSearchScreen> {
//   TextEditingController searchController = TextEditingController();
//   String _selectedCategory = 'General';
//   final List<String> _categories = [
//     'General',
//     'Business',
//     'Technology',
//     'Entertainment',
//     'Health',
//     'Science',
//     'Sports'
//   ];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     final newsProvider = Provider.of<NewsProvider>(context, listen: false);
//     fetchInitialData(newsProvider);
//     searchController.addListener(() {
//       newsProvider.filterArticles(searchController.text);
//     });
//   }
//
//   Future<void> fetchInitialData(NewsProvider newsProvider) async {
//     setState(() {
//       isLoading = true;
//     });
//     await newsProvider.fetchNews(_selectedCategory);
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text("Search Screen")),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(150.0),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 DropdownButtonFormField<String>(
//                   value: _selectedCategory,
//                   icon: const Icon(Icons.arrow_drop_down),
//                   iconSize: 21,
//                   elevation: 16,
//                   style: const TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     hintText: "Select a category",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       setState(() {
//                         _selectedCategory = newValue;
//                       });
//                       fetchInitialData(Provider.of<NewsProviderService>(context, listen: false));
//                     }
//                   },
//                   items: _categories.map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(
//                         value,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 const SizedBox(height: 15),
//                 TextField(
//                   controller: searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search...',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(45)),
//                     filled: true,
//                     fillColor: Colors.white,
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.search),
//                       onPressed: () {
//                         Provider.of<NewsProviderService>(context, listen: false)
//                             .filterArticles(searchController.text);
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         backgroundColor: Colors.tealAccent,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const FavouriteScreen(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Consumer<NewsProvider>(
//         builder: (context, newsProvider, child) {
//           if (newsProvider.filteredArticles == null ||
//               newsProvider.filteredArticles!.isEmpty) {
//             return const Center(
//               child: Text(
//                 "No articles found.",
//                 style: TextStyle(color: Colors.black, fontSize: 16),
//                 textAlign: TextAlign.center,
//               ),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: newsProvider.filteredArticles?.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   elevation: 5,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (newsProvider.filteredArticles?[index].urlToImage != null)
//                           Image.network("${newsProvider.filteredArticles?[index].urlToImage}"),
//                         const SizedBox(height: 10),
//                         Text(
//                           "${newsProvider.filteredArticles?[index].title}",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text("${newsProvider.filteredArticles?[index].source}"),
//                         const SizedBox(height: 10),
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>NewsDetailsScreen(
//                                   image: '${newsProvider.filteredArticles?[index].urlToImage}',
//                                   title: '${newsProvider.filteredArticles?[index].title}',
//                                   source: '${newsProvider.filteredArticles?[index].source}',
//                                   author: '${newsProvider.filteredArticles?[index].author}',
//                                   content: '${newsProvider.filteredArticles?[index].content}',
//                                   publishedAt: '${newsProvider.filteredArticles?[index].publishedAt}',
//                                   url: '${newsProvider.filteredArticles?[index].url}',
//                                 ),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             "Read more",
//                             style: TextStyle(
//                               color: Colors.blue,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               LikeButton(
//                                 onTap: (isLiked) async {
//                                   if (isLiked) {
//                                   NewsProvider().removeFavourite(newsProvider.filteredArticles![index].title.toString());
//                                   } else {
//                                   NewsProvider().addFavourite(
//                                       newsProvider.filteredArticles![index].title.toString(),
//                                       newsProvider.filteredArticles![index].content.toString(),
//                                     );
//                                   }
//                                   return !isLiked;
//                                 },
//                                 size: 30,
//                               ),
//                             ],
//                             ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       backgroundColor: Colors.white,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import 'details.dart';
import 'favorite_screen.dart';
import 'news_service_class.dart';


class NewsSearchView extends StatefulWidget {
  const NewsSearchView({super.key});

  @override
  State<NewsSearchView> createState() => _NewsSearchViewState();
}

class _NewsSearchViewState extends State<NewsSearchView> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'business';
  final List<String> _categories = [
    'business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology'
  ];

  @override
  void initState() {
    super.initState();
    _fetchNews(_selectedCategory);
  }

  Future<void> _fetchNews(String category, [String? query]) async {
    await Provider.of<NewsProvider>(context, listen: false).fetchNews(category, query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff71a8980900),
        centerTitle: true,
        elevation: 50,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                _fetchNews(_selectedCategory, value);
              },
              decoration: InputDecoration(
                hintText: 'Search news...',
                hintStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.search, color: Color(0xff71a8980900)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavouriteScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Consumer<NewsProvider>(builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories.map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category, style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                    _fetchNews(_selectedCategory, _searchController.text);
                  });
                },
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.black),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: value!.loading
                  ? const Center(child: CircularProgressIndicator())
                  : value.newsSearchModel?.articles?.isEmpty ?? true
                  ? const Center(child: Text('No articles found'))
                  : ListView.builder(
                itemCount: value.newsSearchModel?.articles?.length ?? 0,
                itemBuilder: (_, index) {
                  var article = value.newsSearchModel!.articles![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailsScreen(article: article),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          article.urlToImage == null
                              ? const Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Center(child: CircularProgressIndicator(color:Color(0xff71a8980900))),
                          )
                              : Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(article.urlToImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.author ?? 'No author',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  article.title ?? 'No title',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                const SizedBox(height: 10),
                                Text(article.description ?? 'No description'),
                                const SizedBox(height: 10),
                                Text(
                                  'Source: ${article.source?.name ?? 'Unknown'}',
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Published at: ${article.publishedAt != null ? DateFormat('yyyy-MM-dd – kk:mm').format(article.publishedAt!) : 'Unknown date'}',
                                  style: const TextStyle(fontStyle: FontStyle.italic, color: Color(0xff71a8980900)),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                LikeButton(
                                  size: 30,
                                  isLiked: value.favourites.any((fav) => fav['name'] == article.title),
                                  onTap: (isLiked) async {
                                    if (!isLiked) {
                                      // Add to favorites
                                      await value.addFavourite(
                                        article.title ?? "",
                                        article.description ?? "",
                                        article.urlToImage ?? "",
                                      );
                                    } else {
                                      // Remove from favorites
                                      final index = value.favourites.indexWhere((fav) => fav['name'] == article.title);
                                      if (index != -1) {
                                        await value.deleteData(index);
                                      }
                                    }
                                    // Return the updated state
                                    return !isLiked;
                                  },
                                  circleColor: const CircleColor(start: Colors.lightGreen, end: Colors.green),
                                  likeBuilder: (isLiked) {
                                    return Icon(
                                      isLiked ? Icons.favorite : Icons.favorite_border,
                                      color: isLiked ? Colors.pinkAccent : Colors.grey,
                                    );
                                  },
                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}