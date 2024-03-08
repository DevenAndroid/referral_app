import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:referral_app/models/common_response.dart';
import '../models/verify_otp_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<CommonResponse> verifyVersion(versionApp) async {
  var map = <String, dynamic>{};

  map['version_code'] = versionApp;

  print('verify data...${map}');
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.updateVersionUrl),
      headers: await getAuthHeader(), body: jsonEncode(map));
  log("verify IN DATA${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    // Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return CommonResponse.fromJson(jsonDecode(response.body));
  } else {
    // Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return CommonResponse(
      message: jsonDecode(response.body)["message"],
    );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}
