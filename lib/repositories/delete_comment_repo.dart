import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/common_response.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<CommonResponse> deleteCommentRepo({context, deleteId}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};

  map['comment_id'] = deleteId;
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.deleteCommentUrl),
      headers: await getAuthHeader(), body: jsonEncode(map));
  log("block api IN DATA${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return CommonResponse.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return CommonResponse(
      message: jsonDecode(response.body)["message"],
    );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}



Future<CommonResponse> reportRepo({context, deleteId}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};

  map['comment_id'] = deleteId;
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.reportCommentUrl),
      headers: await getAuthHeader(), body: jsonEncode(map));
  log("block api IN DATA${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return CommonResponse.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return CommonResponse(
      message: jsonDecode(response.body)["message"],
    );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}


