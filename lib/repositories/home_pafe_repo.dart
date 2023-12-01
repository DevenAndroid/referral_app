import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/home_page_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<HomeModel> getHomeRepo({required int pagination,required int page}) async {
  try {
    http.Response response = await http.get(
      Uri.parse('${ApiUrls.home}?pagination=$pagination&page=$page'),
      headers: await getAuthHeader(),
    );


    print("Home>>>>>${response.body}");

    if (response.statusCode == 200) {
      return HomeModel.fromJson(jsonDecode(response.body));
    } else {
      return HomeModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return HomeModel(message: e.toString(), status: false, data: null);
  }
}
