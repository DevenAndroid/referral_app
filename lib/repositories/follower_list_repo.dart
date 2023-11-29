import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/FollowersList_model.dart';
import '../models/categories_model.dart';
import '../models/get_profile_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<FollowerListModel> getFollowersRepo() async {
  try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.followers),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return FollowerListModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return FollowerListModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return FollowerListModel(message: e.toString(), status: false, data: null);
  }
}
