import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';

import '../models/model_resend_otp.dart';
import '../models/verify_otp_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<ModelResendOtp> resendOtpRepo({
  email,
  context,
}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};

  map['email'] = email;

  print(map);
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.resendOtp),
      headers: await getAuthHeader(), body: jsonEncode(map));
  log("resend IN DATA${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelResendOtp.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelResendOtp(
      message: jsonDecode(response.body)["message"],
    );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}
