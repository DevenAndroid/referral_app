import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/add_comment_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<AddCommentModel> addCommentRepo({
  postId,
  type,
  comment,
  context
}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};

  map['post_id'] = postId;
  map['type'] = type;
  map['comment'] = comment;

  print('add comment map is..${map}');
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.addComment),
      headers: await getAuthHeader(), body: jsonEncode(map));
  log("add comment IN DATA${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return AddCommentModel.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return AddCommentModel(
      message: jsonDecode(response.body)["message"],
    );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}
