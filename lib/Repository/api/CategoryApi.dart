import 'dart:convert';

import 'package:e_store/Repository/modelclass/CategoryModel.dart';
import 'package:http/http.dart';

import 'api_client.dart';

class CategoryApi {
  ApiClient apiClient = ApiClient();

  Future<CategoryModel> getCategory(
      ) async {

    String path = 'https://dummyjson.com/products/categories';

    Response response =
    await apiClient.invokeAPI(path, 'GET12',null);

    return CategoryModel.fromJson(jsonDecode(response.body));
  }
}