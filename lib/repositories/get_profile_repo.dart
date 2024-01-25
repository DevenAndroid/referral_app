import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:referral_app/models/verify_otp_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/categories_model.dart';
import '../models/get_profile_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<GetProfileModel> getProfileRepo() async {


  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // VerifyOtpModel? user =
  // VerifyOtpModel.fromJson(jsonDecode(sharedPreferences.getString('cookie')!));
  //
  // final headers = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   HttpHeaders.acceptHeader: 'application/json',
  //   HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  // };
  // try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.userProfile),
      headers: await getAuthHeader()
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
  }
  // catch (e) {
  //   return GetProfileModel(message: e.toString(), status: false, data: null);
  // }
// }
