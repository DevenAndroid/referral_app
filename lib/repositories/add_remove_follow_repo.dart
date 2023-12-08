import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/add_remove_recommendation.dart';
import '../models/login_model.dart';

import '../models/remove_reomeendation.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<ModelAddRemoveFollow> addRemoveRepo({following_id,context,}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};

  map['following_id'] = following_id;


  print(map);
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.addRemoveFollower),
      headers: await getAuthHeader(),
      body: jsonEncode(map));
  log("Sign IN DATA${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelAddRemoveFollow.fromJson(jsonDecode(response.body));

  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelAddRemoveFollow(message: jsonDecode(response.body)["message"], );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}