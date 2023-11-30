import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/all_user_model.dart';
import '../models/categories_model.dart';
import '../models/get_profile_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<AllUserModel> getUserRepo() async {
  try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.allUsers),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return AllUserModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return AllUserModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return AllUserModel(message: e.toString(), status: false, data: null);
  }
}
