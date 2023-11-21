

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<CategoriesModel> getCategoriesRepo() async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.categories),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return CategoriesModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return CategoriesModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return CategoriesModel(message: e.toString(), status: false, data: null);
  }
}
