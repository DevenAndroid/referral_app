import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/add_remove_recommendation.dart';
import '../models/login_model.dart';

import '../models/model_add_remove_like.dart';
import '../models/remove_reomeendation.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<ModelLikesAdd> addRemoveLikeRepo({recommended_id,context,}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};

  map['recommended_id'] = recommended_id;


  print(map);
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.addRemoveLike),
      headers: await getAuthHeader(),
      body: jsonEncode(map));
  log("Sign IN DATA${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelLikesAdd.fromJson(jsonDecode(response.body));

  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelLikesAdd(message: jsonDecode(response.body)["message"], );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}