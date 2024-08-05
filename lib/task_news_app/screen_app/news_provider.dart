// import 'dart:core';
//
//
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../model.dart';
//
//
//
// class NewsProvider extends ChangeNotifier {
//   final NewsServiceClass   _newsServices = NewsServiceClass();
//   bool _loading = false;
//   NewsModalClass? _newsSearchModel;
//
//   bool get loading => _loading;
//   NewsModalClass? get newsSearchModel => _newsSearchModel;
//
//   Future<void> fetchNews(String category, [String? query]) async {
//     _loading = true;
//     notifyListeners();
//
//     try {
//       var newsSearchModel = await _newsServices.getNews(category, query);
//       _newsSearchModel = newsSearchModel;
//     } catch (e) {
//       _newsSearchModel = null;
//       print(e);
//     } finally {
//       _loading = false;
//       notifyListeners();
//     }
//
//   }
//   Future<void> addFavourite(String name, String description ) async {
//     var prefs = await SharedPreferences.getInstance();
//     List<String>? favourites = prefs.getStringList('favourites');
//     favourites ??= [];
//     favourites.add('$name|$description');
//     await prefs.setStringList('favourites', favourites);
//   }
//   Future<void> removeFavourite(String name) async {
//     var prefs = await SharedPreferences.getInstance();
//     List<String>? favourites = prefs.getStringList('favourites');
//     favourites?.removeWhere((item) => item.split('|')[0] == name);
//     await prefs.setStringList('favourites', favourites ?? []);
//   }
// }