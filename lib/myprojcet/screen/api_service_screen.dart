// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'eshop_model_class.dart';
//
// class ApiServices {
//   Future<EshopModel> getEShopApi() async {
//     Uri uri =Uri.parse("https://dummyjson.com/products");
//     var response = await http.get(uri);
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       var convert = EshopModel.fromJson(data);
//       return convert;
//     }
//     else {
//       return getEShopApi();
//     }
//   }
//
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'eshop_model_class.dart';

class ApiServices {
  Future<EshopModel> getEShopApi() async {
    Uri uri = Uri.parse("https://dummyjson.com/products");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var convert = EshopModel.fromJson(data);
      return convert;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
