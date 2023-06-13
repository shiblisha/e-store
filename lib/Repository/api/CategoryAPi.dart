import 'dart:convert';

import 'package:http/http.dart';

import '../modelclass/ProductsModel.dart';
import 'api_client.dart';

class CategoryApi {
  ApiClient apiClient = ApiClient();

  Future<CategoryModel> getCategory(
  {required String endingpath}
    ) async {

    String path = 'https://dummyjson.com/products/category/${'endingpath'}';

    Response response =
    await apiClient.invokeAPI(path, 'GET12',null);

    return CategoryModel.fromJson(jsonDecode(response.body));
  }
}