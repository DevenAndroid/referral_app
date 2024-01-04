import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/get_comment_model.dart';
import '../models/model_review_list.dart';

import '../models/single_product_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<GetCommentModel> getCommentRepo({context,id, type}) async {
  try {
    http.Response response = await http.get(Uri.parse("${ApiUrls.getComment}?post_id=$id&type=$type"),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return GetCommentModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return GetCommentModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return GetCommentModel(message: e.toString(), status: false, data: null);
  }
}
