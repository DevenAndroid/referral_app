import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/Pages_model.dart';
import '../models/categories_model.dart';
import '../models/get_profile_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<PagesModel> getPagesRepo({required slug}) async {
  try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.pages + slug),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return PagesModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return PagesModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return PagesModel(message: e.toString(), status: false, data: null);
  }
}
