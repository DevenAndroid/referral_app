import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/get_profile_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<GetProfileModel> getProfileRepo() async {
  try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.userProfile),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return GetProfileModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return GetProfileModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return GetProfileModel(message: e.toString(), status: false, data: null);
  }
}
