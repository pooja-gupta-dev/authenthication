import 'package:flutter/material.dart';
import 'api_service_screen.dart';
import 'eshop_model_class.dart';


class EshopProvider with ChangeNotifier {
  EshopModel? _eshopModel;
  bool _isLoading = false;
  String? _errorMessage;

  EshopModel? get eshopModel => _eshopModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final ApiServices _apiServices = ApiServices();

  Future<void> fetchEshopData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _eshopModel = await _apiServices.getEShopApi();
    } catch (error) {
      _errorMessage = error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
