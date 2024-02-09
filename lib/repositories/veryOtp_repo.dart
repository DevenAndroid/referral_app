import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';

import '../models/verify_otp_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<VerifyOtpModel> verifyOtpRepo({email, context, otp,token}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};

  map['email'] = email;
  map['otp'] = otp;
  map['device_token'] = token;

  print('verify data...${map}');
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.verifyOtp),
      headers: await getAuthHeader(), body: jsonEncode(map));
  log("verify IN DATA${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) ); 

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return VerifyOtpModel.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return VerifyOtpModel(
      message: jsonDecode(response.body)["message"],
    );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}
