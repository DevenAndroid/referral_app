import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/all_recommendation_model.dart';
import '../models/categories_model.dart';
import '../models/get_profile_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<AllRecommendationModel> getAllRepo() async {
  try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.allRecommendation),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return AllRecommendationModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return AllRecommendationModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return AllRecommendationModel(message: e.toString(), status: false, data: null);
  }
}
