import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/add_remove_recommendation.dart';
import '../models/delete_recomm.dart';
import '../models/login_model.dart';

import '../models/remove_reomeendation.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<ModelDeleteRecomm> deleteRecommRepo({recommandation_id,context,}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};

  map['recommandation_id'] = recommandation_id;


  print(map);
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.deleteRecommand),
      headers: await getAuthHeader(),
      body: jsonEncode(map));
  log("Sign IN DATA${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelDeleteRecomm.fromJson(jsonDecode(response.body));

  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelDeleteRecomm(message: jsonDecode(response.body)["message"], );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}

Future<ModelDeleteRecomm> deleteMyRequest({askRecommandationId,context,}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};

  map['askRecommandation_id'] = askRecommandationId;


  print(map);
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.deleteMyRequest),
      headers: await getAuthHeader(),
      body: jsonEncode(map));
  log("delete My Request Data..${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelDeleteRecomm.fromJson(jsonDecode(response.body));

  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelDeleteRecomm(message: jsonDecode(response.body)["message"], );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}