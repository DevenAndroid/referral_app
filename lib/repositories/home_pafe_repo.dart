import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/home_page_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<HomeModel> getHomeRepo() async {
  try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.home),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return HomeModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return HomeModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return HomeModel(message: e.toString(), status: false, data: null);
  }
}
