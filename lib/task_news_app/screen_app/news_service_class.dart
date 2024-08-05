// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // import '../model.dart';
// //
// // class NewsServices {
// //   final String url = "https://newsapi.org/v2/top-headlines";
// //   final String apiKey = "8872eefd98f14d6eb0d98691a44e6d62";
// //
// //   Future<NewModelClass> getNews(String category, [String? query]) async {
// //     var fullUrl = Uri.parse("$url?country=us&category=$category&apiKey=$apiKey");
// //     if (query != null && query.isNotEmpty) {
// //       fullUrl = Uri.parse("$url?country=us&category=$category&q=$query&apiKey=$apiKey");
// //     }
// //
// //     try {
// //       var response = await http.get(fullUrl);
// //
// //       if (response.statusCode == 200) {
// //         var data = json.decode(response.body);
// //         return NewModelClass.fromJson(data);
// //       } else {
// //         throw Exception('Failed to load data: ${response.reasonPhrase}');
// //       }
// //     } catch (e) {
// //       print('Error: $e');
// //       throw Exception('Failed to load data');
// //     }
// //   }
// // }
// //
// //
// //
// //
// //
//
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import '../model.dart';
//
//
// class NewsServiceClass with ChangeNotifier {
//   List<Article>? _allArticles = [];
//   List<Article>? _filteredArticles = [];
//   List<Article> _favoriteArticles = [];
//
//   List<Article>? get filteredArticles => _filteredArticles;
//   List<Article> get favoriteArticles => _favoriteArticles;
//
//   bool get loading => loading;
//
//   Future<List<Article>?> fatchData(String query) async {
//     var response = await http.get(Uri.parse(
//         "https://newsapi.org/v2/everything?q=$query&apiKey=4700636fd3254233b00c360815f04d05"));
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       var getdata = NewsModalClass.fromJson(data);
//       return getdata.articles;
//     } else {
//       return List<Article>.empty();
//     }
//   }
//
//   Future<void> fetchNews(String category) async {
//     _allArticles = await fatchData(category);
//     _filteredArticles = _allArticles;
//     notifyListeners();
//   }
//
//   void filterArticles(String query) {
//     if (query.isEmpty) {
//       _filteredArticles = _allArticles;
//     } else {
//       _filteredArticles = _allArticles?.where((article) {
//         return article.title?.toLowerCase().contains(query.toLowerCase()) ?? false;
//       }).toList();
//     }
//     notifyListeners();
//   }
//
//   bool isFavorite(Article article) {
//     return _favoriteArticles.contains(article);
//   }
//
//   void addFavorite(Article article) {
//     if (!isFavorite(article)) {
//       _favoriteArticles.add(article);
//       notifyListeners();
//     }
//   }
//
//   void removeFavorite(Article article) {
//     if (isFavorite(article)) {
//       _favoriteArticles.remove(article);
//       notifyListeners();
//     }
//   }
//   getNews(String category, String? query) {}
// }


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../model.dart';


class NewsProvider extends ChangeNotifier {
  final NewsServices _newsServices = NewsServices();
  bool _loading = false;
  NewsModalClass? _newsSearchModel;

  bool get loading => _loading;

  NewsModalClass? get newsSearchModel => _newsSearchModel;

  Future<void> fetchNews(String category, [String? query]) async {
    _loading = true;
    notifyListeners();

    try {
      var newsSearchModel = await _newsServices.getNews(category, query);
      _newsSearchModel = newsSearchModel;
    } catch (e) {
      _newsSearchModel = null;
      print(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  List<Map<String, String>> _favourites = [];

  MyProvider() {
    loadFavourites();
  }

  Future<void> loadFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favourites = prefs.getStringList('favourites');
    if (favourites != null) {
      _favourites = favourites.map((item) {
        var parts = item.split('|');
        return {
          'name': parts.isNotEmpty ? parts[0] : '',
          'description': parts.length > 1 ? parts[1] : '',
          'image': parts.length > 2 ? parts[2] : '',
        };
      }).toList();
    }
    notifyListeners();
  }

  Future<void> addFavourite(
      String name, String description, String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favourites.add({'name': name, 'description': description, 'image': image});
    List<String> favourites = _favourites
        .map(
            (item) => '${item['name']}|${item['description']}|${item['image']}')
        .toList();
    await prefs.setStringList('favourites', favourites);
    notifyListeners();
  }

  Future<void> deleteData(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favourites.removeAt(index);
    List<String> favourites = _favourites
        .map(
            (item) => '${item['name']}|${item['description']}|${item['image']}')
        .toList();
    await prefs.setStringList('favourites', favourites);
    notifyListeners();
  }

  List<Map<String, String>> get favourites => _favourites;
}

class NewsServices {
  final String url = "https://newsapi.org/v2/top-headlines";
  final String apiKey = "e1419fd2094647c8946c17017b82e0d0";

  Future<NewsModalClass> getNews(String category, [String? query]) async {
    var fullUrl =
    Uri.parse("$url?country=us&category=$category&apiKey=$apiKey");
    if (query != null && query.isNotEmpty) {
      fullUrl = Uri.parse(
          "$url?country=us&category=$category&q=$query&apiKey=$apiKey");
    }

    try {
      var response = await http.get(fullUrl);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return NewsModalClass.fromJson(data);
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }
}